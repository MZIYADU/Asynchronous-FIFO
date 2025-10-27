module synchronizer (d_out, d_in, clk, rst);

// 2 flop synchronizer

    input [3 : 0] d_in;
    reg [3 : 0] q1;
    input clk, rst;
    output reg [3 : 0] d_out;

    always @(posedge clk) begin
        
            if (rst)
                begin
                    q1 <= 0;
                    d_out <= 0;
                end
            else
                begin
                    q1 <= d_in;
                    d_out <= q1; 
                end
    end
        

endmodule