
#include <stdio.h>     // perror, printf
#include <stdlib.h>    // exit, atoi
#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include "../../includes/tcp_functions.h"
#include "svdpi.h"
#include <unistd.h> // read, write, close
#include <errno.h>
//#include "vpi_user.h"

enum STATE
{
  OPEN_PORT=0,
  WAIT_CLIENT,
  RECEIVE_CMD,
  DRIVE_AXI,
  SEND_RESP
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
extern int axi_server(int *write,
                      int *addr,
                      int *wdata_valid,
                      int *rdata_ready,
                      int *wdata_payload,
                      const unsigned int rsp,
                      const unsigned int rdata_payload, const unsigned int rdata_valid,
                      const unsigned int wdata_ready,
                      int port, int blocking)
{

	static unsigned char buffer[32], tobesent_buffer[32];
  static unsigned int size, flags, mask, address;

  static enum STATE state = OPEN_PORT;
  static int clientFd, serverFd; // client and server file descriptor
 static struct sockaddr_in server, client;
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
    printf("RECEIVE_CMD \n");
    saferead(clientFd, &size, sizeof(size));
    saferead(clientFd, &flags, sizeof(flags));
    if(flags & 1)saferead(clientFd, buffer, size);
    saferead(clientFd,&mask,4);
    saferead(clientFd, &address, sizeof(address));
    printf("size %08X, flags %08X, wdata %08X, mask %08X, addr %08X  \n",size,flags,((int *)buffer)[0],mask, address);
    state = DRIVE_AXI;
  }

  if (state == DRIVE_AXI)
  {
    printf("DRIVE_AXI \n");
    *addr = address;
    if (flags & 1)
    {
      *write = 1;
      printf("write %d \n",*write);
      *wdata_valid = 1;
      *wdata_payload = ((unsigned int *)buffer)[0];
    }
    else
    {
      *write=0;
      *rdata_ready = 1;
    }
    state = SEND_RESP;
  }
  if (state == SEND_RESP)
  {
    //printf("SEND_RESP\n");

    if (flags & 1)
    {
      if (!wdata_ready)
      {
        return 1;
      }
      else
      {
        unsigned int tmp=0x11223344;
        send_to_client(clientFd,(unsigned char *) &tmp, 4);
        tmp=0;
        send_to_client(clientFd,(unsigned char *) &tmp, size);
        tmp=rsp;
        send_to_client(clientFd,(unsigned char *) &tmp, 1);
        state=RECEIVE_CMD;
        printf("write response sent \n");
        return 1;
      }
    }
    else {
      if(!rdata_valid)
      {
        return 1;
      }
      else
      {
        unsigned int tmp=0x55667788;
        int cnt=0;
	cnt=send_to_client(clientFd,(unsigned char *) &tmp, 4);
        printf("sent dummy %d \n",cnt);
	tmp=rdata_payload;
        cnt=send_to_client(clientFd,(unsigned char *) &tmp, 4);
        printf("rdata %d, size %d \n",cnt,size);
	tmp=rsp;
        cnt=send_to_client(clientFd,(unsigned char *) &tmp, 1);
        printf("sent rsp %d \n",cnt);
	state=RECEIVE_CMD;
        printf("read responsesent \n");
        return 1;
      }
    }
  }
  return 0;
}
