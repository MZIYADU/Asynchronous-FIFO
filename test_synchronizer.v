module test;

    reg [3 : 0] d_in;
    wire [3 : 0] d_out;
    reg clk, rst;

    synchronizer sync(d_out,d_in,clk,rst);

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1; d_in = 4'b0000;
        #10 rst = 1'b0;
        #10 d_in = 4'b0001;
        #10 d_in = 4'b0010;
        #10 d_in = 4'b0101;
        #10 d_in = 4'b1111;
    end

    initial begin
        $monitor("time = %t  :: input = %d, intermediate = %d, output = %d",$time, d_in, sync.q1, d_out);
        $dumpfile("sync.vcd");
        $dumpvars(0,test);
        #70 $finish;
    end
endmodule