// Generator : SpinalHDL v1.7.0    git head : b5ec4f6b85d7bd885d26b95dac2eabcc2eb9b0a1
// Component : simpleAxi4Master
// Git hash  : 049906b582a3362bbdb3b1e2702093c42e8c0ef7

`timescale 1ns/1ps

module simpleAxi4Master (
  output reg          masterAxi_aw_valid,
  input               masterAxi_aw_ready,
  output     [31:0]   masterAxi_aw_payload_addr,
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
  output     [31:0]   masterAxi_ar_payload_addr,
  output     [7:0]    masterAxi_ar_payload_len,
  output     [2:0]    masterAxi_ar_payload_size,
  output     [1:0]    masterAxi_ar_payload_burst,
  input               masterAxi_r_valid,
  output              masterAxi_r_ready,
  input      [31:0]   masterAxi_r_payload_data,
  input      [1:0]    masterAxi_r_payload_resp,
  input               masterAxi_r_payload_last,
  input               tcpBus_write,
  input      [31:0]   tcpBus_addr,
  input               tcpBus_wdata_valid,
  output reg          tcpBus_wdata_ready,
  input      [31:0]   tcpBus_wdata_payload,
  output              tcpBus_rdata_valid,
  input               tcpBus_rdata_ready,
  output     [31:0]   tcpBus_rdata_payload,
  output reg [1:0]    tcpBus_rsp,
  input               clk,
  input               reset
);
  localparam mainFsm_enumDef_BOOT = 3'd0;
  localparam mainFsm_enumDef_idle = 3'd1;
  localparam mainFsm_enumDef_read = 3'd2;
  localparam mainFsm_enumDef_endRead = 3'd3;
  localparam mainFsm_enumDef_write = 3'd4;
  localparam mainFsm_enumDef_WriteResp = 3'd5;

  wire                mainFsm_wantExit;
  reg                 mainFsm_wantStart;
  wire                mainFsm_wantKill;
  reg        [2:0]    mainFsm_stateReg;
  reg        [2:0]    mainFsm_stateNext;
  wire                masterAxi_ar_fire;
  wire                masterAxi_w_fire;
  wire                masterAxi_b_fire;
  `ifndef SYNTHESIS
  reg [71:0] mainFsm_stateReg_string;
  reg [71:0] mainFsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(mainFsm_stateReg)
      mainFsm_enumDef_BOOT : mainFsm_stateReg_string = "BOOT     ";
      mainFsm_enumDef_idle : mainFsm_stateReg_string = "idle     ";
      mainFsm_enumDef_read : mainFsm_stateReg_string = "read     ";
      mainFsm_enumDef_endRead : mainFsm_stateReg_string = "endRead  ";
      mainFsm_enumDef_write : mainFsm_stateReg_string = "write    ";
      mainFsm_enumDef_WriteResp : mainFsm_stateReg_string = "WriteResp";
      default : mainFsm_stateReg_string = "?????????";
    endcase
  end
  always @(*) begin
    case(mainFsm_stateNext)
      mainFsm_enumDef_BOOT : mainFsm_stateNext_string = "BOOT     ";
      mainFsm_enumDef_idle : mainFsm_stateNext_string = "idle     ";
      mainFsm_enumDef_read : mainFsm_stateNext_string = "read     ";
      mainFsm_enumDef_endRead : mainFsm_stateNext_string = "endRead  ";
      mainFsm_enumDef_write : mainFsm_stateNext_string = "write    ";
      mainFsm_enumDef_WriteResp : mainFsm_stateNext_string = "WriteResp";
      default : mainFsm_stateNext_string = "?????????";
    endcase
  end
  `endif

  assign tcpBus_rdata_payload = masterAxi_r_payload_data;
  assign tcpBus_rdata_valid = masterAxi_r_valid;
  always @(*) begin
    tcpBus_wdata_ready = masterAxi_aw_ready;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
        if(tcpBus_write) begin
          tcpBus_wdata_ready = 1'b0;
        end
      end
      mainFsm_enumDef_read : begin
      end
      mainFsm_enumDef_endRead : begin
      end
      mainFsm_enumDef_write : begin
        tcpBus_wdata_ready = 1'b0;
      end
      mainFsm_enumDef_WriteResp : begin
        if(masterAxi_b_fire) begin
          tcpBus_wdata_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_w_payload_data = tcpBus_wdata_payload;
  always @(*) begin
    masterAxi_w_valid = 1'b0;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
      end
      mainFsm_enumDef_read : begin
      end
      mainFsm_enumDef_endRead : begin
      end
      mainFsm_enumDef_write : begin
        masterAxi_w_valid = 1'b1;
      end
      mainFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_w_payload_strb = 4'b1111;
  assign masterAxi_w_payload_last = masterAxi_w_valid;
  always @(*) begin
    masterAxi_ar_valid = 1'b0;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
      end
      mainFsm_enumDef_read : begin
        masterAxi_ar_valid = 1'b1;
      end
      mainFsm_enumDef_endRead : begin
      end
      mainFsm_enumDef_write : begin
      end
      mainFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_ar_payload_addr = tcpBus_addr;
  assign masterAxi_ar_payload_size = 3'b100;
  assign masterAxi_ar_payload_len = 8'h0;
  assign masterAxi_ar_payload_burst = 2'b01;
  assign masterAxi_aw_payload_addr = tcpBus_addr;
  assign masterAxi_aw_payload_size = 3'b100;
  assign masterAxi_aw_payload_len = 8'h0;
  assign masterAxi_aw_payload_burst = 2'b01;
  always @(*) begin
    masterAxi_aw_valid = 1'b0;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
      end
      mainFsm_enumDef_read : begin
      end
      mainFsm_enumDef_endRead : begin
      end
      mainFsm_enumDef_write : begin
        masterAxi_aw_valid = 1'b1;
      end
      mainFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_b_ready = 1'b1;
  assign masterAxi_r_ready = 1'b1;
  always @(*) begin
    tcpBus_rsp = masterAxi_r_payload_resp;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
      end
      mainFsm_enumDef_read : begin
      end
      mainFsm_enumDef_endRead : begin
      end
      mainFsm_enumDef_write : begin
      end
      mainFsm_enumDef_WriteResp : begin
        if(masterAxi_b_fire) begin
          tcpBus_rsp = masterAxi_b_payload_resp;
        end
      end
      default : begin
      end
    endcase
  end

  assign mainFsm_wantExit = 1'b0;
  always @(*) begin
    mainFsm_wantStart = 1'b0;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
      end
      mainFsm_enumDef_read : begin
      end
      mainFsm_enumDef_endRead : begin
      end
      mainFsm_enumDef_write : begin
      end
      mainFsm_enumDef_WriteResp : begin
      end
      default : begin
        mainFsm_wantStart = 1'b1;
      end
    endcase
  end

  assign mainFsm_wantKill = 1'b0;
  always @(*) begin
    mainFsm_stateNext = mainFsm_stateReg;
    case(mainFsm_stateReg)
      mainFsm_enumDef_idle : begin
        if(tcpBus_write) begin
          mainFsm_stateNext = mainFsm_enumDef_write;
        end else begin
          if(tcpBus_rdata_ready) begin
            mainFsm_stateNext = mainFsm_enumDef_read;
          end
        end
      end
      mainFsm_enumDef_read : begin
        if(masterAxi_ar_fire) begin
          mainFsm_stateNext = mainFsm_enumDef_endRead;
        end
      end
      mainFsm_enumDef_endRead : begin
        if(masterAxi_r_payload_last) begin
          mainFsm_stateNext = mainFsm_enumDef_idle;
        end
      end
      mainFsm_enumDef_write : begin
        if(masterAxi_w_fire) begin
          mainFsm_stateNext = mainFsm_enumDef_WriteResp;
        end
      end
      mainFsm_enumDef_WriteResp : begin
        if(masterAxi_b_fire) begin
          mainFsm_stateNext = mainFsm_enumDef_idle;
        end
      end
      default : begin
      end
    endcase
    if(mainFsm_wantStart) begin
      mainFsm_stateNext = mainFsm_enumDef_idle;
    end
    if(mainFsm_wantKill) begin
      mainFsm_stateNext = mainFsm_enumDef_BOOT;
    end
  end

  assign masterAxi_ar_fire = (masterAxi_ar_valid && masterAxi_ar_ready);
  assign masterAxi_w_fire = (masterAxi_w_valid && masterAxi_w_ready);
  assign masterAxi_b_fire = (masterAxi_b_valid && masterAxi_b_ready);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      mainFsm_stateReg <= mainFsm_enumDef_BOOT;
    end else begin
      mainFsm_stateReg <= mainFsm_stateNext;
    end
  end


endmodule



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
                      output bit write,
                      output int addr,
                      output bit wdata_valid,
                      output bit rdata_ready,
                      output int wdata_payload,
                      input int rsp,
                      input int rdata_payload,
                      input bit rdata_valid,
                      input bit wdata_ready,
                      input int port,
                      input int blocking
);

parameter port = 7897;
parameter blocking = 1;
reg [31:0] addr;
reg [31:0] wdata_payload;
wire [31:0] rdata_payload;
wire [1:0] rsp;
reg write;
reg wdata_valid;
reg rdata_ready;
wire rdata_valid;
wire wdata_ready;
int value ;
always @(posedge clk)
begin

	axi_server(wdata_valid,addr,wdata_valid,rdata_ready,wdata_payload,rsp,rdata_payload,rdata_valid,1,port,blocking);    	
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
  .tcpBus_write(wdata_valid),
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
