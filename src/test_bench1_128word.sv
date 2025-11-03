`timescale 1ns/10ps

module test_bench1 ();
logic Iclk, Ireset, Istart, Iwrb, Iaccess;
logic [6:0] Iaddr; 
logic [15:0] Idata_in;
logic [15:0] Odata_out;
logic O_done;
my_risc dut(Iclk, Ireset, Istart, Iwrb, Iaccess, Iaddr, Idata_in, Odata_out, O_done);
 always
         begin
                Iclk=0; #40; Iclk=1; #40;
         end
         initial
         begin
                Ireset=1;
                Istart = 0;
		Iaccess=1;
		Iwrb = 0;
		Iaddr = 64;
		Idata_in = 5;
                #80;
		Ireset=0;
		Iaddr = 65;
		Idata_in = 7;
		#80;
		Iaddr = 0;
		Idata_in = 16'h78C0; //LW R3,#0200
		#80;
		Iaddr = 1;
		Idata_in = 16'h0040;
		#80;
		Iaddr = 2;
		Idata_in = 16'h7106; //LW R4, R3
		#80;
		Iaddr = 3;
		Idata_in = 16'h18C2; // ADD R3, #1
		#80;
		Iaddr = 4;
		Idata_in = 16'h7146; //LW R5, R3
		#80;
		Iaddr = 5;
		Idata_in = 16'h1148; // ADD R5, R4
		#80;
		Iaddr = 6;
		Idata_in = 16'h18C2; // ADD R3, #1
		#80;
		Iaddr = 7;
		Idata_in = 16'h8146; // SW R5, R3
		#80;
		Iaddr = 8;
		Idata_in = 16'h7186; // LW R6, R3
		#80;
		Iaddr = 9;
		Idata_in = 16'h2188; // SUB R6, R4
		#80;
		Iaddr = 10;
		Idata_in = 16'h18C2; // ADD R3, #1
		#80;
		Iaddr = 11;
		Idata_in = 16'h8186; // SW R6, R3
		#80;
		Iaddr = 12;
		Idata_in = 16'h0001; // HALT
		#80;
		Iaccess = 0;
		Istart = 1;
		Iwrb = 1;
		#80;
		Istart = 0;
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, done=%b", $time, O_done);
		Iaccess = 1;
		Iaddr = 64;
		#80;
		$display("time=%5d ns, A=%16d", $time, Odata_out);
		Iaddr = 65;
		#80;
		$display("time=%5d ns, B=%16d", $time, Odata_out);
		Iaddr = 66;
		#80;
		$display("Checking C=A+B");
		$display("time=%5d ns, C=%16d", $time, Odata_out);
		Iaddr = 67;
		if (Odata_out != 12) begin
		 $display("Error");
		 end
		 else begin
		 $display("PASS");
		 end
		#80;
		$display("Checking D=C-A");
		$display("time=%5d ns, D=%16d", $time, Odata_out);
		if (Odata_out != 7) begin
		 $display("Error");
		 end
		 else begin
		 $display("PASS");
		 end		
		$finish;
	end
	initial
        begin
                $dumpfile ("my_risc.dump");
                $dumpvars (0, test_bench1);
        end // initial begin

endmodule
		
