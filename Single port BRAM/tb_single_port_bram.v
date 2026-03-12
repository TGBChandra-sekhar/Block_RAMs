`timescale 1ns / 1ps

module single_port_bram_tb();

    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 8;
    
    reg  clk;
    reg  we;
    reg  [ADDR_WIDTH-1:0]addr;     
    reg  [DATA_WIDTH-1:0]write_data;      
    wire [DATA_WIDTH-1:0]read_data;
    
    single_port_bram dut (
        .clk    (clk ),
        .we     (we  ),
        .addr   (addr),
        .write_data    (write_data ),
        .read_data   (read_data)
    );
    integer i;
    
    always #5 clk = ~clk;  // 100 MHz
    initial begin
        {clk,we,addr,write_data} = 0;
        #10;
        
        $display("------ WRITE OPERATION ------");
        we = 1;
        for(i = 0; i < 10; i = i + 1) begin
            addr = i;
            write_data  = i * 10;
            $display("Writing: addr=%0d | Write_data=%0d | Read_data=%0d", addr, write_data,read_data);
            #10;
        end

        $display("------ READ OPERATION ------");
        we = 0; 
        for(i = 0; i < 10; i = i + 1) begin
            addr = i;
            $display("Reading: addr=%0d | Read_data=%0d", addr, read_data);
            #10;
        end
        #50;
    end
endmodule
