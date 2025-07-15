module gray_code #(
	WIDTH=16
)	(
	input logic [WIDTH-1:0] binary_value,
	output logic [WIDTH-1:0] gray_value
);

always_comb begin
	gray_value[WIDTH-1] = binary_value[WIDTH-1]; //BRING DOWN MSB

	for (int i = WIDTH-2; i > -1; i--) begin
		gray_value[i] = binary_value[i+1] ^ binary_value[i];
	end
end
endmodule
