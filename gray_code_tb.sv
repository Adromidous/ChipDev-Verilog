module gray_code_tb();

localparam WIDTH=4;

logic [WIDTH-1:0] binary_value, gray_value;
//INSTANTIATE GRAY CODE MODULE
gray_code #(
		.WIDTH(WIDTH)
) g0 (
		.binary_value(binary_value),
		.gray_value(gray_value)
);

initial begin
	$display("--BEGIN SIMULATION--");
	$monitor("BINARY VALUE: %b, GRAY VALUE: %b", binary_value, gray_value);
	binary_value = 'b0;
	for (int i = 0; i < 2 ** WIDTH; i++) begin
		#10;
		binary_value = binary_value + 1'b1;
	end

	$finish;
end
endmodule
