`timescale 1ns / 1ps

module simple_dual_port_ram #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 16
    )(
    input clk,
    input we,
    input      [ADDR_WIDTH-1:0] w_addr,
    input      [DATA_WIDTH-1:0] write_data,
    input      [ADDR_WIDTH-1:0] r_addr,
    output reg [DATA_WIDTH-1:0] read_data
    );
        
    localparam DEPTH = 1 << ADDR_WIDTH;
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    
    always@(posedge clk) begin
        // Write Operation
        if(we) 
            mem[w_addr] <= write_data;
        // Read Operation
        read_data <= mem[r_addr];
    end
endmodule
