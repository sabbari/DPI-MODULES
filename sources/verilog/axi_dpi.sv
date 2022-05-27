module axi_dpi(
 output reg           masterAxi_aw_valid,
  input               masterAxi_aw_ready,
  output     [12:0]   masterAxi_aw_payload_addr,
  output     [7:0]    masterAxi_aw_payload_len,
  output     [2:0]    masterAxi_aw_payload_size,
  output     [1:0]    masterAxi_aw_payload_burst,
  output reg          masterAxi_w_valid,
  input               masterAxi_w_ready,
  output     [31:0]   masterAxi_w_payload_data,
  output     [3:0]    masterAxi_w_payload_strb,
  output              masterAxi_w_payload_last,
  input               masterAxi_b_valid,
  output              masterAxi_b_ready,
  input      [1:0]    masterAxi_b_payload_resp,
  output reg          masterAxi_ar_valid,
  input               masterAxi_ar_ready,
  output     [12:0]   masterAxi_ar_payload_addr,
  output     [7:0]    masterAxi_ar_payload_len,
  output     [2:0]    masterAxi_ar_payload_size,
  output     [1:0]    masterAxi_ar_payload_burst,
  input               masterAxi_r_valid,
  output              masterAxi_r_ready,
  input      [31:0]   masterAxi_r_payload_data,
  input      [1:0]    masterAxi_r_payload_resp,
  input               masterAxi_r_payload_last,
  input               clk,
  input               reset
);






import "DPI-C" context function int axi_server(
                      output int write,
                      output int addr,
                      output int wdata_valid,
                      output int rdata_ready,
                      output int wdata_payload,
                      input int rsp,
                      input int rdata_payload,
                      input int rdata_valid,
                      input int wdata_ready,
                      input int port,
                      input int blocking
);


wire [31:0] addr;
wire [31:0] wdata_payload;
wire [31:0] rdata_payload;
wire [1:0] rsp;
wire write;
wire wdata_valid;
wire rdata_ready;
wire rdata_valid;
wire wdata_ready;
always @(posedge clk)
begin

	axi_server(write,addr,wdata_valid,rdata_ready,wdata_payload,rsp,rdata_payload,rdata_valid,wdata_ready,7897,1);
    	
end

aximaster simpleAxi4Master(
  .masterAxi_aw_valid(masterAxi_aw_valid),
  .masterAxi_aw_ready(masterAxi_aw_ready),
  .masterAxi_aw_payload_addr(masterAxi_aw_payload_addr),
  .masterAxi_aw_payload_len(masterAxi_aw_payload_len),
  .masterAxi_aw_payload_size(masterAxi_aw_payload_size),
  .masterAxi_aw_payload_burst(masterAxi_aw_payload_burst),
  .masterAxi_w_valid(masterAxi_w_valid),
  .masterAxi_w_ready(masterAxi_w_ready),
  .masterAxi_w_payload_data(masterAxi_w_payload_data),
  .masterAxi_w_payload_strb(masterAxi_w_payload_strb),
  .masterAxi_w_payload_last(masterAxi_w_payload_last),
  .masterAxi_b_valid(masterAxi_b_valid),
  .masterAxi_b_ready(masterAxi_b_ready),
  .masterAxi_b_payload_resp(masterAxi_b_payload_resp),
  .masterAxi_ar_valid(masterAxi_ar_valid),
  .masterAxi_ar_ready(masterAxi_ar_ready),
  .masterAxi_ar_payload_addr(masterAxi_ar_payload_addr),
  .masterAxi_ar_payload_len(masterAxi_ar_payload_len),
  .masterAxi_ar_payload_size(masterAxi_ar_payload_size),
  .masterAxi_ar_payload_burst(masterAxi_ar_payload_burst),
  .masterAxi_r_valid(masterAxi_r_valid),
  .masterAxi_r_ready(masterAxi_r_ready),
  .masterAxi_r_payload_data(masterAxi_r_payload_data),
  .masterAxi_r_payload_resp(masterAxi_r_payload_resp),
  .masterAxi_r_payload_last(masterAxi_r_payload_last),
  .tcpBus_write(write),
  .tcpBus_addr(addr),
  .tcpBus_wdata_valid(wdata_valid),
  .tcpBus_wdata_ready(wdata_ready),
  .tcpBus_wdata_payload(wdata_payload),
  .tcpBus_rdata_valid(rdata_valid),
  .tcpBus_rdata_ready(rdata_ready),
  .tcpBus_rdata_payload(rdata_payload),
  .tcpBus_rsp(rsp),
  .clk(clk),
  .reset(reset)
);



endmodule
