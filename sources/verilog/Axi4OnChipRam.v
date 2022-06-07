module Axi4OnChipRam (
  input               io_axi_aw_valid,
  output reg          io_axi_aw_ready,
  input      [31:0]   io_axi_aw_payload_addr,
  input      [7:0]    io_axi_aw_payload_len,
  input      [2:0]    io_axi_aw_payload_size,
  input      [1:0]    io_axi_aw_payload_burst,
  input               io_axi_w_valid,
  output              io_axi_w_ready,
  input      [127:0]  io_axi_w_payload_data,
  input      [15:0]   io_axi_w_payload_strb,
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
  output     [127:0]  io_axi_r_payload_data,
  output     [1:0]    io_axi_r_payload_resp,
  output              io_axi_r_payload_last,
  input               clk,
  input               reset
);

  reg        [127:0]  _zz_ram_port0;
  wire       [3:0]    _zz_Axi4Incr_alignMask;
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
  wire       [4:0]    _zz_Axi4Incr_result_13;
  wire       [6:0]    _zz_Axi4Incr_result_14;
  wire       [3:0]    _zz_Axi4Incr_result_15;
  wire       [7:0]    _zz_Axi4Incr_result_16;
  wire       [3:0]    _zz_Axi4Incr_alignMask_1;
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
  wire       [4:0]    _zz_Axi4Incr_result_1_14;
  wire       [6:0]    _zz_Axi4Incr_result_1_15;
  wire       [3:0]    _zz_Axi4Incr_result_1_16;
  wire       [7:0]    _zz_Axi4Incr_result_1_17;
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
  wire       [2:0]    Axi4Incr_validSize;
  reg        [31:0]   Axi4Incr_result;
  wire       [19:0]   Axi4Incr_highCat;
  wire       [4:0]    Axi4Incr_sizeValue;
  wire       [11:0]   Axi4Incr_alignMask;
  wire       [11:0]   Axi4Incr_base;
  wire       [11:0]   Axi4Incr_baseIncr;
  reg        [1:0]    _zz_Axi4Incr_wrapCase;
  wire       [2:0]    Axi4Incr_wrapCase;
  wire                when_Axi4Channel_l183;
  reg                 unburstify_result_valid_1;
  wire                unburstify_result_ready_1;
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
  wire       [2:0]    Axi4Incr_validSize_1;
  reg        [31:0]   Axi4Incr_result_1;
  wire       [19:0]   Axi4Incr_highCat_1;
  wire       [4:0]    Axi4Incr_sizeValue_1;
  wire       [11:0]   Axi4Incr_alignMask_1;
  wire       [11:0]   Axi4Incr_base_1;
  wire       [11:0]   Axi4Incr_baseIncr_1;
  reg        [1:0]    _zz_Axi4Incr_wrapCase_1;
  wire       [2:0]    Axi4Incr_wrapCase_1;
  wire                when_Axi4Channel_l183_1;
  wire                _zz_unburstify_result_ready;
  wire                ramWrite;
  reg                 stage0W_ready;
  wire                stage0W_payload_last;
  wire       [31:0]   stage0W_payload_fragment_addr;
  wire       [2:0]    stage0W_payload_fragment_size;
  wire       [1:0]    stage0W_payload_fragment_burst;
  wire                _zz_unburstify_result_ready_1;
  wire                stage0R_valid;
  reg                 stage0R_ready;
  wire                stage0R_payload_last;
  wire       [31:0]   stage0R_payload_fragment_addr;
  wire       [2:0]    stage0R_payload_fragment_size;
  wire       [1:0]    stage0R_payload_fragment_burst;
  reg        [31:0]   addr;
  reg        [15:0]   strb;
  wire                stage0W_fire;
  wire                stage0R_fire;
  wire                ramAccess;
  wire       [127:0]  ramReadData;
  wire       [127:0]  ramWriteData;
  wire       [27:0]   _zz_ramReadData;
  wire       [127:0]  _zz_ramReadData_1;
  wire                stage1W_valid;
  wire                stage1W_ready;
  wire                stage1W_payload_last;
  wire       [31:0]   stage1W_payload_fragment_addr;
  wire       [2:0]    stage1W_payload_fragment_size;
  wire       [1:0]    stage1W_payload_fragment_burst;
  reg                 stage0W_rValid;
  reg                 stage0W_rData_last;
  reg        [31:0]   stage0W_rData_fragment_addr;
  reg        [2:0]    stage0W_rData_fragment_size;
  reg        [1:0]    stage0W_rData_fragment_burst;
  wire                when_Stream_l368;
  wire                stage1R_valid;
  wire                stage1R_ready;
  wire                stage1R_payload_last;
  wire       [31:0]   stage1R_payload_fragment_addr;
  wire       [2:0]    stage1R_payload_fragment_size;
  wire       [1:0]    stage1R_payload_fragment_burst;
  reg                 stage0R_rValid;
  reg                 stage0R_rData_last;
  reg        [31:0]   stage0R_rData_fragment_addr;
  reg        [2:0]    stage0R_rData_fragment_size;
  reg        [1:0]    stage0R_rData_fragment_burst;
  wire                when_Stream_l368_1;
  reg [7:0] ram_symbol0 [0:100];
  reg [7:0] ram_symbol1 [0:100];
  reg [7:0] ram_symbol2 [0:100];
  reg [7:0] ram_symbol3 [0:100];
  reg [7:0] ram_symbol4 [0:100];
  reg [7:0] ram_symbol5 [0:100];
  reg [7:0] ram_symbol6 [0:100];
  reg [7:0] ram_symbol7 [0:100];
  reg [7:0] ram_symbol8 [0:100];
  reg [7:0] ram_symbol9 [0:100];
  reg [7:0] ram_symbol10 [0:100];
  reg [7:0] ram_symbol11 [0:100];
  reg [7:0] ram_symbol12 [0:100];
  reg [7:0] ram_symbol13 [0:100];
  reg [7:0] ram_symbol14 [0:100];
  reg [7:0] ram_symbol15 [0:100];
  reg [7:0] _zz_ramsymbol_read;
  reg [7:0] _zz_ramsymbol_read_1;
  reg [7:0] _zz_ramsymbol_read_2;
  reg [7:0] _zz_ramsymbol_read_3;
  reg [7:0] _zz_ramsymbol_read_4;
  reg [7:0] _zz_ramsymbol_read_5;
  reg [7:0] _zz_ramsymbol_read_6;
  reg [7:0] _zz_ramsymbol_read_7;
  reg [7:0] _zz_ramsymbol_read_8;
  reg [7:0] _zz_ramsymbol_read_9;
  reg [7:0] _zz_ramsymbol_read_10;
  reg [7:0] _zz_ramsymbol_read_11;
  reg [7:0] _zz_ramsymbol_read_12;
  reg [7:0] _zz_ramsymbol_read_13;
  reg [7:0] _zz_ramsymbol_read_14;
  reg [7:0] _zz_ramsymbol_read_15;

  assign _zz_Axi4Incr_alignMask = {(3'b011 < Axi4Incr_validSize),{(3'b010 < Axi4Incr_validSize),{(3'b001 < Axi4Incr_validSize),(3'b000 < Axi4Incr_validSize)}}};
  assign _zz_Axi4Incr_base_1 = unburstify_buffer_transaction_addr[11 : 0];
  assign _zz_Axi4Incr_base = _zz_Axi4Incr_base_1;
  assign _zz_Axi4Incr_baseIncr = {7'd0, Axi4Incr_sizeValue};
  assign _zz_Axi4Incr_wrapCase_2 = Axi4Incr_validSize;
  assign _zz_Axi4Incr_wrapCase_3 = {1'd0, _zz_Axi4Incr_wrapCase};
  assign _zz_Axi4Incr_alignMask_1 = {(3'b011 < Axi4Incr_validSize_1),{(3'b010 < Axi4Incr_validSize_1),{(3'b001 < Axi4Incr_validSize_1),(3'b000 < Axi4Incr_validSize_1)}}};
  assign _zz_Axi4Incr_base_1_2 = unburstify_buffer_transaction_addr_1[11 : 0];
  assign _zz_Axi4Incr_base_1_1 = _zz_Axi4Incr_base_1_2;
  assign _zz_Axi4Incr_baseIncr_1 = {7'd0, Axi4Incr_sizeValue_1};
  assign _zz_Axi4Incr_wrapCase_1_1 = Axi4Incr_validSize_1;
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
  assign _zz_Axi4Incr_result_13 = Axi4Incr_base[11 : 7];
  assign _zz_Axi4Incr_result_14 = Axi4Incr_baseIncr[6 : 0];
  assign _zz_Axi4Incr_result_15 = Axi4Incr_base[11 : 8];
  assign _zz_Axi4Incr_result_16 = Axi4Incr_baseIncr[7 : 0];
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
  assign _zz_Axi4Incr_result_1_14 = Axi4Incr_base_1[11 : 7];
  assign _zz_Axi4Incr_result_1_15 = Axi4Incr_baseIncr_1[6 : 0];
  assign _zz_Axi4Incr_result_1_16 = Axi4Incr_base_1[11 : 8];
  assign _zz_Axi4Incr_result_1_17 = Axi4Incr_baseIncr_1[7 : 0];
  always @(*) begin
    _zz_ram_port0 = {_zz_ramsymbol_read_15, _zz_ramsymbol_read_14, _zz_ramsymbol_read_13, _zz_ramsymbol_read_12, _zz_ramsymbol_read_11, _zz_ramsymbol_read_10, _zz_ramsymbol_read_9, _zz_ramsymbol_read_8, _zz_ramsymbol_read_7, _zz_ramsymbol_read_6, _zz_ramsymbol_read_5, _zz_ramsymbol_read_4, _zz_ramsymbol_read_3, _zz_ramsymbol_read_2, _zz_ramsymbol_read_1, _zz_ramsymbol_read};
  end
  always @(posedge clk) begin
    if(ramAccess) begin
      _zz_ramsymbol_read <= ram_symbol0[_zz_ramReadData];
      _zz_ramsymbol_read_1 <= ram_symbol1[_zz_ramReadData];
      _zz_ramsymbol_read_2 <= ram_symbol2[_zz_ramReadData];
      _zz_ramsymbol_read_3 <= ram_symbol3[_zz_ramReadData];
      _zz_ramsymbol_read_4 <= ram_symbol4[_zz_ramReadData];
      _zz_ramsymbol_read_5 <= ram_symbol5[_zz_ramReadData];
      _zz_ramsymbol_read_6 <= ram_symbol6[_zz_ramReadData];
      _zz_ramsymbol_read_7 <= ram_symbol7[_zz_ramReadData];
      _zz_ramsymbol_read_8 <= ram_symbol8[_zz_ramReadData];
      _zz_ramsymbol_read_9 <= ram_symbol9[_zz_ramReadData];
      _zz_ramsymbol_read_10 <= ram_symbol10[_zz_ramReadData];
      _zz_ramsymbol_read_11 <= ram_symbol11[_zz_ramReadData];
      _zz_ramsymbol_read_12 <= ram_symbol12[_zz_ramReadData];
      _zz_ramsymbol_read_13 <= ram_symbol13[_zz_ramReadData];
      _zz_ramsymbol_read_14 <= ram_symbol14[_zz_ramReadData];
      _zz_ramsymbol_read_15 <= ram_symbol15[_zz_ramReadData];
    end
  end

  always @(posedge clk) begin
    if(strb[0] && ramAccess && ramWrite ) begin
      ram_symbol0[_zz_ramReadData] <= _zz_ramReadData_1[7 : 0];
    end
    if(strb[1] && ramAccess && ramWrite ) begin
      ram_symbol1[_zz_ramReadData] <= _zz_ramReadData_1[15 : 8];
    end
    if(strb[2] && ramAccess && ramWrite ) begin
      ram_symbol2[_zz_ramReadData] <= _zz_ramReadData_1[23 : 16];
    end
    if(strb[3] && ramAccess && ramWrite ) begin
      ram_symbol3[_zz_ramReadData] <= _zz_ramReadData_1[31 : 24];
    end
    if(strb[4] && ramAccess && ramWrite ) begin
      ram_symbol4[_zz_ramReadData] <= _zz_ramReadData_1[39 : 32];
    end
    if(strb[5] && ramAccess && ramWrite ) begin
      ram_symbol5[_zz_ramReadData] <= _zz_ramReadData_1[47 : 40];
    end
    if(strb[6] && ramAccess && ramWrite ) begin
      ram_symbol6[_zz_ramReadData] <= _zz_ramReadData_1[55 : 48];
    end
    if(strb[7] && ramAccess && ramWrite ) begin
      ram_symbol7[_zz_ramReadData] <= _zz_ramReadData_1[63 : 56];
    end
    if(strb[8] && ramAccess && ramWrite ) begin
      ram_symbol8[_zz_ramReadData] <= _zz_ramReadData_1[71 : 64];
    end
    if(strb[9] && ramAccess && ramWrite ) begin
      ram_symbol9[_zz_ramReadData] <= _zz_ramReadData_1[79 : 72];
    end
    if(strb[10] && ramAccess && ramWrite ) begin
      ram_symbol10[_zz_ramReadData] <= _zz_ramReadData_1[87 : 80];
    end
    if(strb[11] && ramAccess && ramWrite ) begin
      ram_symbol11[_zz_ramReadData] <= _zz_ramReadData_1[95 : 88];
    end
    if(strb[12] && ramAccess && ramWrite ) begin
      ram_symbol12[_zz_ramReadData] <= _zz_ramReadData_1[103 : 96];
    end
    if(strb[13] && ramAccess && ramWrite ) begin
      ram_symbol13[_zz_ramReadData] <= _zz_ramReadData_1[111 : 104];
    end
    if(strb[14] && ramAccess && ramWrite ) begin
      ram_symbol14[_zz_ramReadData] <= _zz_ramReadData_1[119 : 112];
    end
    if(strb[15] && ramAccess && ramWrite ) begin
      ram_symbol15[_zz_ramReadData] <= _zz_ramReadData_1[127 : 120];
    end
  end

  always @(*) begin
    case(Axi4Incr_wrapCase)
      3'b000 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_1,_zz_Axi4Incr_result_2};
      3'b001 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_3,_zz_Axi4Incr_result_4};
      3'b010 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_5,_zz_Axi4Incr_result_6};
      3'b011 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_7,_zz_Axi4Incr_result_8};
      3'b100 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_9,_zz_Axi4Incr_result_10};
      3'b101 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_11,_zz_Axi4Incr_result_12};
      3'b110 : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_13,_zz_Axi4Incr_result_14};
      default : _zz_Axi4Incr_result = {_zz_Axi4Incr_result_15,_zz_Axi4Incr_result_16};
    endcase
  end

  always @(*) begin
    case(Axi4Incr_wrapCase_1)
      3'b000 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_2,_zz_Axi4Incr_result_1_3};
      3'b001 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_4,_zz_Axi4Incr_result_1_5};
      3'b010 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_6,_zz_Axi4Incr_result_1_7};
      3'b011 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_8,_zz_Axi4Incr_result_1_9};
      3'b100 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_10,_zz_Axi4Incr_result_1_11};
      3'b101 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_12,_zz_Axi4Incr_result_1_13};
      3'b110 : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_14,_zz_Axi4Incr_result_1_15};
      default : _zz_Axi4Incr_result_1_1 = {_zz_Axi4Incr_result_1_16,_zz_Axi4Incr_result_1_17};
    endcase
  end

  assign unburstify_buffer_last = (unburstify_buffer_beat == 8'h01);
  assign Axi4Incr_validSize = unburstify_buffer_transaction_size[2 : 0];
  assign Axi4Incr_highCat = unburstify_buffer_transaction_addr[31 : 12];
  assign Axi4Incr_sizeValue = {(3'b100 == Axi4Incr_validSize),{(3'b011 == Axi4Incr_validSize),{(3'b010 == Axi4Incr_validSize),{(3'b001 == Axi4Incr_validSize),(3'b000 == Axi4Incr_validSize)}}}};
  assign Axi4Incr_alignMask = {8'd0, _zz_Axi4Incr_alignMask};
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
  assign unburstify_buffer_last_1 = (unburstify_buffer_beat_1 == 8'h01);
  assign Axi4Incr_validSize_1 = unburstify_buffer_transaction_size_1[2 : 0];
  assign Axi4Incr_highCat_1 = unburstify_buffer_transaction_addr_1[31 : 12];
  assign Axi4Incr_sizeValue_1 = {(3'b100 == Axi4Incr_validSize_1),{(3'b011 == Axi4Incr_validSize_1),{(3'b010 == Axi4Incr_validSize_1),{(3'b001 == Axi4Incr_validSize_1),(3'b000 == Axi4Incr_validSize_1)}}}};
  assign Axi4Incr_alignMask_1 = {8'd0, _zz_Axi4Incr_alignMask_1};
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
  assign _zz_unburstify_result_ready = (! (unburstify_result_valid && (! io_axi_w_valid)));
  assign ramWrite = (unburstify_result_valid && _zz_unburstify_result_ready);
  assign unburstify_result_ready = (stage0W_ready && _zz_unburstify_result_ready);
  assign stage0W_payload_last = unburstify_result_payload_last;
  assign stage0W_payload_fragment_addr = unburstify_result_payload_fragment_addr;
  assign stage0W_payload_fragment_size = unburstify_result_payload_fragment_size;
  assign stage0W_payload_fragment_burst = unburstify_result_payload_fragment_burst;
  assign _zz_unburstify_result_ready_1 = (! unburstify_result_valid);
  assign stage0R_valid = (unburstify_result_valid_1 && _zz_unburstify_result_ready_1);
  assign unburstify_result_ready_1 = (stage0R_ready && _zz_unburstify_result_ready_1);
  assign stage0R_payload_last = unburstify_result_payload_last_1;
  assign stage0R_payload_fragment_addr = unburstify_result_payload_fragment_addr_1;
  assign stage0R_payload_fragment_size = unburstify_result_payload_fragment_size_1;
  assign stage0R_payload_fragment_burst = unburstify_result_payload_fragment_burst_1;
  always @(*) begin
    if(ramWrite) begin
      addr = stage0W_payload_fragment_addr;
    end else begin
      addr = stage0R_payload_fragment_addr;
    end
  end

  always @(*) begin
    if(ramWrite) begin
      strb = io_axi_w_payload_strb;
    end else begin
      strb = 16'hffff;
    end
  end

  assign stage0W_fire = (ramWrite && stage0W_ready);
  assign stage0R_fire = (stage0R_valid && stage0R_ready);
  assign ramAccess = (stage0W_fire || stage0R_fire);
  assign io_axi_r_payload_data = ramReadData;
  assign ramWriteData = io_axi_w_payload_data;
  assign _zz_ramReadData = addr[31 : 4];
  assign _zz_ramReadData_1 = ramWriteData;
  assign ramReadData = _zz_ram_port0;
  assign io_axi_w_ready = (unburstify_result_valid && stage0W_ready);
  always @(*) begin
    stage0W_ready = stage1W_ready;
    if(when_Stream_l368) begin
      stage0W_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! stage1W_valid);
  assign stage1W_valid = stage0W_rValid;
  assign stage1W_payload_last = stage0W_rData_last;
  assign stage1W_payload_fragment_addr = stage0W_rData_fragment_addr;
  assign stage1W_payload_fragment_size = stage0W_rData_fragment_size;
  assign stage1W_payload_fragment_burst = stage0W_rData_fragment_burst;
  always @(*) begin
    stage0R_ready = stage1R_ready;
    if(when_Stream_l368_1) begin
      stage0R_ready = 1'b1;
    end
  end

  assign when_Stream_l368_1 = (! stage1R_valid);
  assign stage1R_valid = stage0R_rValid;
  assign stage1R_payload_last = stage0R_rData_last;
  assign stage1R_payload_fragment_addr = stage0R_rData_fragment_addr;
  assign stage1R_payload_fragment_size = stage0R_rData_fragment_size;
  assign stage1R_payload_fragment_burst = stage0R_rData_fragment_burst;
  assign stage1W_ready = (io_axi_b_ready || (! stage1W_payload_last));
  assign stage1R_ready = io_axi_r_ready;
  assign io_axi_r_valid = stage1R_valid;
  assign io_axi_r_payload_last = stage1R_payload_last;
  assign io_axi_r_payload_resp = 2'b00;
  assign io_axi_b_valid = (stage1W_valid && stage1W_payload_last);
  assign io_axi_b_payload_resp = 2'b00;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      unburstify_buffer_valid <= 1'b0;
      unburstify_buffer_valid_1 <= 1'b0;
      stage0W_rValid <= 1'b0;
      stage0R_rValid <= 1'b0;
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
      if(stage0W_ready) begin
        stage0W_rValid <= ramWrite;
      end
      if(stage0R_ready) begin
        stage0R_rValid <= stage0R_valid;
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
    if(stage0W_ready) begin
      stage0W_rData_last <= stage0W_payload_last;
      stage0W_rData_fragment_addr <= stage0W_payload_fragment_addr;
      stage0W_rData_fragment_size <= stage0W_payload_fragment_size;
      stage0W_rData_fragment_burst <= stage0W_payload_fragment_burst;
    end
    if(stage0R_ready) begin
      stage0R_rData_last <= stage0R_payload_last;
      stage0R_rData_fragment_addr <= stage0R_payload_fragment_addr;
      stage0R_rData_fragment_size <= stage0R_payload_fragment_size;
      stage0R_rData_fragment_burst <= stage0R_payload_fragment_burst;
    end
  end


endmodule
