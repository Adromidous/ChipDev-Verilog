`timescale 1ns/1ns

module full_adder #(
		parameter DATA_WIDTH=4
)	(
		input [DATA_WIDTH-1:0] a_in,
		input [DATA_WIDTH-1:0] b_in,
		input cin,
		output [DATA_WIDTH-1:0] sum,
		output cout
);

logic [DATA_WIDTH-1:0] cout_reg;

genvar i;

generate

	for (i = 0; i < DATA_WIDTH; i++) begin
		if (i == 0) begin : gen_FIRST
			one_bit_adder u0 (
					.cin(cin),
					.a(a_in[0]),
					.b(b_in[0]),
					.cout(cout_reg[0]),
					.sum(sum[0])
			);
		end else begin : gen_GENERAL
			one_bit_adder u0 (
					.cin(cout_reg[i-1]),
					.a(a_in[i]),
					.b(b_in[i]),
					.cout(cout_reg[i]),
					.sum(sum[i])
			);
		end
	end
endgenerate

assign cout = cout_reg[DATA_WIDTH-1];

endmodule
