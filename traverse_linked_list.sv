//BASIC MODULE WHICH TRAVERSES A LINKED LIST AND
  2 //TRIES TO FIND IF A NODE EXISTS OR NOT
  3 
  4 /*
  5 
  6         |------------------------------------------|
  7         |         DATA       |      NEXT ADDR      |
  8         |------------------------------------------|
  9         7        ...         4         ...         0
 10 */
 11 
 12 
 13 module traverse_linked_list #(
 14         parameter ADDR_WIDTH=4;
 15         parameter DATA_WIDTH=4
 16 )       (
 17         input logic clk,
 18         input logic rst,
 19         input logic [ADDR_WIDTH-1:0] check_addr,
 20         input logic [ADDR_WIDTH-1:0] start_node,
 21         output logic found,
 22         output logic stop
 23 );
 24 
 25 reg [ADDR_WIDTH + DATA_WIDTH - 1 : 0] register_file [0:2**ADDR_WIDTH - 1]; // Please synthesize to BRAM :||
 26 logic [ADDR_WIDTH - 1:0] curr_node;
 27 always_ff@ (posedge clk) begin
 28         if (~rst) begin
 29                 found <= 'b0;
 30                 curr_node <= start_node;
 31                 stop <= 1'b0;
 32         end else begin
 33                 if (curr_node == check_addr) begin
 34                         found <= 1'b1;
 35                         stop <= 1'b1;
 36                 end else if (curr_node != 0) begin
 37                         curr_node <= register_file[curr_node][ADDR_WIDTH-1:0];
 38                 end else begin
 39                         stop <= 1'b0;
 40         end
 41 end
 42 
 43 
 44 endmodule
