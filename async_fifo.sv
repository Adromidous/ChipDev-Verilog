module async_FIFO #(
	parameter WIDTH = 32,
	parameter DEPTH = 16
)	(
	input logic wclk,
	input logic rclk,
	input logic rst,
	input logic read_en,
	input logic write_en,
	output logic [WIDTH-1:0] data_in,
	output logic [WIDTH-1:0] data_out,
	output logic empty,
	output logic full
);

logic [$clog2(DEPTH):0] bin_wrt_ptr, bin_rd_ptr;
logic [$clog2(DEPTH):0] gray_wrt_ptr, gray_rd_ptr;

logic empty_out, full_out;

async_fifo_mem #(
	.WIDTH(32),
	.DEPTH(16),
)  mem1 (
	.read_clk(rclk),
	.write_clk(wclk),
	.async_rst(rst),
	.data_in(data_in),
	.read_en(read_en),
	.write_en(write_en),
	.full(full),
	.empty(empty),
	.waddr(bin_wrt_ptr),
	.raddr(bin_rd_ptr),
	.data_out(data_out)
);

write_handler #(
	.PTR_WIDTH($clog2(DEPTH)),
)  wh0  (
	//INPUTS
	.clk(wclk),
	.rstn(rst),
	.rd_ptr(gray_rd_ptr),
	.increment(write_en),
	//OUTPUTS
	.full(full_out),
	.bin_wrt_ptr(bin_wrt_ptr),
	.gray_wrt_ptr(gray_wrt_ptr)
);

read_handler #(
	.PTR_WIDTH($clog2(DEPTH))
)  rh0  (
	//INPUTS
	.clk(rclk),
	.rstn(rst),
	.wr_ptr(gray_wrt_ptr),
	.increment(read_en),
	//OUTPUTS
	.empty(empty_out),
	.bin_rd_ptr(bin_rd_ptr),
	.gray_rd_ptr(gray_rd_ptr)
);

assign empty = empty_out;
assign full = full_out;

endmodule
