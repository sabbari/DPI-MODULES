// #include "vpi_user.h"




#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include <fcntl.h>
#include <stdio.h>  // perror, printf
#include <stdlib.h> // exit, atoi
#include <string.h> // memset
#include <unistd.h> // read, write, close
#include <errno.h>
#include "../../includes/tcp_functions.h"

//#define printf vpi_printf




/*
Create a socket and return the socket file descriptor number
*/

int create_socket(int *socketFd){

  *socketFd = socket(AF_INET, SOCK_STREAM, 0);
  if (*socketFd < 0) {
    perror("Cannot create socket");
   exit(EXIT_FAILURE);
  }else {
      return *socketFd ;
  }

}
int bind_port(int port,struct sockaddr_in* server,int* serverFd){
    memset(server, 0, sizeof(*server));
    server->sin_family = AF_INET;
    server->sin_addr.s_addr = inet_addr("127.0.0.1"); // INADDR_ANY;
    server->sin_port = htons(port);
    int len = sizeof(*server);
    if (bind(*serverFd,(struct sockaddr *)server, len) < 0) {
        perror("Cannot bind socket");
         exit(EXIT_FAILURE);
        }
    return 1;
}

int listen_to_socket(int * socketFd){
      if (listen(*socketFd, 10) < 0) {
        perror("Listen error");
        exit(EXIT_FAILURE);
  }
  else return 1;

}
int accept_client(struct sockaddr_in* client, int port,int* clientFd, int * serverFd , int blocking) {
   socklen_t len = sizeof(*client);
  if(blocking==0)    fcntl(*serverFd, F_SETFL, O_NONBLOCK);

  if ((*clientFd = accept(*serverFd, (struct sockaddr *)client, &len)) < 0) {
    if(errno=EAGAIN ) return 0;
    perror("accept error");
    exit(EXIT_FAILURE);
  }
  char *client_ip = inet_ntoa(client->sin_addr);
  printf("Accepted new connection from a client %s:%d\n", client_ip,
         ntohs(client->sin_port));

  int flags = fcntl(*clientFd, F_GETFL, 0);
  fcntl(*clientFd, F_SETFL, flags | O_NONBLOCK);
  return 1;

}
int receive_from_client(int clientFd, void *buffer ){
  //memset(buffer, 0, sizeof(buffer));
  return read(clientFd, buffer, sizeof(buffer));
  // int size = read(clientFd, buffer, sizeof(buffer));
  // if (size < 0) {
  //  // perror("read error");
  //   return -1;
  // }
  // return size;

}
int send_to_client(int clientFd, unsigned char *buffer, int size){
    int sent = write(clientFd, buffer, size);
    if (sent < 0) {
        perror("write error");
        return -1;
        }
    return sent;
}