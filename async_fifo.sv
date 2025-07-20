module async_fifo #(
	parameter WIDTH = 32,
	parameter DEPTH = 16
)	(
	input logic read_clk,
	input logic write_clk,
	input logic async_rst,
	input logic [WIDTH-1:0] data_in,
	input logic read_en,
	input logic write_en,
	output logic [WIDTH-1:0] data_out,
	output logic full,
	output logic empty
);


logic [$clog2(DEPTH)-1:0] write_ptr, read_ptr;
logic [$clog2(DEPTH)-1:0] gray_write_ptr, gray_read_ptr;

reg [WIDTH-1:0] async_fifo_mem [DEPTH-1:0];


//2FF SYNCRHONIZER SIGNALS
logic [$clog2(DEPTH)-1:0] 2ff_gray_write_ptr [0:1]; 
logic [$clog2(DEPTH)-1:0] 2ff_gray_read_ptr [0:1];

always_ff@ (posedge read_clk, negedge async_rst) begin
	if (~async_rst) begin
		read_ptr <= 'b0;
		data_out <= 'b0;
	end else begin
		if (read_en & !empty) begin
			data_out <= async_fifo_mem[read_ptr] //COMPLETE PLEASE!
		end else begin
			data_out <= 'b0;
		end
	end
end


always_ff@ (posedge write_clk, negedge async_rst) begin
	if (~async_rst) begin
		write_ptr <= 'b0;
	end else begin
		if (write_en & !full) begin
			async_fifo_mem[write_ptr] <= data_in;
		end
	end
end

//2FF SYNCHRONIZER WRITE POINTER
always_ff@ (posedge write_clk, negedge async_rst) begin
	if (~async_rst) begin
		2ff_gray_write_ptr <= 'b0;
	end else begin
		2ff_gray_write_ptr[1] <= 2ff_gray_write_ptr[0];
		2ff_gray_write_ptr[0] <= gray_write_ptr;
	end
end

//2FF SYNCHRONIZER READ POINTER
always_ff@ (posedge read_clk, negedge async_rst) begin
	if (~async_rst) begin
		2ff_gray_read_ptr <= 'b0;
	end else begin
		2ff_gray_read_ptr[1] <= 2ff_read_write_ptr[0];
		2ff_gray_read_ptr[0] <= gray_read_ptr;
	end
end

//READ PTR GRAY CODE CONVERSION
gray_code #(
	.WIDTH($clog2(DEPTH))
)  rd0 (
	.binary_value(read_ptr),
	.gray_value(gray_read_ptr)
);	

//WRITE PTR GRAY CODE CONVERSION
gray_code #(
	.WIDTH($clog2(DEPTH))
)  wr0 (
	.binary_value(write_ptr),
	.gray_value(gray_write_ptr)
);

assign empty = (gray_read_ptr == gray_write_ptr);
assign full == 

endmodule
		
