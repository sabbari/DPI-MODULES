module spiSlave(
    input  spi_clk_i,
    input  spi_mosi_i,
    input  spi_cs_i,
    output reg spi_miso_o
);




reg [7:0]  	buffer[0:1023];
integer  	buffer_index	=0;
integer 	counter			=0;
integer 	i				=0;
integer 	state			=0;
integer 	index			=0;



initial begin
  for (index=0;index<1024;index=index+1) buffer[index] = 0  ;  
end

always @(posedge spi_clk_i,spi_cs_i)
begin
    i=counter %8;
	case(state)
    0 :begin
        if(spi_cs_i==1)
            state=1;
            
        else if ( spi_clk_i) begin
            buffer[buffer_index] =(buffer[buffer_index]<<1 | (spi_mosi_i));
            counter =counter+1;
            if (i==7)
                begin
                    buffer_index=buffer_index+1;
                end
        	end
		end 
    1  :begin	

		for (index=0;index<=buffer_index;index=index+1)begin 
			$write("%c",buffer[index])  ;
			$fflush(32'h8000_0001);
			buffer[index]=0;
			end	
		state=0;
		counter=0;
		buffer_index=0;
		end    
	endcase;
end


endmodule

