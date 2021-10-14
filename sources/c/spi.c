#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include <fcntl.h>
#include <stdio.h>  // perror, printf
#include <stdlib.h> // exit, atoi
#include <string.h> // memset
#include <unistd.h> // read, write, close
#include "../../includes/tcp_functions.h"
 #include "svdpi.h"
enum STATE {OPEN_PORT,SETUP_SPI,RECEIVE,END_SPI,SEND_SPI,WAIT_CLIENT};
enum CLOCKSTATE {LOW,HIGH };
#define DEBUG 0
#define BUFFER_SIZE 32
extern int spi_master(svBit *spi_cs, svBit *spi_sclk, svBit *spi_mosi,
                     const unsigned int spi_miso, int port,int blocking) {

  static unsigned char buffer[BUFFER_SIZE],miso_buffer[BUFFER_SIZE];
  static int size, counter=0;

  static enum STATE state=OPEN_PORT;
  static enum CLOCKSTATE clock_state = LOW;
  static int clientFd, serverFd; // client and server file descriptor
  static struct sockaddr_in server, client;
  static unsigned int buffer_index = 0;
  int i = counter % 8;
  switch (state) {
  case(OPEN_PORT):
      create_socket(&serverFd);
      bind_port(port,&server,&serverFd);
      listen_to_socket(&serverFd);
      printf("connect you spi tcp client \n");
      printf("waiting for clients at port %d \n", port);
      //accept_client(&client,port,&clientFd,&serverFd);
      state =WAIT_CLIENT;
  case (WAIT_CLIENT):
     state = accept_client(&client,port,&clientFd,&serverFd,blocking)==0? WAIT_CLIENT:RECEIVE;
     if(state==WAIT_CLIENT) return 1;
  case (RECEIVE):
    counter = 0;
    buffer_index = 0;
    *spi_cs = 1;
    size = read(clientFd, buffer,sizeof(buffer));
    state = size > 0 ? SETUP_SPI : RECEIVE;
    return 1;

  case (SETUP_SPI):
    *spi_cs = 0;
    *spi_sclk = 1;
    state = SEND_SPI;
    return 1;

  case (SEND_SPI):

    *spi_mosi = buffer[buffer_index] & 1 << (7 - i) ? 1 : 0;

    switch (clock_state) {

    case (LOW):
      *spi_sclk = LOW;
      clock_state = HIGH;
      return 1;

    case (HIGH):
      *spi_sclk = HIGH;
      clock_state = LOW;
      counter = counter + 1;
      miso_buffer[buffer_index] = miso_buffer[buffer_index] << 1 | spi_miso;

      if (i == 7) {
        if (buffer_index == (size - 1)) {
          state = END_SPI;
          return 1;
        } else {
          buffer_index = buffer_index + 1;
          return 1;
        }
      }
      return 1;
    }

  case (END_SPI):
    *spi_cs = HIGH;
    *spi_sclk = HIGH;
    state = RECEIVE;
    int sent = send_to_client(clientFd, miso_buffer, size);
    if (sent < size) {
      perror("Couldn't send all miso buffer to client ");
      return -1;
    }
    return 0;
  }
}
extern int spi_slave(const unsigned int  spi_cs, const unsigned int  spi_sclk, const unsigned int spi_mosi,
                     svBit *spi_miso, int port) {

  static unsigned char buffer[BUFFER_SIZE];
  static int size, counter, state,debug_count = 0;

  static int clientFd, serverFd; // client and servet file descriptor
  static struct sockaddr_in server, client;
  static unsigned int buffer_index = 0;
  int print_index=0;
  int i = counter % 8;
  *spi_miso =0;

	switch(state){
  case(0) :
        if (spi_cs ==1){
          state =1;
          }
        else if(spi_sclk== HIGH ){
	      
            buffer[buffer_index] =(buffer[buffer_index]<<1 | (spi_mosi&1));
            counter=counter+1;
	          if(i==7) buffer_index=buffer_index+1;
	      	    return 1 ;
            }
  	
	case(1):
	  if(buffer_index)buffer_index = (i==0) ? buffer_index-1 :buffer_index;
	  for(print_index =0; print_index<=buffer_index;print_index++) printf("%c",buffer[print_index]);
	  fflush(stdout);
	  state=0;
	  counter = 0;
	  buffer_index=0;
	  return 1;
	
}
  

}
