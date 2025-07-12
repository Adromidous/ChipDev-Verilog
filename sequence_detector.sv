module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

enum {S0, S1, S2, S3} state;

always_ff@ (posedge clk) begin

  case(state)
  
    S0 : begin //DETECT 1
      if (din) begin
        state <= S1;
      end
    end

    S1 : begin //DETECT 0
      if (~din) begin
        state <= S2;
      end
    end

    S2 : begin //DETECT SECOND 1
      dout <= 1'b0;
      if (din) begin
        state <= S3;
      end else begin
        state <= S0;
      end
    end

    S3 : begin //DETECT SECOND 0
      if (~din) begin
        dout <= 1'b1;
        state <= S2;
      end else begin
        state <= S1;
      end
    end
  
  endcase

  if (~resetn) begin
    dout <= 1'b0;
    state <= S0;
  end

end

endmodule
