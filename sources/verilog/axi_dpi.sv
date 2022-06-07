// Generator : SpinalHDL v1.7.0    git head : b5ec4f6b85d7bd885d26b95dac2eabcc2eb9b0a1
// Component : simpleAxi4Master
// Git hash  : 938e8626bb4d31489391a7a80b5e571ffaf08c66

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
  input               masterAxi_r_payload_last,
  input      [31:0]   tcpBus_addr,
  input               tcpBus_wdata_valid,
  output reg          tcpBus_wdata_ready,
  input               tcpBus_wdata_payload_last,
  input      [127:0]  tcpBus_wdata_payload_fragment,
  input      [7:0]    tcpBus_size,
  output              tcpBus_rdata_valid,
  input               tcpBus_rdata_ready,
  output              tcpBus_rdata_payload_last,
  output     [127:0]  tcpBus_rdata_payload_fragment,
  output reg          tcpBus_rsp_valid,
  output reg [1:0]    tcpBus_rsp_payload,
  input               clk,
  input               reset
);
  localparam receiveDataFsm_enumDef_BOOT = 2'd0;
  localparam receiveDataFsm_enumDef_idle = 2'd1;
  localparam receiveDataFsm_enumDef_receive = 2'd2;
  localparam receiveDataFsm_enumDef_endReceive = 2'd3;
  localparam driveAxiFsm_enumDef_BOOT = 4'd0;
  localparam driveAxiFsm_enumDef_idle = 4'd1;
  localparam driveAxiFsm_enumDef_Aread = 4'd2;
  localparam driveAxiFsm_enumDef_Read = 4'd3;
  localparam driveAxiFsm_enumDef_endRead = 4'd4;
  localparam driveAxiFsm_enumDef_Awrite = 4'd5;
  localparam driveAxiFsm_enumDef_Write = 4'd6;
  localparam driveAxiFsm_enumDef_WriteLast = 4'd7;
  localparam driveAxiFsm_enumDef_WriteResp = 4'd8;

  wire       [7:0]    _zz_driveAxiFsm_readCount_valueNext;
  wire       [0:0]    _zz_driveAxiFsm_readCount_valueNext_1;
  wire       [7:0]    _zz_driveAxiFsm_indexTobeSent;
  reg        [127:0]  _zz_masterAxi_w_payload_data;
  wire       [3:0]    _zz_masterAxi_w_payload_data_1;
  wire       [7:0]    _zz_when_simpleAxi4Master_l213;
  wire       [7:0]    nwords;
  reg        [127:0]  buffer_0;
  reg        [127:0]  buffer_1;
  reg        [127:0]  buffer_2;
  reg        [127:0]  buffer_3;
  reg        [127:0]  buffer_4;
  reg        [127:0]  buffer_5;
  reg        [127:0]  buffer_6;
  reg        [127:0]  buffer_7;
  reg        [127:0]  buffer_8;
  reg        [127:0]  buffer_9;
  reg        [127:0]  buffer_10;
  reg        [127:0]  buffer_11;
  reg        [127:0]  buffer_12;
  reg        [127:0]  buffer_13;
  reg        [127:0]  buffer_14;
  reg        [127:0]  buffer_15;
  reg                 receivedCnt_incrementIt;
  reg                 receivedCnt_decrementIt;
  wire       [3:0]    receivedCnt_valueNext;
  reg        [3:0]    receivedCnt_value;
  wire                receivedCnt_willOverflowIfInc;
  wire                receivedCnt_willOverflow;
  reg        [3:0]    receivedCnt_finalIncrement;
  wire                when_Utils_l650;
  wire                when_Utils_l652;
  reg                 PendingWrite;
  reg                 doWrite;
  wire                receiveDataFsm_wantExit;
  reg                 receiveDataFsm_wantStart;
  wire                receiveDataFsm_wantKill;
  wire                driveAxiFsm_wantExit;
  reg                 driveAxiFsm_wantStart;
  wire                driveAxiFsm_wantKill;
  reg                 driveAxiFsm_readCount_willIncrement;
  wire                driveAxiFsm_readCount_willClear;
  reg        [7:0]    driveAxiFsm_readCount_valueNext;
  reg        [7:0]    driveAxiFsm_readCount_value;
  wire                driveAxiFsm_readCount_willOverflowIfInc;
  wire                driveAxiFsm_readCount_willOverflow;
  wire       [7:0]    driveAxiFsm_indexTobeSent;
  reg        [1:0]    receiveDataFsm_stateReg;
  reg        [1:0]    receiveDataFsm_stateNext;
  wire                when_simpleAxi4Master_l146;
  wire       [15:0]   _zz_1;
  reg        [3:0]    driveAxiFsm_stateReg;
  reg        [3:0]    driveAxiFsm_stateNext;
  wire                masterAxi_r_fire;
  wire                when_simpleAxi4Master_l199;
  wire                masterAxi_r_fire_1;
  wire                when_simpleAxi4Master_l213;
  wire                masterAxi_aw_fire;
  wire                when_simpleAxi4Master_l237;
  wire                when_simpleAxi4Master_l248;
  wire                masterAxi_w_fire;
  wire                when_simpleAxi4Master_l252;
  wire                masterAxi_w_fire_1;
  wire                masterAxi_b_fire;
  `ifndef SYNTHESIS
  reg [79:0] receiveDataFsm_stateReg_string;
  reg [79:0] receiveDataFsm_stateNext_string;
  reg [71:0] driveAxiFsm_stateReg_string;
  reg [71:0] driveAxiFsm_stateNext_string;
  `endif


  assign _zz_driveAxiFsm_readCount_valueNext_1 = driveAxiFsm_readCount_willIncrement;
  assign _zz_driveAxiFsm_readCount_valueNext = {7'd0, _zz_driveAxiFsm_readCount_valueNext_1};
  assign _zz_driveAxiFsm_indexTobeSent = {4'd0, receivedCnt_value};
  assign _zz_masterAxi_w_payload_data_1 = driveAxiFsm_indexTobeSent[3:0];
  assign _zz_when_simpleAxi4Master_l213 = (tcpBus_size - 8'h01);
  always @(*) begin
    case(_zz_masterAxi_w_payload_data_1)
      4'b0000 : _zz_masterAxi_w_payload_data = buffer_0;
      4'b0001 : _zz_masterAxi_w_payload_data = buffer_1;
      4'b0010 : _zz_masterAxi_w_payload_data = buffer_2;
      4'b0011 : _zz_masterAxi_w_payload_data = buffer_3;
      4'b0100 : _zz_masterAxi_w_payload_data = buffer_4;
      4'b0101 : _zz_masterAxi_w_payload_data = buffer_5;
      4'b0110 : _zz_masterAxi_w_payload_data = buffer_6;
      4'b0111 : _zz_masterAxi_w_payload_data = buffer_7;
      4'b1000 : _zz_masterAxi_w_payload_data = buffer_8;
      4'b1001 : _zz_masterAxi_w_payload_data = buffer_9;
      4'b1010 : _zz_masterAxi_w_payload_data = buffer_10;
      4'b1011 : _zz_masterAxi_w_payload_data = buffer_11;
      4'b1100 : _zz_masterAxi_w_payload_data = buffer_12;
      4'b1101 : _zz_masterAxi_w_payload_data = buffer_13;
      4'b1110 : _zz_masterAxi_w_payload_data = buffer_14;
      default : _zz_masterAxi_w_payload_data = buffer_15;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(receiveDataFsm_stateReg)
      receiveDataFsm_enumDef_BOOT : receiveDataFsm_stateReg_string = "BOOT      ";
      receiveDataFsm_enumDef_idle : receiveDataFsm_stateReg_string = "idle      ";
      receiveDataFsm_enumDef_receive : receiveDataFsm_stateReg_string = "receive   ";
      receiveDataFsm_enumDef_endReceive : receiveDataFsm_stateReg_string = "endReceive";
      default : receiveDataFsm_stateReg_string = "??????????";
    endcase
  end
  always @(*) begin
    case(receiveDataFsm_stateNext)
      receiveDataFsm_enumDef_BOOT : receiveDataFsm_stateNext_string = "BOOT      ";
      receiveDataFsm_enumDef_idle : receiveDataFsm_stateNext_string = "idle      ";
      receiveDataFsm_enumDef_receive : receiveDataFsm_stateNext_string = "receive   ";
      receiveDataFsm_enumDef_endReceive : receiveDataFsm_stateNext_string = "endReceive";
      default : receiveDataFsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_BOOT : driveAxiFsm_stateReg_string = "BOOT     ";
      driveAxiFsm_enumDef_idle : driveAxiFsm_stateReg_string = "idle     ";
      driveAxiFsm_enumDef_Aread : driveAxiFsm_stateReg_string = "Aread    ";
      driveAxiFsm_enumDef_Read : driveAxiFsm_stateReg_string = "Read     ";
      driveAxiFsm_enumDef_endRead : driveAxiFsm_stateReg_string = "endRead  ";
      driveAxiFsm_enumDef_Awrite : driveAxiFsm_stateReg_string = "Awrite   ";
      driveAxiFsm_enumDef_Write : driveAxiFsm_stateReg_string = "Write    ";
      driveAxiFsm_enumDef_WriteLast : driveAxiFsm_stateReg_string = "WriteLast";
      driveAxiFsm_enumDef_WriteResp : driveAxiFsm_stateReg_string = "WriteResp";
      default : driveAxiFsm_stateReg_string = "?????????";
    endcase
  end
  always @(*) begin
    case(driveAxiFsm_stateNext)
      driveAxiFsm_enumDef_BOOT : driveAxiFsm_stateNext_string = "BOOT     ";
      driveAxiFsm_enumDef_idle : driveAxiFsm_stateNext_string = "idle     ";
      driveAxiFsm_enumDef_Aread : driveAxiFsm_stateNext_string = "Aread    ";
      driveAxiFsm_enumDef_Read : driveAxiFsm_stateNext_string = "Read     ";
      driveAxiFsm_enumDef_endRead : driveAxiFsm_stateNext_string = "endRead  ";
      driveAxiFsm_enumDef_Awrite : driveAxiFsm_stateNext_string = "Awrite   ";
      driveAxiFsm_enumDef_Write : driveAxiFsm_stateNext_string = "Write    ";
      driveAxiFsm_enumDef_WriteLast : driveAxiFsm_stateNext_string = "WriteLast";
      driveAxiFsm_enumDef_WriteResp : driveAxiFsm_stateNext_string = "WriteResp";
      default : driveAxiFsm_stateNext_string = "?????????";
    endcase
  end
  `endif

  assign nwords = (tcpBus_size / 5'h10);
  assign tcpBus_rdata_payload_fragment = masterAxi_r_payload_data;
  assign tcpBus_rdata_valid = masterAxi_r_valid;
  assign tcpBus_rdata_payload_last = masterAxi_r_payload_last;
  always @(*) begin
    masterAxi_w_valid = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
        masterAxi_w_valid = 1'b1;
      end
      driveAxiFsm_enumDef_Write : begin
        if(when_simpleAxi4Master_l248) begin
          masterAxi_w_valid = 1'b1;
        end
      end
      driveAxiFsm_enumDef_WriteLast : begin
        masterAxi_w_valid = 1'b1;
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_w_payload_strb = 16'hffff;
  always @(*) begin
    masterAxi_w_payload_last = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
        if(masterAxi_aw_fire) begin
          if(when_simpleAxi4Master_l237) begin
            masterAxi_w_payload_last = 1'b1;
          end
        end
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
        masterAxi_w_payload_last = 1'b1;
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    masterAxi_ar_valid = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
        masterAxi_ar_valid = 1'b1;
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_ar_payload_addr = tcpBus_addr;
  assign masterAxi_ar_payload_size = 3'b010;
  assign masterAxi_ar_payload_len = (tcpBus_size - 8'h01);
  assign masterAxi_ar_payload_burst = 2'b01;
  assign masterAxi_aw_payload_addr = tcpBus_addr;
  assign masterAxi_aw_payload_size = 3'b010;
  assign masterAxi_aw_payload_len = (tcpBus_size - 8'h01);
  assign masterAxi_aw_payload_burst = 2'b01;
  always @(*) begin
    masterAxi_aw_valid = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
        masterAxi_aw_valid = 1'b1;
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign masterAxi_b_ready = 1'b1;
  always @(*) begin
    masterAxi_r_ready = 1'b1;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
        masterAxi_r_ready = 1'b1;
      end
      driveAxiFsm_enumDef_Read : begin
        masterAxi_r_ready = 1'b1;
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    tcpBus_rsp_valid = masterAxi_r_valid;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
        if(masterAxi_b_fire) begin
          tcpBus_rsp_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    tcpBus_rsp_payload = masterAxi_r_payload_resp;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
        if(masterAxi_b_fire) begin
          tcpBus_rsp_payload = masterAxi_b_payload_resp;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    tcpBus_wdata_ready = 1'b0;
    case(receiveDataFsm_stateReg)
      receiveDataFsm_enumDef_idle : begin
      end
      receiveDataFsm_enumDef_receive : begin
        tcpBus_wdata_ready = 1'b1;
      end
      receiveDataFsm_enumDef_endReceive : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    receivedCnt_incrementIt = 1'b0;
    case(receiveDataFsm_stateReg)
      receiveDataFsm_enumDef_idle : begin
      end
      receiveDataFsm_enumDef_receive : begin
        receivedCnt_incrementIt = 1'b1;
      end
      receiveDataFsm_enumDef_endReceive : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    receivedCnt_decrementIt = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
        if(masterAxi_aw_fire) begin
          receivedCnt_decrementIt = 1'b1;
        end
      end
      driveAxiFsm_enumDef_Write : begin
        if(when_simpleAxi4Master_l248) begin
          if(masterAxi_w_fire) begin
            receivedCnt_decrementIt = 1'b1;
          end
        end
      end
      driveAxiFsm_enumDef_WriteLast : begin
        if(masterAxi_w_fire_1) begin
          receivedCnt_decrementIt = 1'b1;
        end
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign receivedCnt_willOverflowIfInc = ((receivedCnt_value == 4'b1111) && (! receivedCnt_decrementIt));
  assign receivedCnt_willOverflow = (receivedCnt_willOverflowIfInc && receivedCnt_incrementIt);
  assign when_Utils_l650 = (receivedCnt_incrementIt && (! receivedCnt_decrementIt));
  always @(*) begin
    if(when_Utils_l650) begin
      receivedCnt_finalIncrement = 4'b0001;
    end else begin
      if(when_Utils_l652) begin
        receivedCnt_finalIncrement = 4'b1111;
      end else begin
        receivedCnt_finalIncrement = 4'b0000;
      end
    end
  end

  assign when_Utils_l652 = ((! receivedCnt_incrementIt) && receivedCnt_decrementIt);
  assign receivedCnt_valueNext = (receivedCnt_value + receivedCnt_finalIncrement);
  assign receiveDataFsm_wantExit = 1'b0;
  always @(*) begin
    receiveDataFsm_wantStart = 1'b0;
    case(receiveDataFsm_stateReg)
      receiveDataFsm_enumDef_idle : begin
      end
      receiveDataFsm_enumDef_receive : begin
      end
      receiveDataFsm_enumDef_endReceive : begin
      end
      default : begin
        receiveDataFsm_wantStart = 1'b1;
      end
    endcase
  end

  assign receiveDataFsm_wantKill = 1'b0;
  assign driveAxiFsm_wantExit = 1'b0;
  always @(*) begin
    driveAxiFsm_wantStart = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
      end
      driveAxiFsm_enumDef_Read : begin
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
        driveAxiFsm_wantStart = 1'b1;
      end
    endcase
  end

  assign driveAxiFsm_wantKill = 1'b0;
  always @(*) begin
    driveAxiFsm_readCount_willIncrement = 1'b0;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
      end
      driveAxiFsm_enumDef_Aread : begin
        if(masterAxi_r_fire) begin
          if(!when_simpleAxi4Master_l199) begin
            driveAxiFsm_readCount_willIncrement = 1'b1;
          end
        end
      end
      driveAxiFsm_enumDef_Read : begin
        if(masterAxi_r_fire_1) begin
          driveAxiFsm_readCount_willIncrement = 1'b1;
        end
      end
      driveAxiFsm_enumDef_endRead : begin
      end
      driveAxiFsm_enumDef_Awrite : begin
      end
      driveAxiFsm_enumDef_Write : begin
      end
      driveAxiFsm_enumDef_WriteLast : begin
      end
      driveAxiFsm_enumDef_WriteResp : begin
      end
      default : begin
      end
    endcase
  end

  assign driveAxiFsm_readCount_willClear = 1'b0;
  assign driveAxiFsm_readCount_willOverflowIfInc = (driveAxiFsm_readCount_value == 8'hff);
  assign driveAxiFsm_readCount_willOverflow = (driveAxiFsm_readCount_willOverflowIfInc && driveAxiFsm_readCount_willIncrement);
  always @(*) begin
    driveAxiFsm_readCount_valueNext = (driveAxiFsm_readCount_value + _zz_driveAxiFsm_readCount_valueNext);
    if(driveAxiFsm_readCount_willClear) begin
      driveAxiFsm_readCount_valueNext = 8'h0;
    end
  end

  assign driveAxiFsm_indexTobeSent = (tcpBus_size - _zz_driveAxiFsm_indexTobeSent);
  assign masterAxi_w_payload_data = _zz_masterAxi_w_payload_data;
  always @(*) begin
    receiveDataFsm_stateNext = receiveDataFsm_stateReg;
    case(receiveDataFsm_stateReg)
      receiveDataFsm_enumDef_idle : begin
        if(when_simpleAxi4Master_l146) begin
          receiveDataFsm_stateNext = receiveDataFsm_enumDef_receive;
        end
      end
      receiveDataFsm_enumDef_receive : begin
        if(tcpBus_wdata_payload_last) begin
          receiveDataFsm_stateNext = receiveDataFsm_enumDef_endReceive;
        end else begin
          receiveDataFsm_stateNext = receiveDataFsm_enumDef_receive;
        end
      end
      receiveDataFsm_enumDef_endReceive : begin
        receiveDataFsm_stateNext = receiveDataFsm_enumDef_idle;
      end
      default : begin
      end
    endcase
    if(receiveDataFsm_wantStart) begin
      receiveDataFsm_stateNext = receiveDataFsm_enumDef_idle;
    end
    if(receiveDataFsm_wantKill) begin
      receiveDataFsm_stateNext = receiveDataFsm_enumDef_BOOT;
    end
  end

  assign when_simpleAxi4Master_l146 = (tcpBus_wdata_valid && (! PendingWrite));
  assign _zz_1 = ({15'd0,1'b1} <<< receivedCnt_value);
  always @(*) begin
    driveAxiFsm_stateNext = driveAxiFsm_stateReg;
    case(driveAxiFsm_stateReg)
      driveAxiFsm_enumDef_idle : begin
        if(PendingWrite) begin
          if(doWrite) begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_Awrite;
          end
        end else begin
          if(tcpBus_rdata_ready) begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_Aread;
          end
        end
      end
      driveAxiFsm_enumDef_Aread : begin
        if(masterAxi_r_fire) begin
          if(when_simpleAxi4Master_l199) begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_endRead;
          end else begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_Read;
          end
        end
      end
      driveAxiFsm_enumDef_Read : begin
        if(masterAxi_r_fire_1) begin
          if(when_simpleAxi4Master_l213) begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_endRead;
          end else begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_Read;
          end
        end
      end
      driveAxiFsm_enumDef_endRead : begin
        if(masterAxi_r_payload_last) begin
          driveAxiFsm_stateNext = driveAxiFsm_enumDef_idle;
        end
      end
      driveAxiFsm_enumDef_Awrite : begin
        if(masterAxi_aw_fire) begin
          if(when_simpleAxi4Master_l237) begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_WriteResp;
          end else begin
            driveAxiFsm_stateNext = driveAxiFsm_enumDef_Write;
          end
        end
      end
      driveAxiFsm_enumDef_Write : begin
        if(when_simpleAxi4Master_l248) begin
          if(masterAxi_w_fire) begin
            if(when_simpleAxi4Master_l252) begin
              driveAxiFsm_stateNext = driveAxiFsm_enumDef_WriteResp;
            end else begin
              driveAxiFsm_stateNext = driveAxiFsm_enumDef_Write;
            end
          end
        end
      end
      driveAxiFsm_enumDef_WriteLast : begin
        if(masterAxi_w_fire_1) begin
          driveAxiFsm_stateNext = driveAxiFsm_enumDef_WriteResp;
        end
      end
      driveAxiFsm_enumDef_WriteResp : begin
        if(masterAxi_b_fire) begin
          driveAxiFsm_stateNext = driveAxiFsm_enumDef_idle;
        end
      end
      default : begin
      end
    endcase
    if(driveAxiFsm_wantStart) begin
      driveAxiFsm_stateNext = driveAxiFsm_enumDef_idle;
    end
    if(driveAxiFsm_wantKill) begin
      driveAxiFsm_stateNext = driveAxiFsm_enumDef_BOOT;
    end
  end

  assign masterAxi_r_fire = (masterAxi_r_valid && masterAxi_r_ready);
  assign when_simpleAxi4Master_l199 = (tcpBus_size == 8'h01);
  assign masterAxi_r_fire_1 = (masterAxi_r_valid && masterAxi_r_ready);
  assign when_simpleAxi4Master_l213 = (driveAxiFsm_readCount_value == _zz_when_simpleAxi4Master_l213);
  assign masterAxi_aw_fire = (masterAxi_aw_valid && masterAxi_aw_ready);
  assign when_simpleAxi4Master_l237 = (receivedCnt_value == 4'b0001);
  assign when_simpleAxi4Master_l248 = (4'b0000 <= receivedCnt_value);
  assign masterAxi_w_fire = (masterAxi_w_valid && masterAxi_w_ready);
  assign when_simpleAxi4Master_l252 = (receivedCnt_value == 4'b0001);
  assign masterAxi_w_fire_1 = (masterAxi_w_valid && masterAxi_w_ready);
  assign masterAxi_b_fire = (masterAxi_b_valid && masterAxi_b_ready);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      buffer_0 <= 128'h0;
      buffer_1 <= 128'h0;
      buffer_2 <= 128'h0;
      buffer_3 <= 128'h0;
      buffer_4 <= 128'h0;
      buffer_5 <= 128'h0;
      buffer_6 <= 128'h0;
      buffer_7 <= 128'h0;
      buffer_8 <= 128'h0;
      buffer_9 <= 128'h0;
      buffer_10 <= 128'h0;
      buffer_11 <= 128'h0;
      buffer_12 <= 128'h0;
      buffer_13 <= 128'h0;
      buffer_14 <= 128'h0;
      buffer_15 <= 128'h0;
      receivedCnt_value <= 4'b0000;
      PendingWrite <= 1'b0;
      doWrite <= 1'b0;
      driveAxiFsm_readCount_value <= 8'h0;
      receiveDataFsm_stateReg <= receiveDataFsm_enumDef_BOOT;
      driveAxiFsm_stateReg <= driveAxiFsm_enumDef_BOOT;
    end else begin
      receivedCnt_value <= receivedCnt_valueNext;
      driveAxiFsm_readCount_value <= driveAxiFsm_readCount_valueNext;
      receiveDataFsm_stateReg <= receiveDataFsm_stateNext;
      case(receiveDataFsm_stateReg)
        receiveDataFsm_enumDef_idle : begin
        end
        receiveDataFsm_enumDef_receive : begin
          PendingWrite <= 1'b1;
          if(_zz_1[0]) begin
            buffer_0 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[1]) begin
            buffer_1 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[2]) begin
            buffer_2 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[3]) begin
            buffer_3 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[4]) begin
            buffer_4 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[5]) begin
            buffer_5 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[6]) begin
            buffer_6 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[7]) begin
            buffer_7 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[8]) begin
            buffer_8 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[9]) begin
            buffer_9 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[10]) begin
            buffer_10 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[11]) begin
            buffer_11 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[12]) begin
            buffer_12 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[13]) begin
            buffer_13 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[14]) begin
            buffer_14 <= tcpBus_wdata_payload_fragment;
          end
          if(_zz_1[15]) begin
            buffer_15 <= tcpBus_wdata_payload_fragment;
          end
        end
        receiveDataFsm_enumDef_endReceive : begin
          doWrite <= 1'b1;
        end
        default : begin
        end
      endcase
      driveAxiFsm_stateReg <= driveAxiFsm_stateNext;
      case(driveAxiFsm_stateReg)
        driveAxiFsm_enumDef_idle : begin
        end
        driveAxiFsm_enumDef_Aread : begin
        end
        driveAxiFsm_enumDef_Read : begin
        end
        driveAxiFsm_enumDef_endRead : begin
        end
        driveAxiFsm_enumDef_Awrite : begin
        end
        driveAxiFsm_enumDef_Write : begin
        end
        driveAxiFsm_enumDef_WriteLast : begin
        end
        driveAxiFsm_enumDef_WriteResp : begin
          if(masterAxi_b_fire) begin
            PendingWrite <= 1'b0;
            doWrite <= 1'b0;
            receivedCnt_value <= 4'b0000;
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule







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
                      input int blocking
);

parameter port = 7897;
parameter blocking = 1;
reg [31:0]  addr,size;
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
            blocking);    	
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
