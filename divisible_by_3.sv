module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

logic [31:0] counter, val;

always_ff@ (posedge clk) begin
  if (~resetn) begin
    counter <= 'b0;
    val <= 'b0;
  end else begin
    counter <= counter + 1'b1;
    val <= val + (din << counter);
  end
end

assign dout = ((val % 3) == 0) & |counter;

endmodule

//ALTERNATE SOLUTION 

//TRICK: To check if a number is divisible by 3, you can alternate between the
//subtraction and addition of its bits. If the final value is divisible by 3, the
//original number is divisible by 3 :0

/*

enum {MODR, MOD0, MOD1, MOD2} state;

always_ff@ (posedge clk) begin
  if (~resetn) begin
	  state <= MODR;
  end else begin
	case(state)
		MODR : state <= (din ? MOD1 : MOD0);
		MOD0 : state <= (din ? MOD1 : MOD0);
		MOD1 : state <= (din ? MOD0 : MOD2);
		MOD2 : state <= (din ? MOD2 : MOD1); 
	endcase
  end
end

assign dout = (state == MOD0)

*/
