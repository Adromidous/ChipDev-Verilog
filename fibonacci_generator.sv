module model #(parameter
  DATA_WIDTH=32
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);

reg [DATA_WIDTH-1:0] first;

always_ff@ (posedge clk) begin

  if (~resetn) begin
    first <= 1'b1;
    out <= 1'b1;
  end else begin
    first <= first + out;
    out <= first;
  end

end


endmodule
