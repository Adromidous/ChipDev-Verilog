module FIFO_tb ();

localparam DEPTH=4;
localparam WIDTH=32;

//INPUTS
logic tb_clk, tb_resetn;
logic tb_rd_en, tb_wr_en;
logic [WIDTH-1:0] tb_data_in;

//OUTPUTS
logic tb_full;
logic tb_empty;
logic [WIDTH-1:0] tb_data_out;

FIFO #(
	.DEPTH(DEPTH)
) tb_FIFO	(
	//INPUTS
	.clk(tb_clk),
	.resetn(tb_resetn),
	.rd_en(tb_rd_en),
	.wr_en(tb_wr_en),
	.data_in(tb_data_in),

	.full(tb_full),
	.empty(tb_empty),
	.data_out(tb_data_out)
);


initial begin
	$display("--SIMULATION STARTED--");
	tb_clk 		= 1'b1;
	tb_resetn 	= 1'b0;	
	tb_rd_en 	= 1'b0;
	tb_wr_en 	= 1'b0;
	tb_data_in	=  'b0;

	#10;

	tb_clk		= 1'b0;
	tb_resetn	= 1'b1;

	tb_wr_en	= 1'b1;
	tb_data_in	=  'b1;
	for (int i = 0; i < 2*DEPTH; i++) begin
	        $display("TIME: %0t CLK: %b FULL: %b EMPTY: %b DATA: 0x%0h", $time, tb_clk, tb_full, tb_empty, tb_data_out); 	
		#10;
		tb_clk		= ~tb_clk;
	end	

	$display("--SIMULATION FINISHED--");
end
endmodule
