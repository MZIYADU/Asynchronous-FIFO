module async_fifo_tb;

    reg [7 : 0] data_in;
    reg wen, ren, wclk, rclk, wrst, rrst;

    wire [7 : 0] data_out;

    wire full, empty;
    integer i;
    
    // Inside module async_fifo_tb;
    wire [3:0] wptr_addr; // To hold the write pointer address (3 bits for index, 4 for safety)
    wire [7:0] monitored_data; // To hold the data read from the memory for monitoring

    asynchronous_fifo async_fifo (.r_data(data_out), .full(full), .empty(empty), .w_data(data_in), .r_en(ren), .w_en(wen), .w_rst(wrst), .r_rst(rrst), .rclk(rclk), .wclk(wclk));

    // Inside module async_fifo_tb, outside of initial/always blocks
    assign wptr_addr = async_fifo.fifomem1.wptr[2:0] - 1; 
    assign monitored_data = async_fifo.fifomem1.fifo[wptr_addr];

    initial begin
        rclk = 1'b0;
        wclk = 1'b0;
    end

    always #10 rclk = ~rclk;
    always #5 wclk = ~wclk;
    

    initial begin
        // Inside the initial block
        $monitor ("write data = %d, read data = %d and mem write data = %d", data_in, data_out, monitored_data);
        $dumpfile("async_fifo.vcd");
        $dumpvars(0,async_fifo_tb);

        for (i = 0; i<200 ; i = i + 1)
            begin
                if (full) begin
                    wen = 0;
                    #10;
                end
                else begin
                    #10 wen = 1; data_in = i;
                end
            end
        #10 $finish;
    end

    initial begin
        wen = 1'b0;
        ren = 1'b0;
        #10 wen = 1'b1;
        ren = 1'b1;
    end

    initial begin
        wrst = 1; rrst = 1;
        #10 wrst = 0; rrst = 0;
    end
endmodule


        
        
