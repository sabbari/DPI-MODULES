
#ifndef TCP_FUNCTIONS_H
#define TCP_FUNCTIONS_H

int receive_from_client(int clientFd, void *buffer);
int send_to_client(int clientFd, unsigned char *buffer, int size);
int create_socket(int* serverFd);
int bind_port(int port,struct sockaddr_in* server,int* serverFd);
int listen_to_socket(int * socketFd);
int accept_client(struct sockaddr_in* client, int port,int* clientFd, int * serverFd,int blocking);

#endif