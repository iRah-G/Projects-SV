//Design for FIFO
module top (
   input logic clk,
   input logic rst,
   input bit wr_en, rd_en,
   input logic [31:0]  data_in,// actual data bus to push in FIFO
   output logic [31:0] data_out, // data read from FIFO
   output logic full, empty
);

//Internal FIFO memory and pointers control signal
   logic [31:0] mem [15:0]; //16 memory locations each 32 bit wide
   logic  [ 3: 0] wr_ptr, rd_ptr; //points to next location to write and read respectively
   logic [4:0] count; //5 bits to count 0:16

// Full and empty conditions
assign full = (count ==16); // when count is 16 (FIFO size) writing is blocked
assign empty = (count == 0); //when count is 0 there is nothing to read

//Sequential clocked always_ff block
always_ff @( posedge clk or posedge rst ) begin
     if (rst) begin
          wr_ptr <= 0;
          rd_ptr <= 0;
          count <= 0;
          data_out<= 0;
     end // reset and pointers initialized to 0
     else begin
           if (wr_en)
               wr_mem(data_in);
           if(rd_en)
               rd_mem();
     end 
end

//automatic keyword creates local variable copies, makes the task dynamic avoids overwriting and race around conditions
    task automatic wr_mem( input logic [31:0] din)  //din is the argument to task in order to make it reusable instead of directly writing to data_in
     if (!full) begin
          mem [wr_ptr] = din; //write data to mem
          wr_ptr = wr_ptr + 1; //increment pointer
          count = count + 1; // increment element count 
          $display ("Data written at address %0d: %0h", wr_ptr, din);
     end
     else begin
          $display ("Memory is full");
     end
    endtask

    task automatic rd_mem( )
     if(!empty) begin
          data_out = mem[rd_ptr]; //read data from memory
          rd_ptr = rd_ptr + 1;// increment read pointer
          count = count - 1; //decrement element counter
          $display ("Data read from address %0d : %0h", rd_ptr, data_out);
     end
     else begin 
         $display ("Memory is empty");
     end
    endtask

endmodule







  