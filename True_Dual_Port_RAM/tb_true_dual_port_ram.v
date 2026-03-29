`timescale 1ns / 1ps

module tb_true_dual_port_ram();

    parameter ADDR_WIDTH = 10;
    parameter DATA_WIDTH = 8;
    
    reg  clk_a;       
    reg  we_a;        
    reg  [ADDR_WIDTH-1:0]addr_a ;     
    reg  [DATA_WIDTH-1:0]write_data_a;
    wire [DATA_WIDTH-1:0]read_data_a;
    reg  clk_b;     
    reg  we_b;        
    reg  [ADDR_WIDTH-1:0]addr_b;      
    reg  [DATA_WIDTH-1:0]write_data_b;
    wire [DATA_WIDTH-1:0]read_data_b; 
    
    true_dual_port_ram uut (
        .clk_a          (clk_a       ),
        .we_a           (we_a        ),
        .addr_a         (addr_a      ),
        .write_data_a   (write_data_a),
        .read_data_a    (read_data_a ),
        .clk_b          (clk_b       ),
        .we_b           (we_b        ),
        .addr_b         (addr_b      ),
        .write_data_b   (write_data_b),
        .read_data_b    (read_data_b )
    );
    integer i;
    
    always #5 clk_a = ~clk_a;
    always #7 clk_b = ~clk_b;
    
    initial begin 
        {clk_a,we_a,addr_a,write_data_a} = 0;
        {clk_b,we_b,addr_b,write_data_b} = 0;
        #20;
        
        $display("\n **PORT_A WRITE OPERATION**");
        we_a = 1;
        for(i = 0; i<10; i=i+1)begin
            @(posedge clk_a);
            addr_a = i;
            write_data_a = i+10;
            $display(" Writing: Addr=%0d | Write_data=%0d",addr_a,write_data_a);   
        end
        #20 we_a = 0;
        
        $display("\n **PORT_B READ OPERATION**");
        for(i = 0; i<10; i=i+1)begin
            @(posedge clk_b);
            addr_b = i; 
            @(posedge clk_b);
            $display(" Reading: Addr=%0d | Read_data=%0d",addr_b,read_data_b);
        end
        
        $display("\n **SIMULATANEOUS OPERATION**");
        we_a = 1; // Write
        we_b = 0; // Read
        
        for(i = 0; i<10; i=i+1)begin
            
            @(posedge clk_a);
            addr_a = i;
            write_data_a = i+20;
            
            @(posedge clk_b);
            addr_b = i;
            @(posedge clk_b);
            $display(" PORT_A: Write_addr=%0d , Write_data=%0d |PORT_B: Read_addr=%0d , Read_data=%0d",addr_a,write_data_a,addr_b,read_data_b);
        end
        we_a = 0;
        
        #50 $finish;
    end 
endmodule
