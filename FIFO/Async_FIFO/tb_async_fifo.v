`timescale 1ns/1ps

module tb_async_fifo;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;
    parameter DEPTH = 1 << ADDR_WIDTH;
    
    reg  wclk, rclk;
    reg  wrst_n, rrst_n;
    reg  wr_en, rd_en;
    reg  [DATA_WIDTH-1:0] wdata;
    wire [DATA_WIDTH-1:0] rdata;
    wire wfull, rempty;

    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .wclk(wclk),
        .wrst_n(wrst_n),
        .wr_en(wr_en),
        .rclk(rclk),
        .rrst_n(rrst_n),
        .rd_en(rd_en),
        .wdata(wdata),
        .rempty(rempty),
        .wfull(wfull),
        .rdata(rdata)
    );

    always #5  wclk = ~wclk;   // 100 MHz
    always #7  rclk = ~rclk;   // ~71 MHz

    integer i;

    initial begin
        {wclk ,rclk ,wr_en ,rd_en ,wdata ,wrst_n ,rrst_n}= 0;

        #20;
        wrst_n = 1;
        rrst_n = 1;

        $display("---- RESET RELEASED ----");

        // Write DATA into FIFO
        $display("---- WRITE PHASE ----");
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge wclk);
            if (!wfull) begin
                wr_en = 1;
                wdata = i + 200;
                $display("WRITE: %h", wdata);
            end
        end
        @(posedge wclk);
        wr_en = 0;

        // Try extra write (should block)
        @(posedge wclk);
        wr_en = 1;
        wdata = 8'hFF;
        @(posedge wclk);
        wr_en = 0;

        if (wfull)
            $display("FIFO FULL detected correctly");

        // Read DATA from FIFO
        $display("---- READ PHASE ----");
        #50;  // Let pointers synchronize

        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge rclk);
            if (!rempty) begin
                rd_en = 1;
                @(posedge rclk);
                $display("READ: %h", rdata);
            end
        end
        rd_en = 0;

        if (rempty)
            $display("FIFO EMPTY detected correctly");

        // Mixed Read/Write (CDC stress)
        $display("---- MIXED READ/WRITE ----");

        fork
            begin
                for (i = 0; i < 10; i = i + 1) begin
                    @(posedge wclk);
                    if (!wfull) begin
                        wr_en = 1;
                        wdata = i + 100;
                        $display("WRITE: %h", wdata);
                    end
                end
                wr_en = 0;
            end

            begin
                #30;
                for (i = 0; i < 10; i = i + 1) begin
                    @(posedge rclk);
                    if (!rempty) begin
                        rd_en = 1;
                        @(posedge rclk);
                        $display("READ: %h", rdata);
                    end
                end
                rd_en = 0;
            end
        join

        #100;
        $finish;
    end

endmodule
