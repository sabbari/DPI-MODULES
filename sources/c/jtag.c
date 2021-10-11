
#include <stdio.h>  // perror, printf
#include <stdlib.h> // exit, atoi
#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include "../../includes/tcp_functions.h"

#define OPEN_PORT 0
#define RECEIVE_JTAG_BUFFER 1
#define DRIVE_JTAG_SIGNALS 2
#define SEND_TDO           3

#define svBit int 
extern int jtag_server(svBit *tck, svBit *tms, svBit *tdi,
                     const unsigned int tdo, int port) {

  static unsigned char buffer[1],tobesent_buffer[1];
  static int state,size=0;
  static int clientFd, serverFd; // client and server file descriptor
  static struct sockaddr_in server, client;
  if(state==OPEN_PORT){
    create_socket(&serverFd);
    bind_port(port,&server,&serverFd);
    listen_to_socket(&serverFd);
    accept_client(&client,port,&clientFd,&serverFd);
    state=RECEIVE_JTAG_BUFFER;}

  if (state==RECEIVE_JTAG_BUFFER){ 
       if(read(clientFd, buffer,sizeof(buffer)) > 0){
       state= DRIVE_JTAG_SIGNALS;
        return 1;
      }

    else return 0;}

  if (state==DRIVE_JTAG_SIGNALS){
        *tms = (buffer[0] & 1) != 0;
        *tdi = (buffer[0] & 2) != 0;
        *tck = (buffer[0] & 8) != 0;
        state=(buffer[0] & 4)? SEND_TDO:RECEIVE_JTAG_BUFFER;
      
}
  if(state==SEND_TDO)
{    state = RECEIVE_JTAG_BUFFER;
    tobesent_buffer[0]=tdo;
    if (send_to_client(clientFd, tobesent_buffer,1) < 1) {
      perror("Couldn't send all tdo buffer to client,retrying ... ");
      state =RECEIVE_JTAG_BUFFER;
      return -1;
    }
  
    state = RECEIVE_JTAG_BUFFER;
    return 0;}
 
}

