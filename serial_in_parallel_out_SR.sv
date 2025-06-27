module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input din,
  output logic [DATA_WIDTH-1:0] dout
);

always_ff@ (posedge clk) begin

  if (~resetn) begin
    dout <= {DATA_WIDTH{1'b0}};
  end else begin
    dout <= (dout << 1) | din;
  end

end

endmodule
