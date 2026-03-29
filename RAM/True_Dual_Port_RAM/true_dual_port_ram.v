`timescale 1ns / 1ps

module true_dual_port_ram #(
    parameter ADDR_WIDTH = 10,
    parameter DATA_WIDTH = 8
    )(
    // PORT-A
    input clk_a,
    input we_a,
    input [ADDR_WIDTH-1:0]addr_a,
    input [DATA_WIDTH-1:0]write_data_a,
    output reg [DATA_WIDTH-1:0]read_data_a,
    // PORT_B
    input clk_b,
    input we_b,
    input [ADDR_WIDTH-1:0]addr_b,
    input [DATA_WIDTH-1:0]write_data_b,
    output reg [DATA_WIDTH-1:0]read_data_b
    );
    
    localparam DEPTH = 1<<ADDR_WIDTH;
    reg [DATA_WIDTH -1:0]mem[0:DEPTH-1];
    
    always@(posedge clk_a) begin
        if(we_a)
            mem[addr_a] <= write_data_a;
         read_data_a <= mem[addr_a];
    end
    
    always@(posedge clk_b) begin
        if(we_b)
            mem[addr_b] <= write_data_b;
         read_data_b <= mem[addr_b];
    end
endmodule
