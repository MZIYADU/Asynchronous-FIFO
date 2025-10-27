module test;

reg [3 : 0] binary;
wire [3 : 0] grey;

b2g bg(grey,binary);

initial begin

    $monitor ("binary = %b, grey = %b", binary, grey);
    binary = 4'b0000;
    #5 binary = 8'b0001;
    #5 binary = 8'b0101;
    #5 binary = 8'b1100;
    #5 $finish;
end

endmodule