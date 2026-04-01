// Read Pointer Handler
module rptr_handler #(
    parameter ADDR_WIDTH = 4
    )(
    input  rclk, rrst_n, rd_en,           
    input  [ADDR_WIDTH :0] g_wptr_sync,    // Write pointer (gray) - synchronised to read clock domain
    output [ADDR_WIDTH-1:0] raddr,         // Read address
    output reg [ADDR_WIDTH :0] g_rptr,     // Read pointer
    output reg rempty                      // Empty flag
    ); 

    reg [ADDR_WIDTH:0] b_rptr;                      // Binary read pointer
    wire [ADDR_WIDTH:0] g_rptr_next, b_rptr_next;   // Next read pointer in gray and binary code
    wire rempty_val;                                // Empty flag value

    // Synchronous FIFO read pointer (gray code)
    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin               
            b_rptr <= 0;
            g_rptr  <= 0;
        end
        else begin
            b_rptr <= b_rptr_next;
            g_rptr <= g_rptr_next;  
        end
    end

    assign raddr = b_rptr[ADDR_WIDTH-1:0];                  // Read address calculation from the read pointer
    assign b_rptr_next = b_rptr + (rd_en & ~rempty);        // Increment the read pointer if not empty
    assign g_rptr_next = (b_rptr_next>>1) ^ b_rptr_next;    // Convert binary to gray code

    // Check if the FIFO is empty
    assign rempty_val = (g_rptr_next == g_wptr_sync);       // Empty flag calculation

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n)                
            rempty <= 1'b1;
        else 
            rempty <= rempty_val;  
    end
endmodule
