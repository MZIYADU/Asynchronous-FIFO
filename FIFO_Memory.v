module fifo_mem (read_out, write_in, wptr, rptr, full, wclk, w_en);

    input [7 : 0] write_in;
    input [3 : 0] wptr, rptr;
    input full, wclk, w_en;
    output [7 : 0] read_out;

    reg [8 : 0] fifo [8 : 0];


    always @(posedge wclk)
        if (w_en & !full)
            fifo [wptr[2 : 0]] <= write_in;


    assign read_out = fifo[rptr [2 : 0]] ;
endmodule
