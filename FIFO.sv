module FIFO #(
       	parameter DEPTH=16, //16 lines
	parameter WIDTH=32 //32-bits per line       	
) (
	input logic clk,
	input logic resetn,
	input logic rd_en,
	input logic wr_en,
	input logic [WIDTH-1:0] data_in,

	output logic full, //THIS IS MORE OF LIKE AN ALMOST FULL SIGNAL
	output logic empty,
	output logic [WIDTH-1:0] data_out
);


logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;

reg [WIDTH-1:0] fifo_mem [DEPTH-1:0];

always_ff@ (posedge clk or negedge resetn) begin
	
	if (~resetn) begin
		data_out 	<= 'b0;
		wr_ptr 		<= 'b0; //RESET WRITE POINTER TO BOTTOM OF FIFO
		rd_ptr 		<= 'b0; //RESET READ POINTER TO BOTTOM OF FIFO
	end else begin
		data_out <= 'b0;

		if (rd_en & !empty) begin
			data_out <= fifo_mem[rd_ptr];
		       	rd_ptr <= rd_ptr + 1'b1;	
		end		
		
		if (wr_en & !full) begin
			fifo_mem[wr_ptr] <= data_in;
			wr_ptr <= wr_ptr + 1'b1;
		end	
	end

end

assign full = ((wr_ptr + 1'b1) == rd_ptr); //IF wr_ptr IS BEHIND rd_ptr, WE KNOW FIFO IS FULL 
assign empty = (wr_ptr == rd_ptr); //IF wr_ptr AND rd_ptr OVERLAP, WE KNOW FIFO IS EMPTY

endmodule
