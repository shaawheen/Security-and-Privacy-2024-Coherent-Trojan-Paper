`include "rggen_rtl_macros.vh"
module devil_register_file #(
  parameter ADDRESS_WIDTH = 6,
  parameter PRE_DECODE = 0,
  parameter [ADDRESS_WIDTH-1:0] BASE_ADDRESS = 0,
  parameter ERROR_STATUS = 0,
  parameter [31:0] DEFAULT_READ_DATA = 0,
  parameter INSERT_SLICER = 0,
  parameter ID_WIDTH = 0,
  parameter WRITE_FIRST = 1
)(
  input i_clk,
  input i_rst_n,
  input i_awvalid,
  output o_awready,
  input [((ID_WIDTH == 0) ? 1 : ID_WIDTH)-1:0] i_awid,
  input [ADDRESS_WIDTH-1:0] i_awaddr,
  input [2:0] i_awprot,
  input i_wvalid,
  output o_wready,
  input [31:0] i_wdata,
  input [3:0] i_wstrb,
  output o_bvalid,
  input i_bready,
  output [((ID_WIDTH == 0) ? 1 : ID_WIDTH)-1:0] o_bid,
  output [1:0] o_bresp,
  input i_arvalid,
  output o_arready,
  input [((ID_WIDTH == 0) ? 1 : ID_WIDTH)-1:0] i_arid,
  input [ADDRESS_WIDTH-1:0] i_araddr,
  input [2:0] i_arprot,
  output o_rvalid,
  input i_rready,
  output [((ID_WIDTH == 0) ? 1 : ID_WIDTH)-1:0] o_rid,
  output [31:0] o_rdata,
  output [1:0] o_rresp,
  output o_control_EN,
  output [3:0] o_control_TEST,
  output [3:0] o_control_FUNC,
  output [4:0] o_control_CRRESP,
  output o_control_ACFLT,
  output o_control_ADDRFLT,
  output o_control_OSHEN,
  output o_control_CONEN,
  output o_status_OSH_END,
  input i_status_OSH_END_hw_set,
  output [31:0] o_delay_data,
  output [3:0] o_acsnoop_type,
  output [31:0] o_base_addr_Data,
  output [31:0] o_mem_size_Data
);
  wire w_register_valid;
  wire [1:0] w_register_access;
  wire [5:0] w_register_address;
  wire [31:0] w_register_write_data;
  wire [3:0] w_register_strobe;
  wire [5:0] w_register_active;
  wire [5:0] w_register_ready;
  wire [11:0] w_register_status;
  wire [191:0] w_register_read_data;
  wire [191:0] w_register_value;
  rggen_axi4lite_adapter #(
    .ID_WIDTH             (ID_WIDTH),
    .ADDRESS_WIDTH        (ADDRESS_WIDTH),
    .LOCAL_ADDRESS_WIDTH  (6),
    .BUS_WIDTH            (32),
    .REGISTERS            (6),
    .PRE_DECODE           (PRE_DECODE),
    .BASE_ADDRESS         (BASE_ADDRESS),
    .BYTE_SIZE            (64),
    .ERROR_STATUS         (ERROR_STATUS),
    .DEFAULT_READ_DATA    (DEFAULT_READ_DATA),
    .INSERT_SLICER        (INSERT_SLICER),
    .WRITE_FIRST          (WRITE_FIRST)
  ) u_adapter (
    .i_clk                  (i_clk),
    .i_rst_n                (i_rst_n),
    .i_awvalid              (i_awvalid),
    .o_awready              (o_awready),
    .i_awid                 (i_awid),
    .i_awaddr               (i_awaddr),
    .i_awprot               (i_awprot),
    .i_wvalid               (i_wvalid),
    .o_wready               (o_wready),
    .i_wdata                (i_wdata),
    .i_wstrb                (i_wstrb),
    .o_bvalid               (o_bvalid),
    .i_bready               (i_bready),
    .o_bid                  (o_bid),
    .o_bresp                (o_bresp),
    .i_arvalid              (i_arvalid),
    .o_arready              (o_arready),
    .i_arid                 (i_arid),
    .i_araddr               (i_araddr),
    .i_arprot               (i_arprot),
    .o_rvalid               (o_rvalid),
    .i_rready               (i_rready),
    .o_rid                  (o_rid),
    .o_rdata                (o_rdata),
    .o_rresp                (o_rresp),
    .o_register_valid       (w_register_valid),
    .o_register_access      (w_register_access),
    .o_register_address     (w_register_address),
    .o_register_write_data  (w_register_write_data),
    .o_register_strobe      (w_register_strobe),
    .i_register_active      (w_register_active),
    .i_register_ready       (w_register_ready),
    .i_register_status      (w_register_status),
    .i_register_read_data   (w_register_read_data)
  );
  generate if (1) begin : g_control
    wire w_bit_field_valid;
    wire [31:0] w_bit_field_read_mask;
    wire [31:0] w_bit_field_write_mask;
    wire [31:0] w_bit_field_write_data;
    wire [31:0] w_bit_field_read_data;
    wire [31:0] w_bit_field_value;
    `rggen_tie_off_unused_signals(32, 32'h0003ffff, w_bit_field_read_data, w_bit_field_value)
    rggen_default_register #(
      .READABLE       (1),
      .WRITABLE       (1),
      .ADDRESS_WIDTH  (6),
      .OFFSET_ADDRESS (6'h00),
      .BUS_WIDTH      (32),
      .DATA_WIDTH     (32)
    ) u_register (
      .i_clk                  (i_clk),
      .i_rst_n                (i_rst_n),
      .i_register_valid       (w_register_valid),
      .i_register_access      (w_register_access),
      .i_register_address     (w_register_address),
      .i_register_write_data  (w_register_write_data),
      .i_register_strobe      (w_register_strobe),
      .o_register_active      (w_register_active[0+:1]),
      .o_register_ready       (w_register_ready[0+:1]),
      .o_register_status      (w_register_status[0+:2]),
      .o_register_read_data   (w_register_read_data[0+:32]),
      .o_register_value       (w_register_value[0+:32]),
      .o_bit_field_valid      (w_bit_field_valid),
      .o_bit_field_read_mask  (w_bit_field_read_mask),
      .o_bit_field_write_mask (w_bit_field_write_mask),
      .o_bit_field_write_data (w_bit_field_write_data),
      .i_bit_field_read_data  (w_bit_field_read_data),
      .i_bit_field_value      (w_bit_field_value)
    );
    if (1) begin : g_EN
      rggen_bit_field #(
        .WIDTH          (1),
        .INITIAL_VALUE  (1'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[0+:1]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[0+:1]),
        .i_sw_write_data    (w_bit_field_write_data[0+:1]),
        .o_sw_read_data     (w_bit_field_read_data[0+:1]),
        .o_sw_value         (w_bit_field_value[0+:1]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({1{1'b0}}),
        .i_hw_set           ({1{1'b0}}),
        .i_hw_clear         ({1{1'b0}}),
        .i_value            ({1{1'b0}}),
        .i_mask             ({1{1'b1}}),
        .o_value            (o_control_EN),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_TEST
      rggen_bit_field #(
        .WIDTH          (4),
        .INITIAL_VALUE  (4'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[1+:4]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[1+:4]),
        .i_sw_write_data    (w_bit_field_write_data[1+:4]),
        .o_sw_read_data     (w_bit_field_read_data[1+:4]),
        .o_sw_value         (w_bit_field_value[1+:4]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({4{1'b0}}),
        .i_hw_set           ({4{1'b0}}),
        .i_hw_clear         ({4{1'b0}}),
        .i_value            ({4{1'b0}}),
        .i_mask             ({4{1'b1}}),
        .o_value            (o_control_TEST),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_FUNC
      rggen_bit_field #(
        .WIDTH          (4),
        .INITIAL_VALUE  (4'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[5+:4]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[5+:4]),
        .i_sw_write_data    (w_bit_field_write_data[5+:4]),
        .o_sw_read_data     (w_bit_field_read_data[5+:4]),
        .o_sw_value         (w_bit_field_value[5+:4]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({4{1'b0}}),
        .i_hw_set           ({4{1'b0}}),
        .i_hw_clear         ({4{1'b0}}),
        .i_value            ({4{1'b0}}),
        .i_mask             ({4{1'b1}}),
        .o_value            (o_control_FUNC),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_CRRESP
      rggen_bit_field #(
        .WIDTH          (5),
        .INITIAL_VALUE  (5'h00),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[9+:5]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[9+:5]),
        .i_sw_write_data    (w_bit_field_write_data[9+:5]),
        .o_sw_read_data     (w_bit_field_read_data[9+:5]),
        .o_sw_value         (w_bit_field_value[9+:5]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({5{1'b0}}),
        .i_hw_set           ({5{1'b0}}),
        .i_hw_clear         ({5{1'b0}}),
        .i_value            ({5{1'b0}}),
        .i_mask             ({5{1'b1}}),
        .o_value            (o_control_CRRESP),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_ACFLT
      rggen_bit_field #(
        .WIDTH          (1),
        .INITIAL_VALUE  (1'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[14+:1]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[14+:1]),
        .i_sw_write_data    (w_bit_field_write_data[14+:1]),
        .o_sw_read_data     (w_bit_field_read_data[14+:1]),
        .o_sw_value         (w_bit_field_value[14+:1]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({1{1'b0}}),
        .i_hw_set           ({1{1'b0}}),
        .i_hw_clear         ({1{1'b0}}),
        .i_value            ({1{1'b0}}),
        .i_mask             ({1{1'b1}}),
        .o_value            (o_control_ACFLT),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_ADDRFLT
      rggen_bit_field #(
        .WIDTH          (1),
        .INITIAL_VALUE  (1'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[15+:1]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[15+:1]),
        .i_sw_write_data    (w_bit_field_write_data[15+:1]),
        .o_sw_read_data     (w_bit_field_read_data[15+:1]),
        .o_sw_value         (w_bit_field_value[15+:1]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({1{1'b0}}),
        .i_hw_set           ({1{1'b0}}),
        .i_hw_clear         ({1{1'b0}}),
        .i_value            ({1{1'b0}}),
        .i_mask             ({1{1'b1}}),
        .o_value            (o_control_ADDRFLT),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_OSHEN
      rggen_bit_field #(
        .WIDTH          (1),
        .INITIAL_VALUE  (1'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[16+:1]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[16+:1]),
        .i_sw_write_data    (w_bit_field_write_data[16+:1]),
        .o_sw_read_data     (w_bit_field_read_data[16+:1]),
        .o_sw_value         (w_bit_field_value[16+:1]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({1{1'b0}}),
        .i_hw_set           ({1{1'b0}}),
        .i_hw_clear         ({1{1'b0}}),
        .i_value            ({1{1'b0}}),
        .i_mask             ({1{1'b1}}),
        .o_value            (o_control_OSHEN),
        .o_value_unmasked   ()
      );
    end
    if (1) begin : g_CONEN
      rggen_bit_field #(
        .WIDTH          (1),
        .INITIAL_VALUE  (1'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[17+:1]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[17+:1]),
        .i_sw_write_data    (w_bit_field_write_data[17+:1]),
        .o_sw_read_data     (w_bit_field_read_data[17+:1]),
        .o_sw_value         (w_bit_field_value[17+:1]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({1{1'b0}}),
        .i_hw_set           ({1{1'b0}}),
        .i_hw_clear         ({1{1'b0}}),
        .i_value            ({1{1'b0}}),
        .i_mask             ({1{1'b1}}),
        .o_value            (o_control_CONEN),
        .o_value_unmasked   ()
      );
    end
  end endgenerate
  generate if (1) begin : g_status
    wire w_bit_field_valid;
    wire [31:0] w_bit_field_read_mask;
    wire [31:0] w_bit_field_write_mask;
    wire [31:0] w_bit_field_write_data;
    wire [31:0] w_bit_field_read_data;
    wire [31:0] w_bit_field_value;
    `rggen_tie_off_unused_signals(32, 32'h00000001, w_bit_field_read_data, w_bit_field_value)
    rggen_default_register #(
      .READABLE       (1),
      .WRITABLE       (1),
      .ADDRESS_WIDTH  (6),
      .OFFSET_ADDRESS (6'h04),
      .BUS_WIDTH      (32),
      .DATA_WIDTH     (32)
    ) u_register (
      .i_clk                  (i_clk),
      .i_rst_n                (i_rst_n),
      .i_register_valid       (w_register_valid),
      .i_register_access      (w_register_access),
      .i_register_address     (w_register_address),
      .i_register_write_data  (w_register_write_data),
      .i_register_strobe      (w_register_strobe),
      .o_register_active      (w_register_active[1+:1]),
      .o_register_ready       (w_register_ready[1+:1]),
      .o_register_status      (w_register_status[2+:2]),
      .o_register_read_data   (w_register_read_data[32+:32]),
      .o_register_value       (w_register_value[32+:32]),
      .o_bit_field_valid      (w_bit_field_valid),
      .o_bit_field_read_mask  (w_bit_field_read_mask),
      .o_bit_field_write_mask (w_bit_field_write_mask),
      .o_bit_field_write_data (w_bit_field_write_data),
      .i_bit_field_read_data  (w_bit_field_read_data),
      .i_bit_field_value      (w_bit_field_value)
    );
    if (1) begin : g_OSH_END
      rggen_bit_field #(
        .WIDTH              (1),
        .INITIAL_VALUE      (1'h0),
        .SW_READ_ACTION     (`RGGEN_READ_DEFAULT),
        .SW_WRITE_ACTION    (`RGGEN_WRITE_CLEAR),
        .SW_WRITE_ONCE      (0),
        .STORAGE            (1),
        .EXTERNAL_READ_DATA (0),
        .TRIGGER            (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[0+:1]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[0+:1]),
        .i_sw_write_data    (w_bit_field_write_data[0+:1]),
        .o_sw_read_data     (w_bit_field_read_data[0+:1]),
        .o_sw_value         (w_bit_field_value[0+:1]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({1{1'b0}}),
        .i_hw_set           (i_status_OSH_END_hw_set),
        .i_hw_clear         ({1{1'b0}}),
        .i_value            ({1{1'b0}}),
        .i_mask             ({1{1'b1}}),
        .o_value            (o_status_OSH_END),
        .o_value_unmasked   ()
      );
    end
  end endgenerate
  generate if (1) begin : g_delay
    wire w_bit_field_valid;
    wire [31:0] w_bit_field_read_mask;
    wire [31:0] w_bit_field_write_mask;
    wire [31:0] w_bit_field_write_data;
    wire [31:0] w_bit_field_read_data;
    wire [31:0] w_bit_field_value;
    `rggen_tie_off_unused_signals(32, 32'hffffffff, w_bit_field_read_data, w_bit_field_value)
    rggen_default_register #(
      .READABLE       (1),
      .WRITABLE       (1),
      .ADDRESS_WIDTH  (6),
      .OFFSET_ADDRESS (6'h08),
      .BUS_WIDTH      (32),
      .DATA_WIDTH     (32)
    ) u_register (
      .i_clk                  (i_clk),
      .i_rst_n                (i_rst_n),
      .i_register_valid       (w_register_valid),
      .i_register_access      (w_register_access),
      .i_register_address     (w_register_address),
      .i_register_write_data  (w_register_write_data),
      .i_register_strobe      (w_register_strobe),
      .o_register_active      (w_register_active[2+:1]),
      .o_register_ready       (w_register_ready[2+:1]),
      .o_register_status      (w_register_status[4+:2]),
      .o_register_read_data   (w_register_read_data[64+:32]),
      .o_register_value       (w_register_value[64+:32]),
      .o_bit_field_valid      (w_bit_field_valid),
      .o_bit_field_read_mask  (w_bit_field_read_mask),
      .o_bit_field_write_mask (w_bit_field_write_mask),
      .o_bit_field_write_data (w_bit_field_write_data),
      .i_bit_field_read_data  (w_bit_field_read_data),
      .i_bit_field_value      (w_bit_field_value)
    );
    if (1) begin : g_data
      rggen_bit_field #(
        .WIDTH          (32),
        .INITIAL_VALUE  (32'h00000000),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[0+:32]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[0+:32]),
        .i_sw_write_data    (w_bit_field_write_data[0+:32]),
        .o_sw_read_data     (w_bit_field_read_data[0+:32]),
        .o_sw_value         (w_bit_field_value[0+:32]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({32{1'b0}}),
        .i_hw_set           ({32{1'b0}}),
        .i_hw_clear         ({32{1'b0}}),
        .i_value            ({32{1'b0}}),
        .i_mask             ({32{1'b1}}),
        .o_value            (o_delay_data),
        .o_value_unmasked   ()
      );
    end
  end endgenerate
  generate if (1) begin : g_acsnoop
    wire w_bit_field_valid;
    wire [31:0] w_bit_field_read_mask;
    wire [31:0] w_bit_field_write_mask;
    wire [31:0] w_bit_field_write_data;
    wire [31:0] w_bit_field_read_data;
    wire [31:0] w_bit_field_value;
    `rggen_tie_off_unused_signals(32, 32'h0000000f, w_bit_field_read_data, w_bit_field_value)
    rggen_default_register #(
      .READABLE       (1),
      .WRITABLE       (1),
      .ADDRESS_WIDTH  (6),
      .OFFSET_ADDRESS (6'h0c),
      .BUS_WIDTH      (32),
      .DATA_WIDTH     (32)
    ) u_register (
      .i_clk                  (i_clk),
      .i_rst_n                (i_rst_n),
      .i_register_valid       (w_register_valid),
      .i_register_access      (w_register_access),
      .i_register_address     (w_register_address),
      .i_register_write_data  (w_register_write_data),
      .i_register_strobe      (w_register_strobe),
      .o_register_active      (w_register_active[3+:1]),
      .o_register_ready       (w_register_ready[3+:1]),
      .o_register_status      (w_register_status[6+:2]),
      .o_register_read_data   (w_register_read_data[96+:32]),
      .o_register_value       (w_register_value[96+:32]),
      .o_bit_field_valid      (w_bit_field_valid),
      .o_bit_field_read_mask  (w_bit_field_read_mask),
      .o_bit_field_write_mask (w_bit_field_write_mask),
      .o_bit_field_write_data (w_bit_field_write_data),
      .i_bit_field_read_data  (w_bit_field_read_data),
      .i_bit_field_value      (w_bit_field_value)
    );
    if (1) begin : g_type
      rggen_bit_field #(
        .WIDTH          (4),
        .INITIAL_VALUE  (4'h0),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[0+:4]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[0+:4]),
        .i_sw_write_data    (w_bit_field_write_data[0+:4]),
        .o_sw_read_data     (w_bit_field_read_data[0+:4]),
        .o_sw_value         (w_bit_field_value[0+:4]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({4{1'b0}}),
        .i_hw_set           ({4{1'b0}}),
        .i_hw_clear         ({4{1'b0}}),
        .i_value            ({4{1'b0}}),
        .i_mask             ({4{1'b1}}),
        .o_value            (o_acsnoop_type),
        .o_value_unmasked   ()
      );
    end
  end endgenerate
  generate if (1) begin : g_base_addr
    wire w_bit_field_valid;
    wire [31:0] w_bit_field_read_mask;
    wire [31:0] w_bit_field_write_mask;
    wire [31:0] w_bit_field_write_data;
    wire [31:0] w_bit_field_read_data;
    wire [31:0] w_bit_field_value;
    `rggen_tie_off_unused_signals(32, 32'hffffffff, w_bit_field_read_data, w_bit_field_value)
    rggen_default_register #(
      .READABLE       (1),
      .WRITABLE       (1),
      .ADDRESS_WIDTH  (6),
      .OFFSET_ADDRESS (6'h10),
      .BUS_WIDTH      (32),
      .DATA_WIDTH     (32)
    ) u_register (
      .i_clk                  (i_clk),
      .i_rst_n                (i_rst_n),
      .i_register_valid       (w_register_valid),
      .i_register_access      (w_register_access),
      .i_register_address     (w_register_address),
      .i_register_write_data  (w_register_write_data),
      .i_register_strobe      (w_register_strobe),
      .o_register_active      (w_register_active[4+:1]),
      .o_register_ready       (w_register_ready[4+:1]),
      .o_register_status      (w_register_status[8+:2]),
      .o_register_read_data   (w_register_read_data[128+:32]),
      .o_register_value       (w_register_value[128+:32]),
      .o_bit_field_valid      (w_bit_field_valid),
      .o_bit_field_read_mask  (w_bit_field_read_mask),
      .o_bit_field_write_mask (w_bit_field_write_mask),
      .o_bit_field_write_data (w_bit_field_write_data),
      .i_bit_field_read_data  (w_bit_field_read_data),
      .i_bit_field_value      (w_bit_field_value)
    );
    if (1) begin : g_Data
      rggen_bit_field #(
        .WIDTH          (32),
        .INITIAL_VALUE  (32'h00000000),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[0+:32]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[0+:32]),
        .i_sw_write_data    (w_bit_field_write_data[0+:32]),
        .o_sw_read_data     (w_bit_field_read_data[0+:32]),
        .o_sw_value         (w_bit_field_value[0+:32]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({32{1'b0}}),
        .i_hw_set           ({32{1'b0}}),
        .i_hw_clear         ({32{1'b0}}),
        .i_value            ({32{1'b0}}),
        .i_mask             ({32{1'b1}}),
        .o_value            (o_base_addr_Data),
        .o_value_unmasked   ()
      );
    end
  end endgenerate
  generate if (1) begin : g_mem_size
    wire w_bit_field_valid;
    wire [31:0] w_bit_field_read_mask;
    wire [31:0] w_bit_field_write_mask;
    wire [31:0] w_bit_field_write_data;
    wire [31:0] w_bit_field_read_data;
    wire [31:0] w_bit_field_value;
    `rggen_tie_off_unused_signals(32, 32'hffffffff, w_bit_field_read_data, w_bit_field_value)
    rggen_default_register #(
      .READABLE       (1),
      .WRITABLE       (1),
      .ADDRESS_WIDTH  (6),
      .OFFSET_ADDRESS (6'h14),
      .BUS_WIDTH      (32),
      .DATA_WIDTH     (32)
    ) u_register (
      .i_clk                  (i_clk),
      .i_rst_n                (i_rst_n),
      .i_register_valid       (w_register_valid),
      .i_register_access      (w_register_access),
      .i_register_address     (w_register_address),
      .i_register_write_data  (w_register_write_data),
      .i_register_strobe      (w_register_strobe),
      .o_register_active      (w_register_active[5+:1]),
      .o_register_ready       (w_register_ready[5+:1]),
      .o_register_status      (w_register_status[10+:2]),
      .o_register_read_data   (w_register_read_data[160+:32]),
      .o_register_value       (w_register_value[160+:32]),
      .o_bit_field_valid      (w_bit_field_valid),
      .o_bit_field_read_mask  (w_bit_field_read_mask),
      .o_bit_field_write_mask (w_bit_field_write_mask),
      .o_bit_field_write_data (w_bit_field_write_data),
      .i_bit_field_read_data  (w_bit_field_read_data),
      .i_bit_field_value      (w_bit_field_value)
    );
    if (1) begin : g_Data
      rggen_bit_field #(
        .WIDTH          (32),
        .INITIAL_VALUE  (32'h00000000),
        .SW_WRITE_ONCE  (0),
        .TRIGGER        (0)
      ) u_bit_field (
        .i_clk              (i_clk),
        .i_rst_n            (i_rst_n),
        .i_sw_valid         (w_bit_field_valid),
        .i_sw_read_mask     (w_bit_field_read_mask[0+:32]),
        .i_sw_write_enable  (1'b1),
        .i_sw_write_mask    (w_bit_field_write_mask[0+:32]),
        .i_sw_write_data    (w_bit_field_write_data[0+:32]),
        .o_sw_read_data     (w_bit_field_read_data[0+:32]),
        .o_sw_value         (w_bit_field_value[0+:32]),
        .o_write_trigger    (),
        .o_read_trigger     (),
        .i_hw_write_enable  (1'b0),
        .i_hw_write_data    ({32{1'b0}}),
        .i_hw_set           ({32{1'b0}}),
        .i_hw_clear         ({32{1'b0}}),
        .i_value            ({32{1'b0}}),
        .i_mask             ({32{1'b1}}),
        .o_value            (o_mem_size_Data),
        .o_value_unmasked   ()
      );
    end
  end endgenerate
endmodule