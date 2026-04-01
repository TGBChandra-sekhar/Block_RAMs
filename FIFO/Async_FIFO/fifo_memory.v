// FIFO Memory Logic
module FIFO_memory #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
    )(
    input  wclk, wrst_n, wr_en,
    input  rclk, rrst_n, rd_en,
    input  [ADDR_WIDTH-1:0] wptr,
    input  [ADDR_WIDTH-1:0] rptr,
    input  [DATA_WIDTH-1:0] wdata,
    output reg [DATA_WIDTH-1:0] rdata,
    output  wfull,
    output  rempty
    );

    localparam DEPTH = 1<<ADDR_WIDTH;                 
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];            

    // Write Operation
    always @(posedge wclk) begin
        if (wr_en && !wfull) 
            mem[wptr] <= wdata; 
     end     
    // Read Operation      
    always @(posedge rclk) begin
        if(!rrst_n)begin
           rdata <= 0;
        end
        else if (rd_en && !rempty) 
           rdata <= mem[rptr];  
    end
endmodule

