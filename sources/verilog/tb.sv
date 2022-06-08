`timescale 1ns/1ps
module unamed (
  input               io_axi_aw_valid,
  output reg          io_axi_aw_ready,
  input      [31:0]   io_axi_aw_payload_addr,
  input      [7:0]    io_axi_aw_payload_len,
  input      [2:0]    io_axi_aw_payload_size,
  input      [1:0]    io_axi_aw_payload_burst,
  input               io_axi_w_valid,
  output              io_axi_w_ready,
  input      [31:0]   io_axi_w_payload_data,
  input      [3:0]    io_axi_w_payload_strb,
  input               io_axi_w_payload_last,
  output              io_axi_b_valid,
  input               io_axi_b_ready,
  output     [1:0]    io_axi_b_payload_resp,
  input               io_axi_ar_valid,
  output reg          io_axi_ar_ready,
  input      [31:0]   io_axi_ar_payload_addr,
  input      [7:0]    io_axi_ar_payload_len,
  input      [2:0]    io_axi_ar_payload_size,
  input      [1:0]    io_axi_ar_payload_burst,
  output              io_axi_r_valid,
  input               io_axi_r_ready,
  output     [31:0]   io_axi_r_payload_data,
  output     [1:0]    io_axi_r_payload_resp,
  output              io_axi_r_payload_last,
  input               clk,
  input               reset
);

  wire       [1:0]    _zz_Axi4Incr_alignMask;
  wire       [11:0]   _zz_Axi4Incr_base;
  wire       [11:0]   _zz_Axi4Incr_base_1;
  wire       [11:0]   _zz_Axi4Incr_baseIncr;
  wire       [2:0]    _zz_Axi4Incr_wrapCase_2;
  wire       [2:0]    _zz_Axi4Incr_wrapCase_3;
  reg        [11:0]   _zz_Axi4Incr_result;
  wire       [10:0]   _zz_Axi4Incr_result_1;
  wire       [0:0]    _zz_Axi4Incr_result_2;
  wire       [9:0]    _zz_Axi4Incr_result_3;
  wire       [1:0]    _zz_Axi4Incr_result_4;
  wire       [8:0]    _zz_Axi4Incr_result_5;
  wire       [2:0]    _zz_Axi4Incr_result_6;
  wire       [7:0]    _zz_Axi4Incr_result_7;
  wire       [3:0]    _zz_Axi4Incr_result_8;
  wire       [6:0]    _zz_Axi4Incr_result_9;
  wire       [4:0]    _zz_Axi4Incr_result_10;
  wire       [5:0]    _zz_Axi4Incr_result_11;
  wire       [5:0]    _zz_Axi4Incr_result_12;
  wire       [1:0]    _zz_Axi4Incr_alignMask_1;
  wire       [11:0]   _zz_Axi4Incr_base_1_1;
  wire       [11:0]   _zz_Axi4Incr_base_1_2;
  wire       [11:0]   _zz_Axi4Incr_baseIncr_1;
  wire       [2:0]    _zz_Axi4Incr_wrapCase_1_1;
  wire       [2:0]    _zz_Axi4Incr_wrapCase_1_2;
  reg        [11:0]   _zz_Axi4Incr_result_1_1;
  wire       [10:0]   _zz_Axi4Incr_result_1_2;
  wire       [0:0]    _zz_Axi4Incr_result_1_3;
  wire       [9:0]    _zz_Axi4Incr_result_1_4;
  wire       [1:0]    _zz_Axi4Incr_result_1_5;
  wire       [8:0]    _zz_Axi4Incr_result_1_6;
  wire       [2:0]    _zz_Axi4Incr_result_1_7;
  wire       [7:0]    _zz_Axi4Incr_result_1_8;
  wire       [3:0]    _zz_Axi4Incr_result_1_9;
  wire       [6:0]    _zz_Axi4Incr_result_1_10;
  wire       [4:0]    _zz_Axi4Incr_result_1_11;
  wire       [5:0]    _zz_Axi4Incr_result_1_12;
  wire       [5:0]    _zz_Axi4Incr_result_1_13;
  wire                io_mapper_readHaltRequest;
  wire                io_mapper_writeHaltRequest;
  reg                 unburstify_result_valid;
  wire                unburstify_result_ready;
  reg                 unburstify_result_payload_last;
  reg        [31:0]   unburstify_result_payload_fragment_addr;
  reg        [2:0]    unburstify_result_payload_fragment_size;
  reg        [1:0]    unburstify_result_payload_fragment_burst;
  wire                unburstify_doResult;
  reg                 unburstify_buffer_valid;
  reg        [7:0]    unburstify_buffer_len;
  reg        [7:0]    unburstify_buffer_beat;
  reg        [31:0]   unburstify_buffer_transaction_addr;
  reg        [2:0]    unburstify_buffer_transaction_size;
  reg        [1:0]    unburstify_buffer_transaction_burst;
  wire                unburstify_buffer_last;
  wire       [1:0]    Axi4Incr_validSize;
  reg        [31:0]   Axi4Incr_result;
  wire       [19:0]   Axi4Incr_highCat;
  wire       [2:0]    Axi4Incr_sizeValue;
  wire       [11:0]   Axi4Incr_alignMask;
  wire       [11:0]   Axi4Incr_base;
  wire       [11:0]   Axi4Incr_baseIncr;
  reg        [1:0]    _zz_Axi4Incr_wrapCase;
  wire       [2:0]    Axi4Incr_wrapCase;
  wire                when_Axi4Channel_l183;
  wire                io_mapper_writeJoinEvent_valid;
  reg                 io_mapper_writeJoinEvent_ready;
  wire                io_mapper_writeJoinEvent_fire;
  reg                 io_mapper_writeRsp_valid;
  reg                 io_mapper_writeRsp_ready;
  wire       [1:0]    io_mapper_writeRsp_payload_resp;
  wire                io_mapper_writeRsp_m2sPipe_valid;
  wire                io_mapper_writeRsp_m2sPipe_ready;
  wire       [1:0]    io_mapper_writeRsp_m2sPipe_payload_resp;
  reg                 io_mapper_writeRsp_rValid;
  reg        [1:0]    io_mapper_writeRsp_rData_resp;
  wire                when_Stream_l368;
  wire                io_mapper_writeJoinEvent_fire_1;
  reg                 unburstify_result_valid_1;
  reg                 unburstify_result_ready_1;
  reg                 unburstify_result_payload_last_1;
  reg        [31:0]   unburstify_result_payload_fragment_addr_1;
  reg        [2:0]    unburstify_result_payload_fragment_size_1;
  reg        [1:0]    unburstify_result_payload_fragment_burst_1;
  wire                unburstify_doResult_1;
  reg                 unburstify_buffer_valid_1;
  reg        [7:0]    unburstify_buffer_len_1;
  reg        [7:0]    unburstify_buffer_beat_1;
  reg        [31:0]   unburstify_buffer_transaction_addr_1;
  reg        [2:0]    unburstify_buffer_transaction_size_1;
  reg        [1:0]    unburstify_buffer_transaction_burst_1;
  wire                unburstify_buffer_last_1;
  wire       [1:0]    Axi4Incr_validSize_1;
  reg        [31:0]   Axi4Incr_result_1;
  wire       [19:0]   Axi4Incr_highCat_1;
  wire       [2:0]    Axi4Incr_sizeValue_1;
  wire       [11:0]   Axi4Incr_alignMask_1;
  wire       [11:0]   Axi4Incr_base_1;
  wire       [11:0]   Axi4Incr_baseIncr_1;
  reg        [1:0]    _zz_Axi4Incr_wrapCase_1;
  wire       [2:0]    Axi4Incr_wrapCase_1;
  wire                when_Axi4Channel_l183_1;
  wire                io_mapper_readDataStage_valid;
  wire                io_mapper_readDataStage_ready;
  wire                io_mapper_readDataStage_payload_last;
  wire       [31:0]   io_mapper_readDataStage_payload_fragment_addr;
  wire       [2:0]    io_mapper_readDataStage_payload_fragment_size;
  wire       [1:0]    io_mapper_readDataStage_payload_fragment_burst;
  reg                 unburstify_result_rValid;
  reg                 unburstify_result_rData_last;
  reg        [31:0]   unburstify_result_rData_fragment_addr;
  reg        [2:0]    unburstify_result_rData_fragment_size;
  reg        [1:0]    unburstify_result_rData_fragment_burst;
  wire                when_Stream_l368_1;
  reg        [31:0]   io_mapper_readRsp_data;
  wire       [1:0]    io_mapper_readRsp_resp;
  wire                io_mapper_readRsp_last;
  wire                _zz_io_axi_r_valid;
  wire                io_mapper_writeOccur;
  wire                io_mapper_readOccur;
  wire       [31:0]   io_mapper_readAddressMasked;
  wire       [31:0]   io_mapper_writeAddressMasked;
  reg        [31:0]   io_reg;
  reg        [31:0]   io_reg_driver;
  wire                when_BusSlaveFactory_l962;
  wire                when_BusSlaveFactory_l962_1;
  wire                when_BusSlaveFactory_l962_2;
  wire                when_BusSlaveFactory_l962_3;

  assign _zz_Axi4Incr_alignMask = {(2'b01 < Axi4Incr_validSize),(2'b00 < Axi4Incr_validSize)};
  assign _zz_Axi4Incr_base_1 = unburstify_buffer_transaction_addr[11 : 0];
  assign _zz_Axi4Incr_base = _zz_Axi4Incr_base_1;
  assign _zz_Axi4Incr_baseIncr = {9'd0, Axi4Incr_sizeValue};
  assign _zz_Axi4Incr_wrapCase_2 = {1'd0, Axi4Incr_validSize};
  assign _zz_Axi4Incr_wrapCase_3 = {1'd0, _zz_Axi4Incr_wrapCase};
  assign _zz_Axi4Incr_alignMask_1 = {(2'b01 < Axi4Incr_validSize_1),(2'b00 < Axi4Incr_validSize_1)};
  assign _zz_Axi4Incr_base_1_2 = unburstify_buffer_transaction_addr_1[11 : 0];
  assign _zz_Axi4Incr_base_1_1 = _zz_Axi4Incr_base_1_2;
  assign _zz_Axi4Incr_baseIncr_1 = {9'd0, Axi4Incr_sizeValue_1};
  assign _zz_Axi4Incr_wrapCase_1_1 = {1'd0, Axi4Incr_validSize_1};
  assign _zz_Axi4Incr_wrapCase_1_2 = {1'd0, _zz_Axi4Incr_wrapCase_1};
  assign _zz_Axi4Incr_result_1 = Axi4Incr_base[11 : 1];
  assign _zz_Axi4Incr_result_2 = Axi4Incr_baseIncr[0 : 0];
  assign _zz_Axi4Incr_result_3 = Axi4Incr_base[11 : 2];
  assign _zz_Axi4Incr_result_4 = Axi4Incr_baseIncr[1 : 0];
  assign _zz_Axi4Incr_result_5 = Axi4Incr_base[11 : 3];
  assign _zz_Axi4Incr_result_6 = Axi4Incr_baseIncr[2 : 0];
  assign _zz_Axi4Incr_result_7 = Axi4Incr_base[11 : 4];
  assign _zz_Axi4Incr_result_8 = Axi4Incr_baseIncr[3 : 0];
  assign _zz_Axi4Incr_result_9 = Axi4Incr_base[11 : 5];
  assign _zz_Axi4Incr_result_10 = Axi4Incr_baseIncr[4 : 0];
  assign _zz_Axi4Incr_result_11 = Axi4Incr_base[11 : 6];
  assign _zz_Axi4Incr_result_12 = Axi4Incr_baseIncr[5 : 0];
  assign _zz_Axi4Incr_result_1_2 = Axi4Incr_base_1[11 : 1];
  assign _zz_Axi4Incr_result_1_3 = Axi4Incr_baseIncr_1[0 : 0];
  assign _zz_Axi4Incr_result_1_4 = Axi4Incr_base_1[11 : 2];
  assign _zz_Axi4Incr_result_1_5 = Axi4Incr_baseIncr_1[1 : 0];
  assign _zz_Axi4Incr_result_1_6 = Axi4Incr_base_1[11 : 3];
  assign _zz_Axi4Incr_result_1_7 = Axi4Incr_baseIncr_1[2 : 0];
  assign _zz_Axi4Incr_result_1_8 = Axi4Incr_base_1[11 : 4];
  assign _zz_Axi4Incr_result_1_9 = Axi4Incr_baseIncr_1[3 : 0];
  assign _zz_Axi4Incr_result_1_10 = Axi4Incr_base_1[11 : 5];
  assign _zz_Axi4Incr_result_1_11 = Axi4Incr_baseIncr_1[4 : 0];
  assign _zz_Axi4Incr_result_1_12 = Axi4Incr_base_1[11 : 6];
  assign _zz_Axi4Incr_result_1_13 = Axi4Incr_baseIncr_1[5 : 0];
  always @(*) begin
    case(Axi4Incr_wrapCase)
      3'b000 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_1,_zz_Axi4Incr_result_2};
      3'b001 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_3,_zz_Axi4Incr_result_4};
      3'b010 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_5,_zz_Axi4Incr_result_6};
      3'b011 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_7,_zz_Axi4Incr_result_8};
      3'b100 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_9,_zz_Axi4Incr_result_10};
      default : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_11,_zz_Axi4Incr_result_12};
    endcase
  end

  always @(*) begin
    case(Axi4Incr_wrapCase_1)
      3'b000 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_2,_zz_Axi4Incr_result_1_3};
      3'b001 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_4,_zz_Axi4Incr_result_1_5};
      3'b010 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_6,_zz_Axi4Incr_result_1_7};
      3'b011 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_8,_zz_Axi4Incr_result_1_9};
      3'b100 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_10,_zz_Axi4Incr_result_1_11};
      default : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_12,_zz_Axi4Incr_result_1_13};
    endcase
  end

  assign io_mapper_readHaltRequest = 1'b0;
  assign io_mapper_writeHaltRequest = 1'b0;
  assign unburstify_buffer_last = (unburstify_buffer_beat == 8'h01);
  assign Axi4Incr_validSize = unburstify_buffer_transaction_size[1 : 0];
  assign Axi4Incr_highCat = unburstify_buffer_transaction_addr[31 : 12];
  assign Axi4Incr_sizeValue = {(2'b10 == Axi4Incr_validSize),{(2'b01 == Axi4Incr_validSize),(2'b00 == Axi4Incr_validSize)}};
  assign Axi4Incr_alignMask = {10'd0, _zz_Axi4Incr_alignMask};
  assign Axi4Incr_base = (_zz_Axi4Incr_base & (~ Axi4Incr_alignMask));
  assign Axi4Incr_baseIncr = (Axi4Incr_base + _zz_Axi4Incr_baseIncr);
  always @(*) begin
    casez(unburstify_buffer_len)
      8'b????1??? : begin
        _zz_Axi4Incr_wrapCase = 2'b11;
      end
      8'b????01?? : begin
        _zz_Axi4Incr_wrapCase = 2'b10;
      end
      8'b????001? : begin
        _zz_Axi4Incr_wrapCase = 2'b01;
      end
      default : begin
        _zz_Axi4Incr_wrapCase = 2'b00;
      end
    endcase
  end

  assign Axi4Incr_wrapCase = (_zz_Axi4Incr_wrapCase_2 + _zz_Axi4Incr_wrapCase_3);
  always @(*) begin
    case(unburstify_buffer_transaction_burst)
      2'b00 : begin
        Axi4Incr_result = unburstify_buffer_transaction_addr;
      end
      2'b10 : begin
        Axi4Incr_result = {Axi4Incr_highCat,_zz_Axi4Incr_result};
      end
      default : begin
        Axi4Incr_result = {Axi4Incr_highCat,Axi4Incr_baseIncr};
      end
    endcase
  end

  always @(*) begin
    io_axi_aw_ready = 1'b0;
    if(!unburstify_buffer_valid) begin
      io_axi_aw_ready = unburstify_result_ready;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid) begin
      unburstify_result_valid = 1'b1;
    end else begin
      unburstify_result_valid = io_axi_aw_valid;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid) begin
      unburstify_result_payload_last = unburstify_buffer_last;
    end else begin
      unburstify_result_payload_last = 1'b1;
      if(when_Axi4Channel_l183) begin
        unburstify_result_payload_last = 1'b0;
      end
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid) begin
      unburstify_result_payload_fragment_size = unburstify_buffer_transaction_size;
    end else begin
      unburstify_result_payload_fragment_size = io_axi_aw_payload_size;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid) begin
      unburstify_result_payload_fragment_burst = unburstify_buffer_transaction_burst;
    end else begin
      unburstify_result_payload_fragment_burst = io_axi_aw_payload_burst;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid) begin
      unburstify_result_payload_fragment_addr = Axi4Incr_result;
    end else begin
      unburstify_result_payload_fragment_addr = io_axi_aw_payload_addr;
    end
  end

  assign when_Axi4Channel_l183 = (io_axi_aw_payload_len != 8'h0);
  assign io_mapper_writeJoinEvent_fire = (io_mapper_writeJoinEvent_valid && io_mapper_writeJoinEvent_ready);
  assign io_mapper_writeJoinEvent_valid = (unburstify_result_valid && io_axi_w_valid);
  assign unburstify_result_ready = io_mapper_writeJoinEvent_fire;
  assign io_axi_w_ready = io_mapper_writeJoinEvent_fire;
  always @(*) begin
    io_mapper_writeRsp_ready = io_mapper_writeRsp_m2sPipe_ready;
    if(when_Stream_l368) begin
      io_mapper_writeRsp_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! io_mapper_writeRsp_m2sPipe_valid);
  assign io_mapper_writeRsp_m2sPipe_valid = io_mapper_writeRsp_rValid;
  assign io_mapper_writeRsp_m2sPipe_payload_resp = io_mapper_writeRsp_rData_resp;
  assign io_axi_b_valid = io_mapper_writeRsp_m2sPipe_valid;
  assign io_mapper_writeRsp_m2sPipe_ready = io_axi_b_ready;
  assign io_axi_b_payload_resp = io_mapper_writeRsp_m2sPipe_payload_resp;
  always @(*) begin
    if(io_axi_w_payload_last) begin
      io_mapper_writeJoinEvent_ready = (io_mapper_writeRsp_ready && (! io_mapper_writeHaltRequest));
    end else begin
      io_mapper_writeJoinEvent_ready = (! io_mapper_writeHaltRequest);
    end
  end

  assign io_mapper_writeJoinEvent_fire_1 = (io_mapper_writeJoinEvent_valid && io_mapper_writeJoinEvent_ready);
  always @(*) begin
    if(io_axi_w_payload_last) begin
      io_mapper_writeRsp_valid = io_mapper_writeJoinEvent_fire_1;
    end else begin
      io_mapper_writeRsp_valid = 1'b0;
    end
  end

  assign unburstify_buffer_last_1 = (unburstify_buffer_beat_1 == 8'h01);
  assign Axi4Incr_validSize_1 = unburstify_buffer_transaction_size_1[1 : 0];
  assign Axi4Incr_highCat_1 = unburstify_buffer_transaction_addr_1[31 : 12];
  assign Axi4Incr_sizeValue_1 = {(2'b10 == Axi4Incr_validSize_1),{(2'b01 == Axi4Incr_validSize_1),(2'b00 == Axi4Incr_validSize_1)}};
  assign Axi4Incr_alignMask_1 = {10'd0, _zz_Axi4Incr_alignMask_1};
  assign Axi4Incr_base_1 = (_zz_Axi4Incr_base_1_1 & (~ Axi4Incr_alignMask_1));
  assign Axi4Incr_baseIncr_1 = (Axi4Incr_base_1 + _zz_Axi4Incr_baseIncr_1);
  always @(*) begin
    casez(unburstify_buffer_len_1)
      8'b????1??? : begin
        _zz_Axi4Incr_wrapCase_1 = 2'b11;
      end
      8'b????01?? : begin
        _zz_Axi4Incr_wrapCase_1 = 2'b10;
      end
      8'b????001? : begin
        _zz_Axi4Incr_wrapCase_1 = 2'b01;
      end
      default : begin
        _zz_Axi4Incr_wrapCase_1 = 2'b00;
      end
    endcase
  end

  assign Axi4Incr_wrapCase_1 = (_zz_Axi4Incr_wrapCase_1_1 + _zz_Axi4Incr_wrapCase_1_2);
  always @(*) begin
    case(unburstify_buffer_transaction_burst_1)
      2'b00 : begin
        Axi4Incr_result_1 = unburstify_buffer_transaction_addr_1;
      end
      2'b10 : begin
        Axi4Incr_result_1 = {Axi4Incr_highCat_1,_zz_Axi4Incr_result_1_1};
      end
      default : begin
        Axi4Incr_result_1 = {Axi4Incr_highCat_1,Axi4Incr_baseIncr_1};
      end
    endcase
  end

  always @(*) begin
    io_axi_ar_ready = 1'b0;
    if(!unburstify_buffer_valid_1) begin
      io_axi_ar_ready = unburstify_result_ready_1;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid_1) begin
      unburstify_result_valid_1 = 1'b1;
    end else begin
      unburstify_result_valid_1 = io_axi_ar_valid;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid_1) begin
      unburstify_result_payload_last_1 = unburstify_buffer_last_1;
    end else begin
      unburstify_result_payload_last_1 = 1'b1;
      if(when_Axi4Channel_l183_1) begin
        unburstify_result_payload_last_1 = 1'b0;
      end
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid_1) begin
      unburstify_result_payload_fragment_size_1 = unburstify_buffer_transaction_size_1;
    end else begin
      unburstify_result_payload_fragment_size_1 = io_axi_ar_payload_size;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid_1) begin
      unburstify_result_payload_fragment_burst_1 = unburstify_buffer_transaction_burst_1;
    end else begin
      unburstify_result_payload_fragment_burst_1 = io_axi_ar_payload_burst;
    end
  end

  always @(*) begin
    if(unburstify_buffer_valid_1) begin
      unburstify_result_payload_fragment_addr_1 = Axi4Incr_result_1;
    end else begin
      unburstify_result_payload_fragment_addr_1 = io_axi_ar_payload_addr;
    end
  end

  assign when_Axi4Channel_l183_1 = (io_axi_ar_payload_len != 8'h0);
  always @(*) begin
    unburstify_result_ready_1 = io_mapper_readDataStage_ready;
    if(when_Stream_l368_1) begin
      unburstify_result_ready_1 = 1'b1;
    end
  end

  assign when_Stream_l368_1 = (! io_mapper_readDataStage_valid);
  assign io_mapper_readDataStage_valid = unburstify_result_rValid;
  assign io_mapper_readDataStage_payload_last = unburstify_result_rData_last;
  assign io_mapper_readDataStage_payload_fragment_addr = unburstify_result_rData_fragment_addr;
  assign io_mapper_readDataStage_payload_fragment_size = unburstify_result_rData_fragment_size;
  assign io_mapper_readDataStage_payload_fragment_burst = unburstify_result_rData_fragment_burst;
  assign _zz_io_axi_r_valid = (! io_mapper_readHaltRequest);
  assign io_mapper_readDataStage_ready = (io_axi_r_ready && _zz_io_axi_r_valid);
  assign io_axi_r_valid = (io_mapper_readDataStage_valid && _zz_io_axi_r_valid);
  assign io_axi_r_payload_data = io_mapper_readRsp_data;
  assign io_axi_r_payload_resp = io_mapper_readRsp_resp;
  assign io_axi_r_payload_last = io_mapper_readRsp_last;
  assign io_mapper_writeRsp_payload_resp = 2'b00;
  assign io_mapper_readRsp_resp = 2'b00;
  always @(*) begin
    io_mapper_readRsp_data = 32'h0;
    case(io_mapper_readAddressMasked)
      32'h0 : begin
        io_mapper_readRsp_data[31 : 0] = io_reg_driver;
      end
      default : begin
      end
    endcase
  end

  assign io_mapper_readRsp_last = io_mapper_readDataStage_payload_last;
  assign io_mapper_writeOccur = (io_mapper_writeJoinEvent_valid && io_mapper_writeJoinEvent_ready);
  assign io_mapper_readOccur = (io_axi_r_valid && io_axi_r_ready);
  assign io_mapper_readAddressMasked = (io_mapper_readDataStage_payload_fragment_addr & (~ 32'h00000003));
  assign io_mapper_writeAddressMasked = (unburstify_result_payload_fragment_addr & (~ 32'h00000003));
  assign when_BusSlaveFactory_l962 = io_axi_w_payload_strb[0];
  assign when_BusSlaveFactory_l962_1 = io_axi_w_payload_strb[1];
  assign when_BusSlaveFactory_l962_2 = io_axi_w_payload_strb[2];
  assign when_BusSlaveFactory_l962_3 = io_axi_w_payload_strb[3];
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      unburstify_buffer_valid <= 1'b0;
      io_mapper_writeRsp_rValid <= 1'b0;
      unburstify_buffer_valid_1 <= 1'b0;
      unburstify_result_rValid <= 1'b0;
    end else begin
      if(unburstify_result_ready) begin
        if(unburstify_buffer_last) begin
          unburstify_buffer_valid <= 1'b0;
        end
      end
      if(!unburstify_buffer_valid) begin
        if(when_Axi4Channel_l183) begin
          if(unburstify_result_ready) begin
            unburstify_buffer_valid <= io_axi_aw_valid;
          end
        end
      end
      if(io_mapper_writeRsp_ready) begin
        io_mapper_writeRsp_rValid <= io_mapper_writeRsp_valid;
      end
      if(unburstify_result_ready_1) begin
        if(unburstify_buffer_last_1) begin
          unburstify_buffer_valid_1 <= 1'b0;
        end
      end
      if(!unburstify_buffer_valid_1) begin
        if(when_Axi4Channel_l183_1) begin
          if(unburstify_result_ready_1) begin
            unburstify_buffer_valid_1 <= io_axi_ar_valid;
          end
        end
      end
      if(unburstify_result_ready_1) begin
        unburstify_result_rValid <= unburstify_result_valid_1;
      end
    end
  end

  always @(posedge clk) begin
    if(unburstify_result_ready) begin
      unburstify_buffer_beat <= (unburstify_buffer_beat - 8'h01);
      unburstify_buffer_transaction_addr[11 : 0] <= Axi4Incr_result[11 : 0];
    end
    if(!unburstify_buffer_valid) begin
      if(when_Axi4Channel_l183) begin
        if(unburstify_result_ready) begin
          unburstify_buffer_transaction_addr <= io_axi_aw_payload_addr;
          unburstify_buffer_transaction_size <= io_axi_aw_payload_size;
          unburstify_buffer_transaction_burst <= io_axi_aw_payload_burst;
          unburstify_buffer_beat <= io_axi_aw_payload_len;
          unburstify_buffer_len <= io_axi_aw_payload_len;
        end
      end
    end
    if(io_mapper_writeRsp_ready) begin
      io_mapper_writeRsp_rData_resp <= io_mapper_writeRsp_payload_resp;
    end
    if(unburstify_result_ready_1) begin
      unburstify_buffer_beat_1 <= (unburstify_buffer_beat_1 - 8'h01);
      unburstify_buffer_transaction_addr_1[11 : 0] <= Axi4Incr_result_1[11 : 0];
    end
    if(!unburstify_buffer_valid_1) begin
      if(when_Axi4Channel_l183_1) begin
        if(unburstify_result_ready_1) begin
          unburstify_buffer_transaction_addr_1 <= io_axi_ar_payload_addr;
          unburstify_buffer_transaction_size_1 <= io_axi_ar_payload_size;
          unburstify_buffer_transaction_burst_1 <= io_axi_ar_payload_burst;
          unburstify_buffer_beat_1 <= io_axi_ar_payload_len;
          unburstify_buffer_len_1 <= io_axi_ar_payload_len;
        end
      end
    end
    if(unburstify_result_ready_1) begin
      unburstify_result_rData_last <= unburstify_result_payload_last_1;
      unburstify_result_rData_fragment_addr <= unburstify_result_payload_fragment_addr_1;
      unburstify_result_rData_fragment_size <= unburstify_result_payload_fragment_size_1;
      unburstify_result_rData_fragment_burst <= unburstify_result_payload_fragment_burst_1;
    end
    io_reg <= io_reg_driver;
    case(io_mapper_writeAddressMasked)
      32'h0 : begin
        if(io_mapper_writeOccur) begin
          if(when_BusSlaveFactory_l962) begin
            io_reg_driver[7 : 0] <= io_axi_w_payload_data[7 : 0];
          end
          if(when_BusSlaveFactory_l962_1) begin
            io_reg_driver[15 : 8] <= io_axi_w_payload_data[15 : 8];
          end
          if(when_BusSlaveFactory_l962_2) begin
            io_reg_driver[23 : 16] <= io_axi_w_payload_data[23 : 16];
          end
          if(when_BusSlaveFactory_l962_3) begin
            io_reg_driver[31 : 24] <= io_axi_w_payload_data[31 : 24];
          end
        end
      end
      default : begin
      end
    endcase
  end


endmodule



module testbench ;

reg reset;
reg clk;
reg clk2;  
   wire                ramguard_cpuBus_arready;
  wire                ramguard_cpuBus_awready;
  wire                ramguard_cpuBus_wready;
  wire                ramguard_cpuBus_rvalid;
  wire       [127:0]  ramguard_cpuBus_rdata;
  wire       [1:0]    ramguard_cpuBus_rresp;
  wire                ramguard_cpuBus_rlast;
  wire                ramguard_cpuBus_bvalid;
  wire       [1:0]    ramguard_cpuBus_bresp;
  wire                axiMaster_masterAxi_ar_valid;
  wire       [24:0]   axiMaster_masterAxi_ar_payload_addr;
  wire       [7:0]    axiMaster_masterAxi_ar_payload_len;
  wire       [2:0]    axiMaster_masterAxi_ar_payload_size;
  wire       [1:0]    axiMaster_masterAxi_ar_payload_burst;
  wire                axiMaster_masterAxi_aw_valid;
  wire       [24:0]   axiMaster_masterAxi_aw_payload_addr;
  wire       [7:0]    axiMaster_masterAxi_aw_payload_len;
  wire       [2:0]    axiMaster_masterAxi_aw_payload_size;
  wire       [1:0]    axiMaster_masterAxi_aw_payload_burst;
  wire                axiMaster_masterAxi_w_valid;
  wire       [127:0]  axiMaster_masterAxi_w_payload_data;
  wire       [15:0]   axiMaster_masterAxi_w_payload_strb;
  wire                axiMaster_masterAxi_w_payload_last;
  wire                axiMaster_masterAxi_r_ready;
  wire                axiMaster_masterAxi_b_ready;
  wire                axiMaster_tcpBus_rsp_valid;
  wire       [1:0]    axiMaster_tcpBus_rsp_payload;
  wire                axiMaster_tcpBus_rdata_valid;
  wire                axiMaster_tcpBus_rdata_payload_last;
  wire       [127:0]  axiMaster_tcpBus_rdata_payload_fragment;
  wire                axiMaster_tcpBus_wdata_ready;

  Axi4RamGuardWrapper ramguard (
    .cpuBus_awvalid (axiMaster_masterAxi_aw_valid             ), //i
    .cpuBus_awready (ramguard_cpuBus_awready                  ), //o
    .cpuBus_awaddr  (axiMaster_masterAxi_aw_payload_addr[24:0]), //i
    .cpuBus_awlen   (axiMaster_masterAxi_aw_payload_len[7:0]  ), //i
    .cpuBus_awsize  (axiMaster_masterAxi_aw_payload_size[2:0] ), //i
    .cpuBus_awburst (axiMaster_masterAxi_aw_payload_burst[1:0]), //i
    .cpuBus_wvalid  (axiMaster_masterAxi_w_valid              ), //i
    .cpuBus_wready  (ramguard_cpuBus_wready                   ), //o
    .cpuBus_wdata   (axiMaster_masterAxi_w_payload_data[127:0]), //i
    .cpuBus_wstrb   (axiMaster_masterAxi_w_payload_strb[15:0] ), //i
    .cpuBus_wlast   (axiMaster_masterAxi_w_payload_last       ), //i
    .cpuBus_bvalid  (ramguard_cpuBus_bvalid                   ), //o
    .cpuBus_bready  (axiMaster_masterAxi_b_ready              ), //i
    .cpuBus_bresp   (ramguard_cpuBus_bresp[1:0]               ), //o
    .cpuBus_arvalid (axiMaster_masterAxi_ar_valid             ), //i
    .cpuBus_arready (ramguard_cpuBus_arready                  ), //o
    .cpuBus_araddr  (axiMaster_masterAxi_ar_payload_addr[24:0]), //i
    .cpuBus_arlen   (axiMaster_masterAxi_ar_payload_len[7:0]  ), //i
    .cpuBus_arsize  (axiMaster_masterAxi_ar_payload_size[2:0] ), //i
    .cpuBus_arburst (axiMaster_masterAxi_ar_payload_burst[1:0]), //i
    .cpuBus_rvalid  (ramguard_cpuBus_rvalid                   ), //o
    .cpuBus_rready  (axiMaster_masterAxi_r_ready              ), //i
    .cpuBus_rdata   (ramguard_cpuBus_rdata[127:0]             ), //o
    .cpuBus_rresp   (ramguard_cpuBus_rresp[1:0]               ), //o
    .cpuBus_rlast   (ramguard_cpuBus_rlast                    ), //o
    .ACLK           (clk                                 ), //i
    .ARESETn        (!reset                              )  //i
  );
  axi_dpi axiMaster (
    .masterAxi_aw_valid            (axiMaster_masterAxi_aw_valid                  ), //o
    .masterAxi_aw_ready            (ramguard_cpuBus_awready                       ), //i
    .masterAxi_aw_payload_addr     (axiMaster_masterAxi_aw_payload_addr[24:0]     ), //o
    .masterAxi_aw_payload_len      (axiMaster_masterAxi_aw_payload_len[7:0]       ), //o
    .masterAxi_aw_payload_size     (axiMaster_masterAxi_aw_payload_size[2:0]      ), //o
    .masterAxi_aw_payload_burst    (axiMaster_masterAxi_aw_payload_burst[1:0]     ), //o
    .masterAxi_w_valid             (axiMaster_masterAxi_w_valid                   ), //o
    .masterAxi_w_ready             (ramguard_cpuBus_wready                        ), //i
    .masterAxi_w_payload_data      (axiMaster_masterAxi_w_payload_data[127:0]     ), //o
    .masterAxi_w_payload_strb      (axiMaster_masterAxi_w_payload_strb[15:0]      ), //o
    .masterAxi_w_payload_last      (axiMaster_masterAxi_w_payload_last            ), //o
    .masterAxi_b_valid             (ramguard_cpuBus_bvalid                        ), //i
    .masterAxi_b_ready             (axiMaster_masterAxi_b_ready                   ), //o
    .masterAxi_b_payload_resp      (ramguard_cpuBus_bresp[1:0]                    ), //i
    .masterAxi_ar_valid            (axiMaster_masterAxi_ar_valid                  ), //o
    .masterAxi_ar_ready            (ramguard_cpuBus_arready                       ), //i
    .masterAxi_ar_payload_addr     (axiMaster_masterAxi_ar_payload_addr[24:0]     ), //o
    .masterAxi_ar_payload_len      (axiMaster_masterAxi_ar_payload_len[7:0]       ), //o
    .masterAxi_ar_payload_size     (axiMaster_masterAxi_ar_payload_size[2:0]      ), //o
    .masterAxi_ar_payload_burst    (axiMaster_masterAxi_ar_payload_burst[1:0]     ), //o
    .masterAxi_r_valid             (ramguard_cpuBus_rvalid                        ), //i
    .masterAxi_r_ready             (axiMaster_masterAxi_r_ready                   ), //o
    .masterAxi_r_payload_data      (ramguard_cpuBus_rdata[127:0]                  ), //i
    .masterAxi_r_payload_resp      (ramguard_cpuBus_rresp[1:0]                    ), //i
    .masterAxi_r_payload_last      (ramguard_cpuBus_rlast                         ), //i
    .clk                            (clk                                      ), //i
    .reset                           (reset                                    )  //i
  );


initial 
begin 
	$vcdpluson();
    $vcdplusmemon();
    $display("hiii");
    #10;
    reset =1'b0;
    $display("reset 0");
    #10;
    reset =1'b1;
    $display("reset1");
    #(10);
    reset = 1'b0;
    #(100*100);
    //$finish();
   clk=0;
   forever begin 
   	#5 clk=~clk;
   end
end
/*
always 

begin

    clk = 1'b1; 
    #10; 
    clk = 1'b0;
    #10; 
end

always 
begin

    clk2 = 1'b1; 
    #5; 
    clk2 = 1'b0;
    #5; 
end


*/

endmodule
