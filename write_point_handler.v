module wptr (w_binary, full, w_gray, r_gray, en, clk, rst );

    //write point handler

    input [3 : 0] w_gray, r_gray;
    input en, clk, rst;
    output reg [3 : 0] w_binary;
    output full; 

    always @(posedge clk or posedge rst) begin
        if(rst)
            w_binary <= 0;

        else if (en & !full)
            w_binary <= w_binary + 1;
        
    end

    assign full = ({~w_gray[3], w_gray[2 : 0]} == r_gray);

endmodule
