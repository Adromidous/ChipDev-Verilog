module read_hander #(
	parameter WIDTH=4
)	(

	input logic clk,
	input logic rstn,
	input [WIDTH:0] rd_ptr, //INPUT - GRAY CODED
	input [WIDTH:0] wr_ptr, //OUTPUT FROM 2FF SYNCHRONIZER - GRAY CODED
	output logic empty
);

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		empty <= 1'b0;
	end else begin
		empty <= (wr_ptr == rd_ptr); 		
	end
end



endmodule
