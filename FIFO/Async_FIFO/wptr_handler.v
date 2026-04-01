// Write Pointer Handler
module wptr_handler #(
    parameter ADDR_WIDTH = 4
    )(
    input wclk, wrst_n, wr_en,           
  input [ADDR_WIDTH :0] g_rptr_sync,      // Read pointer (gray) - synchronised to wclk
    output [ADDR_WIDTH-1:0] waddr,          // Write address
    output reg [ADDR_WIDTH :0] g_wptr,      // Write pointer
    output reg wfull                        // Full flag
    );

    reg [ADDR_WIDTH:0] b_wptr;                         // Binary write pointer
    wire [ADDR_WIDTH:0] g_wptr_next, b_wptr_next;      // Next write pointer in gray and binary code
    wire wfull_val;                                    // Full flag value
    
    // Synchronous FIFO write pointer (gray code)
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin           
            b_wptr <= 0;
            g_wptr <= 0;
        end
        else begin
            b_wptr <= b_wptr_next;
            g_wptr  <= g_wptr_next; 
        end
    end

    assign waddr = b_wptr[ADDR_WIDTH-1:0];                // Write address calculation from the write pointer
    assign b_wptr_next = b_wptr + (wr_en & ~wfull);       // Increment the write pointer if not full
    assign g_wptr_next = (b_wptr_next>>1) ^ b_wptr_next;  // Convert binary to gray code

    // Check if the FIFO is full
     assign wfull_val=((g_wptr_next[ADDR_WIDTH] !=g_rptr_sync[ADDR_WIDTH] ) &&
     (g_wptr_next[ADDR_WIDTH-1] !=g_rptr_sync[ADDR_WIDTH-1]) &&
     (g_wptr_next[ADDR_WIDTH-2:0]==g_rptr_sync[ADDR_WIDTH-2:0]));


    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n)             
            wfull <= 1'b0;
        else 
            wfull <= wfull_val;  
    end
endmodule
