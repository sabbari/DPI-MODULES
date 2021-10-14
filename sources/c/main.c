#include <arpa/inet.h> // sockaddr_in, AF_INET, SOCK_STREAM, INADDR_ANY, socket etc...
#include <fcntl.h>
#include <stdio.h>  // perror, printf
#include <stdlib.h> // exit, atoi
#include <string.h> // memset
#include <unistd.h> // read, write, close

#include "../../includes/tcp_functions.h"

int main(){
    int i=0;
    int tck,tms,tdi,tdo=0;
    
    while(1) {
            jtag_server(&tck , &tms, &tdi, tdo, 1234,0) ;
              printf("hi %d \n",i);
            i+=1;
            //sleep(1);
                            }


}