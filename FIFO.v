module asynchronous_fifo (r_data, full, empty, w_data, r_en, w_en, w_rst, r_rst, rclk, wclk);

    input [7 : 0] w_data;
    input r_en, w_en, w_rst, r_rst, rclk, wclk;
    output [7 : 0] r_data;
    output full, empty;

    wire [3 : 0] b_wptr, b_rptr, g_wptr, g_rptr, rg_wptr, wg_rptr;

    b2g wbg(.d_out(g_wptr), .d_in(b_wptr));
    b2g rbg(.d_out(g_rptr), .d_in(b_rptr));

    synchronizer r_sync (.d_out(rg_wptr),.d_in(g_wptr), .clk(rclk), .rst(r_rst));
    synchronizer w_sync (.d_out(wg_rptr),.d_in(g_rptr), .clk(wclk), .rst(w_rst));

    wptr w1 (.w_binary(b_wptr), .full(full), .w_gray(g_wptr), .r_gray(g_rptr), .en(w_en), .clk(wclk), .rst(w_rst));
    rdtr r1 (.r_binary(b_rptr), .empty(empty), .r_gray(g_rptr), .w_gray(g_wptr), .en(r_en), .clk(rclk), .rst(r_rst));

    fifo_mem fifomem1 (.read_out(r_data), .write_in(w_data), .wptr(b_wptr), .rptr(b_rptr), .full(full), .wclk(wclk), .w_en(w_en));

endmodule
    

    