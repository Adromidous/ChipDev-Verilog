`timescale 1ns/1ns

module one_bit_adder (
		input cin,
		input a,
		input b,
		output logic cout,
		output logic sum
);

	always_comb begin
		sum = cin ^ a ^ b;
		cout = (a & b) | (cin & (a | b));	
	end

endmodule
