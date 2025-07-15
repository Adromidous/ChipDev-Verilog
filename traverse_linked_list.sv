//BASIC MODULE WHICH TRAVERSES A LINKED LIST AND
//TRIES TO FIND IF A NODE EXISTS OR NOT

/*

	|------------------------------------------|
	|	  DATA	     |      NEXT ADDR      |
	|------------------------------------------|
	31        ...	     15         ...        0
*/


module traverse_linked_list #(
	parameter ADDR_WIDTH=4;
	parameter DATA_WIDTH=4
)	(
	input logic clk,
	input logic rst,
	input logic [ADDR_WIDTH-1:0] check_addr,
	input logic [ADDR_WIDTH-1:0] start_node,
	output logic found
);

reg [ADDR_WIDTH + DATA_WIDTH - 1 : 0] register_file [0:2**ADDR_WIDTH - 1]; // Please synthesize to BRAM :||
logic [ADDR_WIDTH - 1:0] curr_node;
always_ff@ (posedge clk) begin
	if (~rst) begin
		found <= 'b0;
		curr_node <= start_node;
	end else begin
		if (curr_node == check_addr) begin
			found <= 1'b1;
		end else begin
			curr_node <= register_file[curr_node][ADDR_WIDTH-1:0];	
		end
	end
end


endmodule
