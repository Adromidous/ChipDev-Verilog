`timescale 1ns/1ns

module tb_full_adder();
	
	localparam DATA_WIDTH=4;

	logic tb_clk;


	logic [DATA_WIDTH-1:0] tb_a_in;
	logic [DATA_WIDTH-1:0] tb_b_in;
	logic [DATA_WIDTH-1:0] tb_sum;
	logic tb_cin;
	logic tb_cout;

	full_adder #( //4 BIT FULL ADDER
			.DATA_WIDTH(DATA_WIDTH)
	) fa0 (
			.a_in(tb_a_in),
			.b_in(tb_b_in),
			.cin(tb_cin),
			.sum(tb_sum),
			.cout(tb_cout)
	);

	task clk_pulse(); 
		#10 tb_clk = ~tb_clk;
	endtask

	always@ (posedge tb_clk) begin
		$display("TIME: %0t A: 0x%0b B: 0x%0b SUM: 0x%b COUT:0x%0b", $time, tb_a_in, tb_b_in, tb_sum, tb_cout); 
		tb_a_in <= tb_a_in + 1'b1;
		tb_b_in <= tb_b_in + 1'b1;
	end

	initial begin
		tb_clk = 1'b0;
		tb_a_in = 4'b0100;
		tb_b_in = 4'b0100;	
		tb_cin = 1'b0;

		repeat (14) clk_pulse();
	end

endmodule
