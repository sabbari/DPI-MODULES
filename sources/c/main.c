#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include <fcntl.h>
#include <stdio.h>  // perror, printf
#include <stdlib.h> // exit, atoi
#include <string.h> // memset
#include <unistd.h> // read, write, close

#include "../../includes/tcp_functions.h"
int main()
{
  int i = 0;
  int *write;
  int *addr;
  int *wdata_valid;
  int *rdata_ready;
  int *wdata_payload;
  const unsigned int rsp;
  const unsigned int rdata_payload;
  const unsigned int rdata_valid;
  const unsigned int wdata_ready;
  while (1)
  {
    axi_server(write,
               addr,
               wdata_valid,
               rdata_ready,
               wdata_payload,
               rsp,
               rdata_payload, rdata_valid,
               wdata_ready,
               7897,
                1);
    sleep(1);
  }
}