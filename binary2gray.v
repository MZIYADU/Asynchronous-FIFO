module b2g (d_out, d_in);

    input [3:0] d_in;
    output reg [3:0] d_out;
    integer i;

    always @(d_in)
        begin
            d_out[3] = d_in[3];
            for (i = 0; i<3; i= i+1)
                begin
                    d_out[i] = d_in[i] ^ d_in[i+1];
                end 
        end
endmodule
