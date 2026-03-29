`timescale 1ns / 1ps

module sync_fifo #(
    parameter DATA_WIDTH = 16,
    parameter DEPTH = 16
)(
    input  wire clk,
    input  wire rst,
    input  wire wr_en,
    input  wire rd_en,
    input  wire [DATA_WIDTH-1:0] wdata,
    output reg  [DATA_WIDTH-1:0] rdata,
    output      full,
    output      empty
);

    localparam PTR_WIDTH = $clog2(DEPTH);
    reg [PTR_WIDTH:0] wptr, rptr;          // 1 extra bit for full/empty
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    wire wrap_around;
    
    assign wrap_around = wptr[PTR_WIDTH] ^ rptr[PTR_WIDTH];
    assign empty = (wptr == rptr);
    assign full  = wrap_around && (wptr[PTR_WIDTH-1:0] == rptr[PTR_WIDTH-1:0]);


    
    always@(posedge clk) begin
        if (rst) begin
            wptr  <= 0;
        end 
        else if(wr_en && !full) begin
            mem[wptr[PTR_WIDTH-1:0]] <= wdata;
            wptr <= wptr + 1'b1;
        end
    end

    always@(posedge clk) begin
         if (rst) begin
            rptr  <= 0;
            rdata <= 0;
        end 
        else if(rd_en && !empty) begin
            rdata <= mem[rptr[PTR_WIDTH-1:0]];
            rptr <= rptr + 1'b1;
        end
    end

endmodule
   
