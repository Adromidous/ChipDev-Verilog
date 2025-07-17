module model (
  input clk,
  input resetn,
  output logic div2,
  output logic div4,
  output logic div6
);

logic [1:0] div4_counter;
logic [1:0] div6_counter;

always_ff@ (posedge clk) begin
  if (~resetn) begin
    div2 <= 'b0;
    div4 <= 'b0;
    div6 <= 'b0;
  end else begin
    div2 <= ~div2;
    if (div4_counter == 2'b01) begin
      div4 <= ~div4;
    end
    if (div6_counter == 2'b10) begin
      div6 <= ~div6;
    end
  end
end

always_ff@ (posedge clk) begin
  if (~resetn) begin
    div4_counter <= 2'b01;
    div6_counter <= 2'b10;
  end else begin
    div4_counter <= div4_counter + 1'b1;
    div6_counter <= div6_counter + 1'b1;
    if (div4_counter == 2'b01) begin
      div4_counter <= 'b0;
    end
    if (div6_counter == 2'b10) begin
      div6_counter <= 'b0;
    end
  end
end



endmodule
