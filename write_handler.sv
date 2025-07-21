module write_handler #(
	parameter PTR_WIDTH = 16,
)	(

	input logic clk,
	input logic rstn,
	input [PTR_WIDTH:0] rd_ptr, //OUTPUT FROM 2FF SYNCHRONIZER - GRAY CODED
	input increment,
	output logic full,
	output logic [PTR_WIDTH:0] bin_wrt_ptr, //GOES TO FIFO MEM
	output logic [PTR_WIDTH:0] gray_wrt_ptr //GOES TO READ HANDLER
);

//2FF SYNCRHONIZER
reg [PTR_WIDTH:0] 2ff_write_ptr_sync [0:1];

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		full <= 1'b0;
	end else begin
		full <= (wr_ptr == {~rd_ptr[PTR_WIDTH:PTR_WIDTH-1], rd_ptr[PTR_WIDTH-2:0]}; 		
	end
end

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		2ff_write_ptr_sync <= 'b0;
	end else begin
		2ff_write_ptr_sync[1] <= 2ff_write_ptr_sync[0];
		2ff_write_ptr_sync[0] <= gray_wrt_ptr;
	end
end

always_ff@ (posedge clk, negedge rstn) begin
	if (~rstn) begin
		bin_wrt_ptr <= 'b0;
	end else begin
		if (increment) bin_wrt_ptr <= bin_wrt_ptr + 1'b1;
	end

end

gray_code #(
		.WIDTH(PTR_WIDTH)
)	(
		.binary_value(bin_wrt_ptr),
		.gray_value(gray_wrt_ptr)
);

endmodule
