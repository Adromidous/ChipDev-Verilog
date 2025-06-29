module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);

integer i;
reg trail;

always_comb begin

  dout = 0;
  trail = 1'b0;

  for (i = 0; i < DATA_WIDTH; i = i+1) begin
    
    if (din[i] == 1'b1) begin
      trail = 1'b1;
    end else if (~trail & (din[i] == 1'b0)) begin
      dout = dout + 1'b1;
    end

  end

end

endmodule
