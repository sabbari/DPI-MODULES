
#include <stdio.h>  // perror, printf
#include <stdlib.h> // exit, atoi
#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include "../../includes/tcp_functions.h"
#include "svdpi.h"
#include <signal.h>
#include <unistd.h> // read, write, close
void my_handler(int s){
           printf("Caught signal %d\n",s);
           exit(1); 

}
enum STATE {OPEN_PORT,WAIT_CLIENT,RECEIVE_JTAG_BUFFER,DRIVE_JTAG_SIGNALS,SEND_TDO};
extern int jtag_server(svBit *tck, svBit *tms, svBit *tdi,
                     const unsigned int tdo, int port, int blocking ) {

  static unsigned char buffer[1],tobesent_buffer[1];
  static int size=0;
  static enum STATE state =OPEN_PORT;
  static int clientFd, serverFd; // client and server file descriptor
  static struct sockaddr_in server, client;
  static  struct sigaction sigIntHandler;

  if(state==OPEN_PORT){

    sigIntHandler.sa_handler = my_handler;
    sigemptyset(&sigIntHandler.sa_mask);
    sigIntHandler.sa_flags = 0;

    sigaction(SIGINT, &sigIntHandler, NULL);

    create_socket(&serverFd);
    bind_port(port,&server,&serverFd);

    listen_to_socket(&serverFd);
      printf("connect you jtag tcp client \n");
      printf("waiting for clients at port %d \n", port);
      state =WAIT_CLIENT;
     }
  if (state ==WAIT_CLIENT){
      state = accept_client(&client,port,&clientFd,&serverFd,blocking)==0? WAIT_CLIENT:RECEIVE_JTAG_BUFFER;
      if(state==WAIT_CLIENT) return 1;
      }

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

