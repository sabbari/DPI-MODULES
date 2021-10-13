# DPI-MODULES
The projects contains the following modules : 
- spi slave : that writes the characters received to stdout.
- spi master : opens a tcp port, then establish a bidirectionnal communication, the user can use tcp_clients/spi_tcpclient.py to send and display the received characters.
- jtag slave : opens a tcp port, then drives tck, tdi, tms, and/or sends back tdo vlaues, according the the received value on that port.
  
  
# Folder contents :
```bash 
├── includes
│   └── tcp_functions.h
├── sources
│   ├── c
│   │   ├── jtag.c
│   │   ├── main.c
│   │   ├── spi.c
│   │   └── tcp_functions.c
│   └── verilog
│       ├── jtag_dpi.sv
        ├── spi_slave.v
│       ├── spiMaster_dpi.sv
│       └── spiSlave_dpi.sv
└── tcp_clients
    └── spi_tcpclient.py
```
