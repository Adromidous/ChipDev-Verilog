module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

reg [DATA_WIDTH-1:0] first;

always_ff@ (posedge clk) begin

  if (~resetn) begin
    first <= {DATA_WIDTH{1'b0}};
    dout <= {DATA_WIDTH{1'b0}};
  end else begin

    if (din > first) begin
      first <= din;
    end

    if ((din >= dout) & (din <= first)) begin
        dout <= din;
    end else if (din > first) begin
        dout <= first;
    end

  end
end

endmodule
