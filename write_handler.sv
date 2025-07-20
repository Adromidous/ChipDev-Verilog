module write_hander #(
	parameter WIDTH=4
)	(

	input logic clk,
	input logic rstn,
	input [WIDTH:0] rd_ptr, //OUTPUT FROM 2FF SYNCHRONIZER - GRAY CODED
	input [WIDTH:0] wr_ptr, //WRITE POINTER INPUT - GRAY CODED
	output logic full
);

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		full <= 1'b0;
	end else begin
		full <= (wr_ptr == {~rd_ptr[WIDTH:WIDTH-1], rd_ptr[WIDTH-2:0]}; 		
	end
end



endmodule
