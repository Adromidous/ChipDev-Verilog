module model (
    input a,
    input b,
    input cin,
    output logic sum,
    output logic cout
);

always_comb begin

    sum = a ^ b ^ cin;
    cout = (a & b) | (cin & (a | b));

end

endmodule
