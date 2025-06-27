module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  input din_en,
  output logic dout
);

reg [DATA_WIDTH-1:0] curr_din;

always_ff@ (posedge clk) begin

  if (~resetn) begin
    dout <= 1'b0;
    curr_din <= 0;
  end else if (din_en) begin
    dout <= din[0];
    curr_din <= din >> 1;
  end else begin
    dout <= curr_din[0];
    curr_din <= curr_din >> 1;
  end

end

endmodule
