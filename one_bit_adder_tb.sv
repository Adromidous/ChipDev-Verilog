module one_bit_adder_tb();

//INPUTS
logic tb_a, tb_b;

//OUTPUTS
logic tb_sum, tb_carry;

one_bit_adder u0 (
	.a(tb_a),
	.b(tb_b),
	.sum(tb_sum),
	.carry(tb_carry)
);

assign tb_a = 1'b1;
assign tb_b = 1'b1;

initial begin
	$display("--SIMULATION STARTED--");
	$display("A VALUE: %b", tb_a);
	$display("B VALUE: %b", tb_b); 
	$display("SUM VALUE: %b", tb_sum);
	$display("CARRY VALUE: %b", tb_carry);
	$display("--SIMULATION FINISHED--");
end

endmodule
