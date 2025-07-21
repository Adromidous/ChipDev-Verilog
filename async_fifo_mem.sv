module async_fifo_mem #(
	parameter WIDTH = 32,
	parameter DEPTH = 16
)	(
	input logic read_clk,
	input logic write_clk,
	input logic async_rst,
	input logic [WIDTH-1:0] data_in,
	input logic read_en,
	input logic write_en,
	input logic full,
	input logic empty,
	input logic [$clog2(DEPTH):0] waddr,
	input logic [$clog2(DEPTH):0] raddr,
	output logic [WIDTH-1:0] data_out,
);


//MEMORY INSTANTIATION
reg [WIDTH-1:0] async_fifo_mem [DEPTH-1:0]; //TRUE DUAL PORT RAM SHOULD BE INSTANTIATED HERE 

//2FF SYNCRHONIZER SIGNALS
logic [$clog2(DEPTH):0] 2ff_gray_write_ptr; 
logic [$clog2(DEPTH):0] 2ff_gray_read_ptr;

//READ FROM MEMORY USING BINARY READ POINTER
always_ff@ (posedge read_clk, negedge async_rst) begin
	if (~async_rst) begin
		data_out <= 'b0;
	end else begin
		if (read_en & !empty) begin
			data_out <= async_fifo_mem[raddr] 
		end else begin
			data_out <= 'b0;
		end
	end
end

//WRITE TO MEMORY USING BINARY WRITE POINTER
always_ff@ (posedge write_clk, negedge async_rst) begin
	if (write_en & !full &async_rst) begin
		async_fifo_mem[waddr] <= data_in;
	end
end

endmodule
		
