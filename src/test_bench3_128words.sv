`timescale 1ns/10ps

module test_bench3 ();
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
		Idata_in = 3;
                #80;
		Ireset=0;
		Iaddr = 65;
		Idata_in = 12;
		#80;
		Iaddr = 0;
		Idata_in = 16'h78C0; //LW R3,#64
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
		Idata_in = 16'hE012; // CALL DIV(#9)
		#80;
		Iaddr = 6;
		Idata_in = 16'h18C2; // ADD R3, #1
		#80;
		Iaddr = 7;
		Idata_in = 16'h8186; // SW R6, R3
		#80;
		Iaddr = 8;
		Idata_in = 16'h0001; // HALT
		#80;
		Iaddr = 9;
		Idata_in = 16'h3180; // DIV: AND R6, R0
		#80;
		Iaddr = 10;
		Idata_in = 16'h6148; // CMP R5, R4
		#80;
		Iaddr = 11;
		Idata_in = 16'hC01A; // JGE L1
		#80;
		Iaddr = 12;
		Idata_in = 16'hD028; // JL L2
		#80;
		Iaddr = 13;
		Idata_in = 16'h6140; // L1: CMP R5,R0
		#80;
		Iaddr = 14;
		Idata_in = 16'hA020; // JZ O_done
		#80;
		Iaddr = 15;
		Idata_in = 16'hB022; // JNZ SUB1
		#80;
		Iaddr = 16;
		Idata_in = 16'hF000; // O_done: RET
		#80;
		Iaddr = 17;
		Idata_in = 16'h2148; // SUB1: SUB R5, R4
		#80;
		Iaddr = 18;
		Idata_in = 16'h1982; // ADD R6, #1
		#80;
		Iaddr = 19;
		Idata_in = 16'h901A; // JMP L1
		#80;
		Iaddr = 20;
		Idata_in = 16'h6100; // L2: CMP R4, R0
		#80;
		Iaddr = 21;
		Idata_in = 16'hA020; // JZ O_done
		#80;
		Iaddr = 22;
		Idata_in = 16'hB02E; // JNZ SUB2
		#80;
		Iaddr = 23;
		Idata_in = 16'h210A; // SUB2: SUB R4,R5
		#80;
		Iaddr = 24;
		Idata_in = 16'h1982; // ADD R6,#1
		#80;
		Iaddr = 25;
		Idata_in = 16'h9028; // JMP L2
		#80
		Iaccess = 0;
		Istart = 1;
		Iwrb = 1;
		#80;
		Istart = 0;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		#80;
		$display("time=%5d ns, O_done=%b", $time, O_done);
		Iaccess = 1;
		Iaddr = 64;
		#80;
		$display("time=%5d ns, A=%16d", $time, Odata_out);
		Iaddr = 65;
		#80;
		$display("time=%5d ns, B=%16d", $time, Odata_out);
		Iaddr = 66;
		#80;
		$display("Checking C=B/A");
		$display("time=%5d ns, C=%16d", $time, Odata_out);
		if (Odata_out != 4) begin
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
                $dumpvars (0, test_bench3);
        end // initial begin

endmodule
		
