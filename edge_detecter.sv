module model (
  input clk,
  input resetn,
  input din,
  output dout
);

reg pulse1, pulse2;

always_ff @(posedge clk) begin

  if (~resetn) begin
    pulse1 <= 1'b0;
    pulse2 <= 1'b0;
  end else begin
    pulse1 <= din;
    pulse2 <= pulse1;
  end

end

assign dout = pulse1 & ~pulse2;

endmodule
