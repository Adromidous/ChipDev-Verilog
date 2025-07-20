module read_handler #(
	parameter PTR_WIDTH = 16,
)	(

	input logic clk,
	input logic rstn,
	input [PTR_WIDTH:0] wr_ptr, //OUTPUT FROM 2FF SYNCHRONIZER - GRAY CODED
	input increment,
	output logic empty,
	output logic [PTR_WIDTH:0] bin_rd_ptr,
	output logic [PTR_WIDTH:0] gray_rd_ptr
);

reg [PTR_WIDTH:0] 2ff_read_ptr_sync [0:1];

always_ff@ (posedge clk,negedge rstn) begin
	if (~rstn) begin
		empty <= 1'b0;
	end else begin
		empty <= (wr_ptr == rd_ptr); 		
	end
end

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		2ff_read_ptr_sync <= 'b0;
	end else begin
		2ff_read_ptr_sync[1] <= 2ff_read_ptr_sync[0];
		2ff_read_ptr_sync[0] <= gray_rd_ptr;
	end
end

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		bin_rd_ptr <= 'b0;
	end else begin
		if (increment)
			bin_rd_ptr <= bin_rd_ptr + 1'b1;
	end	
end

gray_code #(
		.WIDTH(PTR_WIDTH)
)	(
		.binary_value(bin_rd_ptr),
		.gray_value(gray_rd_ptr)
);

endmodule
