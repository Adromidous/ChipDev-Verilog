module model #(parameter
  DATA_WIDTH = 16,
  MAX = 99
) (
    input clk,
    input reset, start, stop,
    output logic [DATA_WIDTH-1:0] count
);

reg [$clog2(MAX):0] counter;

enum {RESET, COUNT, STOP} state;


always_ff@ (posedge clk) begin

  case(state)
  
    RESET : begin
      
      if (start & !reset & !stop) begin
        state <= COUNT;
        counter <= counter + 1'b1;
      end else begin
        counter <= 'b0;
      end

    end

    COUNT : begin

      if (reset) begin
        state <= RESET;
        counter <= 'b0;
      end else if (stop) begin
        state <= STOP;
      end else begin
        counter <= (counter == MAX) ? 'b0 : counter + 1'b1;
      end

    end

    STOP : begin
      
      if (reset) begin
        state <= RESET;
        counter <= 'b0;
      end else if (start & !stop) begin
        state <= COUNT;
        counter <= (counter == MAX) ? 'b0 : counter + 1'b1;
      end

    end

  endcase

end

assign count = counter;

endmodule
