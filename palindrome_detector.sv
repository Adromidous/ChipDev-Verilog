module model #(parameter
  DATA_WIDTH=32
) (
  input [DATA_WIDTH-1:0] din,
  output logic dout
);

logic [DATA_WIDTH-1:0] din_reg;

always_comb begin
  din_reg = 'b0;

  for (int i = 0; i < DATA_WIDTH; i++) begin
    din_reg[i] = din[DATA_WIDTH-i-1];
  end
end

assign dout = din_reg == din;

endmodule
