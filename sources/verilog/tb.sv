`timescale 1ns/1ps

module testbench (
  input               clk,
  input               reset
);

  wire                ram_io_axi_ar_ready;
  wire                ram_io_axi_aw_ready;
  wire                ram_io_axi_w_ready;
  wire                ram_io_axi_r_valid;
  wire       [31:0]   ram_io_axi_r_payload_data;
  wire       [0:0]    ram_io_axi_r_payload_id;
  wire       [1:0]    ram_io_axi_r_payload_resp;
  wire                ram_io_axi_r_payload_last;
  wire                ram_io_axi_b_valid;
  wire       [0:0]    ram_io_axi_b_payload_id;
  wire       [1:0]    ram_io_axi_b_payload_resp;
  wire                aximaster_masterAxi_ar_valid;
  wire       [31:0]   aximaster_masterAxi_ar_payload_addr;
  wire       [0:0]    aximaster_masterAxi_ar_payload_id;
  wire       [3:0]    aximaster_masterAxi_ar_payload_region;
  wire       [7:0]    aximaster_masterAxi_ar_payload_len;
  wire       [2:0]    aximaster_masterAxi_ar_payload_size;
  wire       [1:0]    aximaster_masterAxi_ar_payload_burst;
  wire       [0:0]    aximaster_masterAxi_ar_payload_lock;
  wire       [3:0]    aximaster_masterAxi_ar_payload_cache;
  wire       [3:0]    aximaster_masterAxi_ar_payload_qos;
  wire       [2:0]    aximaster_masterAxi_ar_payload_prot;
  wire                aximaster_masterAxi_aw_valid;
  wire       [31:0]   aximaster_masterAxi_aw_payload_addr;
  wire       [0:0]    aximaster_masterAxi_aw_payload_id;
  wire       [3:0]    aximaster_masterAxi_aw_payload_region;
  wire       [7:0]    aximaster_masterAxi_aw_payload_len;
  wire       [2:0]    aximaster_masterAxi_aw_payload_size;
  wire       [1:0]    aximaster_masterAxi_aw_payload_burst;
  wire       [0:0]    aximaster_masterAxi_aw_payload_lock;
  wire       [3:0]    aximaster_masterAxi_aw_payload_cache;
  wire       [3:0]    aximaster_masterAxi_aw_payload_qos;
  wire       [2:0]    aximaster_masterAxi_aw_payload_prot;
  wire                aximaster_masterAxi_w_valid;
  wire       [31:0]   aximaster_masterAxi_w_payload_data;
  wire       [3:0]    aximaster_masterAxi_w_payload_strb;
  wire                aximaster_masterAxi_w_payload_last;
  wire                aximaster_masterAxi_r_ready;
  wire                aximaster_masterAxi_b_ready;

  unamed ram (
    .io_axi_aw_valid          (aximaster_masterAxi_aw_valid              ), //i
    .io_axi_aw_ready          (ram_io_axi_aw_ready                       ), //o
    .io_axi_aw_payload_addr   (aximaster_masterAxi_aw_payload_addr[31:0] ), //i
    .io_axi_aw_payload_id     (aximaster_masterAxi_aw_payload_id         ), //i
    .io_axi_aw_payload_region (aximaster_masterAxi_aw_payload_region[3:0]), //i
    .io_axi_aw_payload_len    (aximaster_masterAxi_aw_payload_len[7:0]   ), //i
    .io_axi_aw_payload_size   (aximaster_masterAxi_aw_payload_size[2:0]  ), //i
    .io_axi_aw_payload_burst  (aximaster_masterAxi_aw_payload_burst[1:0] ), //i
    .io_axi_aw_payload_lock   (aximaster_masterAxi_aw_payload_lock       ), //i
    .io_axi_aw_payload_cache  (aximaster_masterAxi_aw_payload_cache[3:0] ), //i
    .io_axi_aw_payload_qos    (aximaster_masterAxi_aw_payload_qos[3:0]   ), //i
    .io_axi_aw_payload_prot   (aximaster_masterAxi_aw_payload_prot[2:0]  ), //i
    .io_axi_w_valid           (aximaster_masterAxi_w_valid               ), //i
    .io_axi_w_ready           (ram_io_axi_w_ready                        ), //o
    .io_axi_w_payload_data    (aximaster_masterAxi_w_payload_data[31:0]  ), //i
    .io_axi_w_payload_strb    (aximaster_masterAxi_w_payload_strb[3:0]   ), //i
    .io_axi_w_payload_last    (aximaster_masterAxi_w_payload_last        ), //i
    .io_axi_b_valid           (ram_io_axi_b_valid                        ), //o
    .io_axi_b_ready           (aximaster_masterAxi_b_ready               ), //i
    .io_axi_b_payload_id      (ram_io_axi_b_payload_id                   ), //o
    .io_axi_b_payload_resp    (ram_io_axi_b_payload_resp[1:0]            ), //o
    .io_axi_ar_valid          (aximaster_masterAxi_ar_valid              ), //i
    .io_axi_ar_ready          (ram_io_axi_ar_ready                       ), //o
    .io_axi_ar_payload_addr   (aximaster_masterAxi_ar_payload_addr[31:0] ), //i
    .io_axi_ar_payload_id     (aximaster_masterAxi_ar_payload_id         ), //i
    .io_axi_ar_payload_region (aximaster_masterAxi_ar_payload_region[3:0]), //i
    .io_axi_ar_payload_len    (aximaster_masterAxi_ar_payload_len[7:0]   ), //i
    .io_axi_ar_payload_size   (aximaster_masterAxi_ar_payload_size[2:0]  ), //i
    .io_axi_ar_payload_burst  (aximaster_masterAxi_ar_payload_burst[1:0] ), //i
    .io_axi_ar_payload_lock   (aximaster_masterAxi_ar_payload_lock       ), //i
    .io_axi_ar_payload_cache  (aximaster_masterAxi_ar_payload_cache[3:0] ), //i
    .io_axi_ar_payload_qos    (aximaster_masterAxi_ar_payload_qos[3:0]   ), //i
    .io_axi_ar_payload_prot   (aximaster_masterAxi_ar_payload_prot[2:0]  ), //i
    .io_axi_r_valid           (ram_io_axi_r_valid                        ), //o
    .io_axi_r_ready           (aximaster_masterAxi_r_ready               ), //i
    .io_axi_r_payload_data    (ram_io_axi_r_payload_data[31:0]           ), //o
    .io_axi_r_payload_id      (ram_io_axi_r_payload_id                   ), //o
    .io_axi_r_payload_resp    (ram_io_axi_r_payload_resp[1:0]            ), //o
    .io_axi_r_payload_last    (ram_io_axi_r_payload_last                 ), //o
    .clk                      (clk                                       ), //i
    .reset                    (reset                                     )  //i
  );
  simpleAxi4Master axi_dpi (
    .masterAxi_aw_valid          (aximaster_masterAxi_aw_valid              ), //o
    .masterAxi_aw_ready          (ram_io_axi_aw_ready                       ), //i
    .masterAxi_aw_payload_addr   (aximaster_masterAxi_aw_payload_addr[31:0] ), //o
    .masterAxi_aw_payload_id     (aximaster_masterAxi_aw_payload_id         ), //o
    .masterAxi_aw_payload_region (aximaster_masterAxi_aw_payload_region[3:0]), //o
    .masterAxi_aw_payload_len    (aximaster_masterAxi_aw_payload_len[7:0]   ), //o
    .masterAxi_aw_payload_size   (aximaster_masterAxi_aw_payload_size[2:0]  ), //o
    .masterAxi_aw_payload_burst  (aximaster_masterAxi_aw_payload_burst[1:0] ), //o
    .masterAxi_aw_payload_lock   (aximaster_masterAxi_aw_payload_lock       ), //o
    .masterAxi_aw_payload_cache  (aximaster_masterAxi_aw_payload_cache[3:0] ), //o
    .masterAxi_aw_payload_qos    (aximaster_masterAxi_aw_payload_qos[3:0]   ), //o
    .masterAxi_aw_payload_prot   (aximaster_masterAxi_aw_payload_prot[2:0]  ), //o
    .masterAxi_w_valid           (aximaster_masterAxi_w_valid               ), //o
    .masterAxi_w_ready           (ram_io_axi_w_ready                        ), //i
    .masterAxi_w_payload_data    (aximaster_masterAxi_w_payload_data[31:0]  ), //o
    .masterAxi_w_payload_strb    (aximaster_masterAxi_w_payload_strb[3:0]   ), //o
    .masterAxi_w_payload_last    (aximaster_masterAxi_w_payload_last        ), //o
    .masterAxi_b_valid           (ram_io_axi_b_valid                        ), //i
    .masterAxi_b_ready           (aximaster_masterAxi_b_ready               ), //o
    .masterAxi_b_payload_id      (ram_io_axi_b_payload_id                   ), //i
    .masterAxi_b_payload_resp    (ram_io_axi_b_payload_resp[1:0]            ), //i
    .masterAxi_ar_valid          (aximaster_masterAxi_ar_valid              ), //o
    .masterAxi_ar_ready          (ram_io_axi_ar_ready                       ), //i
    .masterAxi_ar_payload_addr   (aximaster_masterAxi_ar_payload_addr[31:0] ), //o
    .masterAxi_ar_payload_id     (aximaster_masterAxi_ar_payload_id         ), //o
    .masterAxi_ar_payload_region (aximaster_masterAxi_ar_payload_region[3:0]), //o
    .masterAxi_ar_payload_len    (aximaster_masterAxi_ar_payload_len[7:0]   ), //o
    .masterAxi_ar_payload_size   (aximaster_masterAxi_ar_payload_size[2:0]  ), //o
    .masterAxi_ar_payload_burst  (aximaster_masterAxi_ar_payload_burst[1:0] ), //o
    .masterAxi_ar_payload_lock   (aximaster_masterAxi_ar_payload_lock       ), //o
    .masterAxi_ar_payload_cache  (aximaster_masterAxi_ar_payload_cache[3:0] ), //o
    .masterAxi_ar_payload_qos    (aximaster_masterAxi_ar_payload_qos[3:0]   ), //o
    .masterAxi_ar_payload_prot   (aximaster_masterAxi_ar_payload_prot[2:0]  ), //o
    .masterAxi_r_valid           (ram_io_axi_r_valid                        ), //i
    .masterAxi_r_ready           (aximaster_masterAxi_r_ready               ), //o
    .masterAxi_r_payload_data    (ram_io_axi_r_payload_data[31:0]           ), //i
    .masterAxi_r_payload_id      (ram_io_axi_r_payload_id                   ), //i
    .masterAxi_r_payload_resp    (ram_io_axi_r_payload_resp[1:0]            ), //i
    .masterAxi_r_payload_last    (ram_io_axi_r_payload_last                 ), //i
    .clk                         (clk                                       ), //i
    .reset                       (reset                                     )  //i
  );

endmodule