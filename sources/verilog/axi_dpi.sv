







module axi_dpi(
  input               clk,
  input               reset,
  output reg          masterAxi_aw_valid,
  input               masterAxi_aw_ready,
  output     [31:0]   masterAxi_aw_payload_addr,
  output     [7:0]    masterAxi_aw_payload_len,
  output     [2:0]    masterAxi_aw_payload_size,
  output     [1:0]    masterAxi_aw_payload_burst,
  output reg          masterAxi_w_valid,
  input               masterAxi_w_ready,
  output     [127:0]  masterAxi_w_payload_data,
  output     [15:0]   masterAxi_w_payload_strb,
  output reg          masterAxi_w_payload_last,
  input               masterAxi_b_valid,
  output              masterAxi_b_ready,
  input      [1:0]    masterAxi_b_payload_resp,
  output reg          masterAxi_ar_valid,
  input               masterAxi_ar_ready,
  output     [31:0]   masterAxi_ar_payload_addr,
  output     [7:0]    masterAxi_ar_payload_len,
  output     [2:0]    masterAxi_ar_payload_size,
  output     [1:0]    masterAxi_ar_payload_burst,
  input               masterAxi_r_valid,
  output reg          masterAxi_r_ready,
  input      [127:0]  masterAxi_r_payload_data,
  input      [1:0]    masterAxi_r_payload_resp,
  input               masterAxi_r_payload_last
);






import "DPI-C" context function int axi_server(
                      output int addr,
                      output int size,
                      output bit wdata_valid,
                      input  bit wdata_ready,
                      output int wdata_payload0,
                      output int wdata_payload1,
                      output int wdata_payload2,
                      output int wdata_payload3,
                      output bit  wdata_last,
                      output bit rdata_ready,
                      input int rdata_payload0,
                      input int rdata_payload1,
                      input int rdata_payload2,
                      input int rdata_payload3,
                      input bit rdata_valid,
                      input bit rdata_last,
                      input int rsp_payload,
                      input int rsp_valid,
                      input int port,
                      input int blocking,
                      output int datacount
);

parameter port = 7897;
parameter blocking = 1;
reg [31:0]  addr,size,datacount;
reg [31:0] wdata_payload0,wdata_payload1,wdata_payload2,wdata_payload3;
wire [31:0] rdata_payload0,rdata_payload1,rdata_payload2,rdata_payload3;
wire [1:0] rsp_payload;
wire  rsp_valid;
reg write;
reg wdata_valid,wdata_last;
reg rdata_ready;
wire rdata_valid,rdata_last;
wire wdata_ready;
int value ;
always @(posedge clk)
begin

	axi_server(addr,
            size,
            wdata_valid,
            wdata_ready,
            wdata_payload0,
            wdata_payload1,
            wdata_payload2,
            wdata_payload3,
            wdata_last,
            rdata_ready,
            rdata_payload0,
            rdata_payload1,
            rdata_payload2,
            rdata_payload3,
            rdata_valid,
            rdata_last,
            rsp_payload,
            rsp_valid,
            port,
            blocking,
            datacount);    	
end

 simpleAxi4Master aximaster(
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
  .tcpBus_addr                   (addr[31:0]), //i
  .tcpBus_wdata_valid            (wdata_valid), //i
  .tcpBus_wdata_ready            (wdata_ready), //o
  .tcpBus_wdata_payload_last     (wdata_last), //i
  .tcpBus_wdata_payload_fragment ({wdata_payload3,wdata_payload2,wdata_payload1,wdata_payload0}), //i
  .tcpBus_size                   (size), //i
  .tcpBus_rdata_valid            (rdata_valid), //o
  .tcpBus_rdata_ready            (rdata_ready), //i
  .tcpBus_rdata_payload_last     (rdata_last), //o
  .tcpBus_rdata_payload_fragment ({rdata_payload3,rdata_payload2,rdata_payload1,rdata_payload0}), //o
  .tcpBus_rsp_valid              (rsp_valid), //o
  .tcpBus_rsp_payload            (rsp_payload[1:0]), //o
  .clk(clk),
  .reset(reset)
);



endmodule
