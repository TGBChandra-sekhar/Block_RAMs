`timescale 1ns / 1ps

module tb_dual_port_ram();
    
    parameter ADDR_WIDTH = 10;
    parameter DATA_WIDTH = 16;
    
    reg clk;
    reg we;
    reg  [ADDR_WIDTH-1:0] w_addr;
    reg  [DATA_WIDTH-1:0] write_data;
    reg  [ADDR_WIDTH-1:0] r_addr;
    wire [DATA_WIDTH-1:0] read_data;
    
    simple_dual_port_ram uut(
        .clk         (clk       ),
        .we          (we        ),
        .w_addr      (w_addr    ),
        .r_addr      (r_addr    ),
        .write_data  (write_data),
        .read_data   (read_data )
    );
    integer i;
    always #5 clk = ~clk;
    
    initial begin
     {clk, we, w_addr, r_addr, write_data} = 0;
     #10;
     
     $display("------ WRITE OPERATION ------");
     we = 1;
     for (i=0; i<10; i = i+1) begin
        w_addr = i;
        write_data = i*10;
        #10;
        $display("Writing : addr = %0d | write_data = %0d", w_addr,write_data);
     end
     
     $display("------ READ OPERATION ------");
     we = 0;
     for (i=0; i<10; i = i+1) begin
        r_addr = i;
        #10;
        $display("Reading : addr = %0d | read_data_data = %0d", r_addr,read_data);
     end 
         
    end
endmodule
