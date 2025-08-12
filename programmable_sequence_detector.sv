module model (
  input clk,
  input resetn,
  input [4:0] init,
  input din,
  output logic seen
);

logic [4:0] shift_reg;
logic [4:0] capture;
logic [2:0] len;

always_ff@ (posedge clk) begin
  if (~resetn) begin
    shift_reg <= 'b0;
    len <= 'b0;
  end else begin
    shift_reg <= {shift_reg[3:0], din};
    len <= (len < 5) ? len + 1'b1 : len;
  end
end

always_ff@ (posedge resetn) begin
  capture <= init;
end

assign seen = (shift_reg == capture) && (len == 5);

endmodule
