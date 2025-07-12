module model #(parameter
  DATA_WIDTH = 16,
  MAX = 99
) (
    input clk,
    input reset, start, stop,
    output logic [DATA_WIDTH-1:0] count
);

reg counting;

always_ff@ (posedge clk) begin

  if (reset) begin
    count <= 'b0;
    counting <= 1'b0;
  end else if (stop) begin
    count <= count;
    counting <= 1'b0;
  end else if (start | counting) begin
    counting <= 1'b1;
    count <= (count == MAX) ? 'b0 : count + 1'b1;
  end

end

endmodule
