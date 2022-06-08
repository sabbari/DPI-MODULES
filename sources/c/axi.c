
#include <stdio.h>     // perror, printf
#include <stdlib.h>    // exit, atoi
#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include "../../includes/tcp_functions.h"
#include "svdpi.h"
#include <unistd.h> // read, write, close
#include <sys/ioctl.h>
#include <errno.h>
//#include "vpi_user.h"

enum STATE
{
  OPEN_PORT=0,
  WAIT_CLIENT,
  RECEIVE_CMD,
  DRIVE_WRITE_AXI,
  DRIVE_READ_AXI,
  RECEIVE_READ_DATA,
  SEND_WRITE_RESP,
  SEND_READ_RESP,
  SIM_EXIT
};
int saferead(int fd, const void *p, size_t want) {
  int ret;

   errno = 0;
   while (want) {
      ret = read(fd, (uint8_t*)p, want);
      if( ret == 0 )
         return -1;  /* EOF */
      if (ret <= 0) {
         if( errno != EINTR && errno != EAGAIN ) {
            return -1;
         }
         errno = 0;
         continue;
      }
      want -= ret;
      p = (uint8_t*) p + ret;
   }
   return 0;
}
extern int axi_server(
                      int *addr,
                      int *size,
                      int *wdata_valid,
                      const unsigned int wdata_ready,
                      int *wdata_payload0,
                      int *wdata_payload1,
                      int *wdata_payload2,
                      int *wdata_payload3,
                      int *wdata_last,
                      int *rdata_ready,
                      const unsigned int rdata_payload0,
                      const unsigned int rdata_payload1,
                      const unsigned int rdata_payload2,
                      const unsigned int rdata_payload3,
                      const unsigned int rdata_valid,
                      const unsigned int rdata_last,
                      const unsigned int rsp_payload,
                      const unsigned int rsp_valid,                      
                      int port, int blocking,
                      int word_size,
                      int *datacount)
{

	static unsigned char buffer[256], tobesent_buffer[32];
  static unsigned int write_data_count=0,read_data_count=0;
  *datacount=write_data_count;
  static enum STATE state = OPEN_PORT;
  static int clientFd, serverFd; // client and server file descriptor
  static struct sockaddr_in server, client;
  int available_bytes=0;

  enum { size_size = 4};
  enum { data_size = 256*128/8 };//AXI4 supports up to 256 transfers. we support word of up to 128bits.
  enum { mask_size = 4};
  enum { addr_size = 4};
  enum { flags_size = 4};
  enum { buffer_size = data_size + mask_size + addr_size + flags_size + size_size};
  static uint32_t rxBuffer[buffer_size / sizeof(uint32_t)] = {0};
    uint32_t actual_size = mask_size + addr_size + flags_size + size_size;
    uint32_t size_idx = 0;
    uint32_t flags_idx = size_idx + (size_size / sizeof(uint32_t));
    uint32_t data_idx = flags_idx + (flags_size / sizeof(uint32_t));
    uint32_t mask_idx = data_idx + (data_size / sizeof(uint32_t));
    uint32_t addr_idx = mask_idx + (mask_size / sizeof(uint32_t));

  	static unsigned int read_buffer[256*128/(32)]={0},read_resp;


    *addr = rxBuffer[addr_idx];
    *size =(rxBuffer[size_idx])/16;
    *wdata_last=0;
//	printf("state %d \n", state);
  if (state == OPEN_PORT)
  {
    create_socket(&serverFd);
    bind_port(port, &server, &serverFd);

    listen_to_socket(&serverFd);
    printf("connect you AXI4 tcp client \n");
    printf("waiting for clients at port %d \n", port);
    state = WAIT_CLIENT;
  }
  if (state == WAIT_CLIENT)
  {
    state = accept_client(&client, port, &clientFd, &serverFd, blocking) == 0 ? WAIT_CLIENT : RECEIVE_CMD;
    if (state == WAIT_CLIENT)
      return 1;
  }

  if (state == RECEIVE_CMD)
  {
    *wdata_valid=0;
    ioctl(clientFd, FIONREAD, &available_bytes);
    if(available_bytes<=0)return 1;
    printf("RECEIVE_CMD \n");
    saferead(clientFd, rxBuffer+size_idx, size_size);
    saferead(clientFd, rxBuffer+flags_idx, flags_size);
    if(rxBuffer[flags_idx] & 1){
      printf("receiveing data \n");
      saferead(clientFd, rxBuffer+data_idx, rxBuffer[size_idx]);
      printf("first received data %08X \n",rxBuffer[data_idx]);
      }
    saferead(clientFd,rxBuffer+mask_idx,mask_size);
    saferead(clientFd, rxBuffer+addr_idx, addr_size);
    printf("size %08X, flags %08X, wdata0 %08X, mask %08X, addr %08X  \n",rxBuffer[size_idx],rxBuffer[flags_idx],rxBuffer[data_idx],
    rxBuffer[mask_idx],rxBuffer[addr_idx]);
    write_data_count=0;
    state = (rxBuffer[flags_idx] & 1)? DRIVE_WRITE_AXI:DRIVE_READ_AXI;
    state=(!rxBuffer[size_idx])? SIM_EXIT:state;
    return  1; 
  }

  if (state == DRIVE_WRITE_AXI)
  { 
     
      printf("DRIVE_WRITE_AXI, write_data_count=%d,rxBuffer[size_idx]= %d, wdata_ready=%d, size %d \n",write_data_count,rxBuffer[size_idx],wdata_ready&1,*size);
      write_data_count=(wdata_ready&1)? write_data_count+1:write_data_count;
      *wdata_payload0=rxBuffer[data_idx+write_data_count*word_size/sizeof(uint32_t)+0];
      *wdata_payload1=rxBuffer[data_idx+write_data_count*word_size/sizeof(uint32_t)+1];
      *wdata_payload2=rxBuffer[data_idx+write_data_count*word_size/sizeof(uint32_t)+2];
      *wdata_payload3=rxBuffer[data_idx+write_data_count*word_size/sizeof(uint32_t)+3];
      state = (((write_data_count)*word_size)==(rxBuffer[size_idx]))?SEND_WRITE_RESP:DRIVE_WRITE_AXI;
      *wdata_last=(((write_data_count+1)*4*4)==(rxBuffer[size_idx]))?1:0;
      *wdata_valid= 1;
      return 1;
    
  }
  if(state==DRIVE_READ_AXI){
    printf("DRIVE_READ_AXI \n");
      *rdata_ready=1;
      state=RECEIVE_READ_DATA;
      read_data_count=0;
      return 1;


  }
  if(state==RECEIVE_READ_DATA){

    if(!rdata_valid)return 1 ;
   // printf("receive read data, %d , 0=%08X, 1=%08X, 2=%08X, 3=%08X \n",read_data_count,rdata_payload0,rdata_payload1,
  //  rdata_payload2,rdata_payload3);
    *rdata_ready=0;
    read_buffer[read_data_count+0]=rdata_payload0;
    read_buffer[read_data_count+1]=rdata_payload1;
    read_buffer[read_data_count+2]=rdata_payload2;
    read_buffer[read_data_count+3]=rdata_payload3;
    read_resp=rsp_payload;
    if(rdata_last)state=SEND_READ_RESP;
    read_data_count+=word_size/sizeof(uint32_t);
    return 1;

  }
  if(state==SEND_WRITE_RESP){
      *wdata_last=0;
      *wdata_valid=0;
      if(rsp_valid != 1) return 1;
      unsigned int tmp=0x11223344;
      send_to_client(clientFd,(unsigned char *) &tmp, 4);
      tmp=0;
      for (int i=0; i<rxBuffer[size_idx];i++) send_to_client(clientFd,(unsigned char *)&tmp, 1);
      tmp=rsp_payload;
      send_to_client(clientFd,(unsigned char *) &tmp, 1);
      state=RECEIVE_CMD;
      printf("sent write resp \n");
      return 1;

  }



  if (state == SEND_READ_RESP)
  {
        printf("read_data_count %d\n",read_data_count);
        //for (int i=0;i<256/4;i++)printf("data to be sent : %08X\n",read_buffer[i]);
        unsigned int tmp=0x55667788;
	      send_to_client(clientFd,(unsigned char *) &tmp, 4);   
        send_to_client(clientFd,(unsigned char *) read_buffer, rxBuffer[size_idx]);
        send_to_client(clientFd,(unsigned char *) &read_resp, 1);
	      state=RECEIVE_CMD;
        return 1;
      
    }
    if(state==SIM_EXIT){
        
        uint64_t tmp=0x12345678;
	      send_to_client(clientFd,(unsigned char *) &tmp, 8);   
        tmp=0;
	      send_to_client(clientFd,(unsigned char *) &tmp, 1);   
        return 0xdead;
    }
  
  return 0;
}
