module model #(parameter
  DATA_WIDTH=32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

integer i;

always_comb begin
  for (i = 0; i < DATA_WIDTH; i++) begin
    dout[DATA_WIDTH-i-1] = din[i];
  end
end

endmodule
