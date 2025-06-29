module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic onehot
);

reg [$clog2(DATA_WIDTH):0] counter;

always_comb begin
  counter = 0;

  for (int i = 0; i < DATA_WIDTH; i++) begin
    counter += din[i];
  end

end

assign onehot = counter == 1;

endmodule
