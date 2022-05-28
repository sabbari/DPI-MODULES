
#include <stdio.h>     // perror, printf
#include <stdlib.h>    // exit, atoi
#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include "../../includes/tcp_functions.h"
#include "svdpi.h"
#include <unistd.h> // read, write, close

//#include "vpi_user.h"

enum STATE
{
  OPEN_PORT=0,
  WAIT_CLIENT,
  RECEIVE_CMD,
  DRIVE_AXI,
  SEND_RESP
};
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
	printf("state %d \n", state);
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
    if(!read(clientFd, &size, sizeof(size)))return 1;
    read(clientFd, &flags, sizeof(flags));
    read(clientFd, buffer, size);
    read(clientFd, &address, sizeof(address));
    state = DRIVE_AXI;
  }

  if (state == DRIVE_AXI)
  {
    printf("DRIVE_AXI \n");
    *addr = address;
    if (flags & 1)
    {
      *write = 1;
      *wdata_valid = 1;
      *wdata_payload = ((unsigned int *)buffer)[0];
    }
    else
    {
      *rdata_ready = 1;
    }
    state = SEND_RESP;
  }
  if (state == SEND_RESP)
  {
    printf("SEND_RESP\n");

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
        send_to_client(clientFd,(unsigned char *) &tmp, 4);
        tmp=rdata_payload;
        send_to_client(clientFd,(unsigned char *) &tmp, size);
        tmp=rsp;
        send_to_client(clientFd,(unsigned char *) &tmp, 1);
        state=RECEIVE_CMD;
        printf("read responsesent \n");
        return 1;
      }
    }
  }
  return 0;
}
