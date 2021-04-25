module FIFO (input clk , input reset , input wr_en , input rd_en , input logic [7:0] in , output logic [7:0] out , output wire full , output wire empty , output wire overflow , output wire underflow);
	
	reg[7:0] data[4];
	reg[2:0] w_addr, r_addr;
	 
	
	assign empty = (w_addr == r_addr);
	assign full = ((w_addr[1:0] == r_addr[1:0]) && (w_addr[2] ^ r_addr[2]));
	assign overflow = ((~reset)&&(full && wr_en));
	assign underflow = ((~reset)&&(empty && rd_en));

	always@(posedge clk) begin
		if(reset) begin
			w_addr <= 0;
			r_addr <= 0;
			$display("RESET SUCCESS @ %t" , $time);	
		end
		else if(wr_en && ~full) begin
			data[w_addr[1:0]] <= in;
			w_addr <= w_addr + 1'b1;
			$display("PUSH SUCCESS @ %t" , $time); 
		end
		else if(rd_en && ~empty) begin
			out <= data[r_addr[1:0]];
			r_addr <= r_addr + 1'b1;
			$display("POP SUCCESS @ %t" , $time);
		end
				else begin
			if(overflow) 
				$display("OVERFLOW ENCOUNTERED @ %t" , $time);
			else if(underflow) 
				$display("UNDERFLOW ENCOUNTERED @ %t" , $time);
			else
				$display("ERROR @ %t" , $time);
		end
	end
	

endmodule