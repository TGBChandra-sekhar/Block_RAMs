`timescale 1ns / 1ps

module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wclk, wrst_n, wr_en,
    input  rclk, rrst_n, rd_en,
    input  [DATA_WIDTH-1:0] wdata,
    output [DATA_WIDTH-1:0] rdata,
    output rempty,                     
    output wfull
    );

    wire [ADDR_WIDTH-1:0] waddr, raddr;
    wire [ADDR_WIDTH:0] g_wptr, g_rptr, g_rptr_sync, g_wptr_sync;

    two_ff_sync #(ADDR_WIDTH+1) sync_r2w (   
        .clk    (wclk), 
        .rst_n  (wrst_n),
        .din    (g_rptr),    
        .dout   (g_rptr_sync) 
    );
    
    two_ff_sync #(ADDR_WIDTH+1) sync_w2r (   
        .clk    (rclk), 
        .rst_n  (rrst_n), 
        .din    (g_wptr),    
        .dout   (g_wptr_sync)
    );
   
    FIFO_memory fifo_mem (
        .wclk   (wclk),
        .rclk   (rclk),
        .wrst_n (wrst_n),
        .rrst_n (rrst_n),
        .wr_en  (wr_en),
        .rd_en  (rd_en),
        .wfull  (wfull),
        .rempty (rempty),
        .wptr   (waddr),
        .rptr   (raddr),
        .wdata  (wdata),
        .rdata  (rdata)
);
  
    rptr_handler rptr_empty(         
        .rclk         (rclk),
        .rrst_n       (rrst_n),
        .rd_en        (rd_en), 
        .raddr        (raddr),
        .g_rptr       (g_rptr),
        .g_wptr_sync  (g_wptr_sync),
        .rempty       (rempty)
    );
    
    wptr_handler  wptr_full(           
        .wclk        (wclk),
        .wrst_n      (wrst_n),
        .wr_en       (wr_en), 
        .waddr       (waddr),
        .g_wptr      (g_wptr), 
        .g_rptr_sync (g_rptr_sync),
        .wfull       (wfull)
    );

endmodule

