module spiSlave_dpi(
    input  spi_clk_i,
    input  spi_mosi_i,
    input  spi_cs_i,
    output reg spi_miso_o
);






import "DPI-C" context function int spi_slave( input bit spi_cs,
                                             input bit spi_sclk,
                                             input bit spi_mosi,
                                             output bit spi_miso); 




always @(posedge spi_clk_i,spi_cs_i)
begin

	spi_slave(spi_cs_i,spi_clk_i,spi_mosi_i,spi_miso_o,port);

    	
end
endmodule
