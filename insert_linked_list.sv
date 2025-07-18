module insert_linked_list #(
	parameter DATA_WIDTH = 4,
	parameter ADDR_WIDTH = 4
)	(
	input logic clk,
	input logic rst_n,
	input logic [ADDR_WIDTH-1:0] new_addr,
	input logic [DATA_WIDTH-1:0] new_data,
	input logic [ADDR_WIDTH-1:0] check_addr,	
	input logic [ADDR_WIDTH-1:0] start_node,
	output logic inserted,
	output logic stop
	);

reg [DATA_WIDTH + ADDR_WIDTH - 1 : 0] linked_list [0 : 2**ADDR_WIDTH-1]
logic [ADDR_WIDTH-1:0] curr_node;

//LINKED LIST STOPPING CONDITION - ADDRESS == 'b0

always_ff@ (posedge clk) begin
	if (!rst_n) begin
		inserted <= 0;
		curr_node <= start_node;
	end else begin
		if (curr_node == check_addr) begin //FOUND NODE
			linked_list[curr_node][ADDR_WIDTH-1:0] <= new_addr; 					
			linked_list[new_addr][ADDR_WIDTH-1:0] <= linked_list[curr_node][ADDR_WIDTH-1:0]; 			
			linked_list[new_addr][DATA_WIDTH + ADDR_WIDTH - 1: ADDR_WIDTH] <= new_data;
			inserted <= 1'b1;	
			stop <= 1'b1;
		end else if (curr_node != 'b0) begin
			curr_node <= linked_list[curr_node][ADDR_WIDTH-1:0]; //TRAVERSE LINKED LIST
		end else begin
			stop <= 1'b1;
		end
	end
end
