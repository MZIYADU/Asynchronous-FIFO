module rdtr (r_binary, empty, r_gray, w_gray, en, clk, rst);



    input [3 : 0] r_gray, w_gray;
    input en, clk, rst;
    output reg [3 : 0] r_binary;
    output empty;


    always @(posedge clk or posedge rst)
        if (rst)
            r_binary <= 0;
        
        else if (en & !empty)
            r_binary <= r_binary +1;

    
    assign empty = (w_gray == r_gray);
endmodule