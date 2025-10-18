// Testbench for FIFO
module tb_fifo_basic;

//Testbench signals
logic clk;
logic rst;
logic wr_en, rd_en;
logic [31:0] data_in;
logic [31:0] data_out;
logic full, empty;

//Instantiate the FIFO
top dut(.*);

initial begin
 clk = 0;
 always #5 clk = ~clk; //toggle clock every 5ns hence period is 10ns

 //initialize
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;
    #10;// holds reset for 2 clk cycles
    rst = 0; //then changes it to 0

    #15; //wait until reset deasserted

    repeat (5) begin
        wr_en = 1;
        data_in = $random; //random data is written
        #10 ; // wait 1 cycle
    end
    wr_en = 0; // stop writing

    #80; //Wait for writes to finish

    repeat (5) begin //Read 5 values from FIFO
        rd_en = 1; 
        #10; //wait 1 clock cycle
    end
    rd_en = 0;
    200;
    $finish //ending simulation after 200ns

end 

endmodule 




