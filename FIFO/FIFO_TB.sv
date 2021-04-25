`timescale 1ns/1ns

module FIFO_TB;
	reg clk, reset, wr_en, rd_en;
	wire full, empty, overflow, underflow;
	wire [7:0] out;
	reg [7:0] in;

	FIFO dut(.clk(clk) , .reset(reset) , .wr_en(wr_en) , .rd_en(rd_en) , .in(in) , .out(out) , .full(full) , .empty(empty) , .overflow(overflow) , .underflow(underflow));

	always begin
		#10 clk = ~clk;
	end

	/*
	integer i;
	initial begin
		clk = 0;
	

		for(i = 0;i<15;i++) begin
			#10 clk = ~clk;
			#10 clk = ~clk;
		end
	end
*/

	initial begin
		clk = 0;
     	$dumpfile("FIFO.vcd");
     	$dumpvars(0,FIFO_TB);
     	
		reset <= 1; wr_en <= 0; rd_en <= 0; in <= 15; #20;
		reset <= 0; wr_en <= 0; rd_en <= 1; #20;
		reset <= 0; rd_en <= 0; wr_en <= 1; in <= 16; #20;
		reset <= 0; wr_en <= 1; in <= 17; #20;
		reset <= 0; wr_en <= 1; in <= 18; #20;
		reset <= 0; wr_en <= 1; in <= 19; #20;
		reset <= 0; wr_en <= 1; in <= 20; #20;
		reset <= 0; wr_en <= 0; in <= 16; #20;

		reset <= 0; rd_en <= 0; in <= 16; #20;
		reset <= 0; rd_en <= 0; in <= 16; #20;
		reset <= 0; rd_en <= 0; in <= 16; #20;
		reset <= 0; rd_en <= 0; in <= 16; #20;
		reset <= 0; rd_en <= 0; in <= 16; #20;
	end

endmodule