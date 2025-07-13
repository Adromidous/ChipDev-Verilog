module one_bit_adder (
	input	a,
	input	b,
	output logic carry,
	output logic sum
);

always_comb begin
	sum = a ^ b;
	carry = a & b;
end

endmodule
