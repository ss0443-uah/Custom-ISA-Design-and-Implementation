module regbank (
input logic clk, regwe, regrd,
input logic [4:0] rd_addr, rs_addr, wr_addr,
input logic [15:0] write_data,
output logic [15:0] rd, rs
); 
	logic [15:0] myreg[31:0];
	always_ff @(posedge clk)
	begin
		if (regwe)
		begin 
			if (wr_addr==0) myreg[wr_addr] <= 0;
			else if (wr_addr==1) myreg[wr_addr] <= 16'h0001;
			else myreg[wr_addr] <= write_data;
		end
	end
	assign rs = (regrd)? myreg[rs_addr]:0;
	assign rd = (regrd)? myreg[rd_addr]:0;
endmodule

module signExt (input logic [4:0] data_in,
		output logic [15:0] data_out);
	assign data_out = {{12{data_in[4]}},data_in[3:0]};
endmodule
		

module myAlu (input logic [15:0] A, B,
		input logic alusrc, reset,
                input logic [2:0] alu_cb,
                output logic [15:0] ALUOUT,
		output logic [3:0] status);
	logic [15:0] comp;
        always_comb
        begin
		if (reset)
		begin
			status = 4'd0;
			ALUOUT = 16'd0;
			comp = 16'd0;
		end
		else if (alusrc)
		begin
			case (alu_cb)
                        3'b000: begin  
				comp = 16'd0;
				ALUOUT = $signed(A) + $signed(B);
				if (ALUOUT == 16'd0)
					status[3] = 1'b1;
				else
					status[3] = 1'b0;
				if (ALUOUT[15] == 1'b1)
					status[2] = 1'b1;
				else
					status[2] = 1'b0;
				if ((A[15]==1'b0) && (B[15]==1'b0) && (ALUOUT[15] == 1'b1))
					status[1] = 1'b1;
				else
					status[1] = 1'b0;
				if ((A[15]==1'b1) && (B[15]==1'b1) && (ALUOUT[15] == 1'b0))
					status[1] = 1'b1;
				else
					status[1] = 1'b0;
				if (A>=B)
					status[0] = 1'b1;
				else
					status[0] = 1'b0;
				end
                        3'b001: begin  
				comp = 16'd0;
				ALUOUT = $signed(A) - $signed(B);
				if (A == B)
					status[3] = 1'b1;
				else
					status[3] = 1'b0;
				if (ALUOUT[15] == 1'b1)
					status[2] = 1'b1;
				else
					status[2] = 1'b0;
				if ((A[15]==1'b0) && (B[15]==1'b1) && (ALUOUT[15] == 1'b1))
					status[1] = 1'b1;
				else
					status[1] = 1'b0;
				if ((A[15]==1'b1) && (B[15]==1'b0) && (ALUOUT[15] == 1'b0))
					status[1] = 1'b1;
				else
					status[1] = 1'b0;
				if (A>=B)
					status[0] = 1'b1;
				else
					status[0] = 1'b0;
				end
			3'b010: begin  
				comp = 16'd0;
				ALUOUT = A&B;
				status[1] = 1'b0;
				if (ALUOUT == 16'd0)
					status[3] = 1'b1;
				else
					status[3] = 1'b0;
				if (ALUOUT[15] == 1'b1)
					status[2] = 1'b1;
				else
					status[2] = 1'b0;
				if (A>=B)
					status[0] = 1'b1;
				else
					status[0] = 1'b0;
				end
			3'b011: begin  
				comp = 16'd0;
				ALUOUT = A|B;
				status[1] = 1'b0;
				if (ALUOUT == 16'd0)
					status[3] = 1'b1;
				else
					status[3] = 1'b0;
				if (ALUOUT[15] == 1'b1)
					status[2] = 1'b1;
				else
					status[2] = 1'b0;
				if (A>=B)
					status[0] = 1'b1;
				else
					status[0] = 1'b0;
				end
			3'b100: begin  
				comp = 16'd0;
				ALUOUT = ~B;
				status[1] = 1'b0;
				status[0] = 1'b0;
				if (ALUOUT == 16'd0)
					status[3] = 1'b1;
				else
					status[3] = 1'b0;
				if (ALUOUT[15] == 1'b1)
					status[2] = 1'b1;
				else
					status[2] = 1'b0;
				end
			3'b101: begin
				ALUOUT = 16'd0;  
				comp = $signed(A) - $signed(B);
				if (A == B)
					status[3] = 1'b1;
				else
					status[3] = 1'b0;
				if (comp[15] == 1'b1)
					status[2] = 1'b1;
				else
					status[2] = 1'b0;
				if ((A[15]==1'b0) && (B[15]==1'b1) && (comp[15] == 1'b1))
					status[1] = 1'b1;
				else
					status[1] = 1'b0;
				if ((A[15]==1'b1) && (B[15]==1'b0) && (comp[15] == 1'b0))
					status[1] = 1'b1;
				else
					status[1] = 1'b0;
				if (A>=B)
					status[0] = 1'b1;
				else
					status[0] = 1'b0;
				end
			default: begin
				ALUOUT = 16'd0;
				comp = 16'd0;
				status = 4'd0;
				end
			endcase
		end
		else 
		begin
			ALUOUT = 16'd0;
			comp = 16'd0;
			status = 4'd0;
                end
	end
endmodule

module datapath(
input logic clk, reg_we,alusrc,reg_rd,lw_add_e,sw_add_e, lwi, w0, w1, reset,
input logic [2:0] alu_cb,
input logic [4:0] lw_addr, sw_addr_d, sw_addr_s,
input wire [15:0] ins,
input  wire [15:0] data_in,
input logic [6:0] mem_addr,
output logic ri,
output logic [6:0] addr,
output logic [6:0] daddr,
output logic [15:0] data,
output logic [3:0] status
);
logic [15:0] rd, rs, aluout, rs_reg, rs_im, reg_in;
//wire  [15:0] ins;
//wire  [15:0] data_in;
logic [4:0] rbank_wr,rd_addr,rs_addr;
regbank my_reg(.clk(clk), .regwe(reg_we), .regrd(reg_rd), .rd_addr(rd_addr), .rs_addr(rs_addr), .wr_addr(rbank_wr), .write_data(reg_in), .rd(rd), .rs(rs_reg) );
myAlu alu(.A(rd), .B(rs), .alusrc(alusrc), .reset(reset), .alu_cb(alu_cb), .ALUOUT(aluout), .status(status[3:0]));
signExt sign(.data_in(ins[5:1]), .data_out(rs_im));
assign rs = (ins[11])? rs_im : rs_reg; 
assign addr = mem_addr;
//assign ri = lw_add_e;
assign daddr = (lw_add_e||sw_add_e) ? (rs_reg[6:0]):7'b0;

always_comb
begin
	if (lwi)
	begin
		reg_in = ins[15:0];
	end
	else if (lw_add_e)
	begin
		reg_in = data_in[15:0];
	end
	else
	begin
		reg_in = aluout;
	end
	if (w0) rbank_wr = 0;
	else if (w1) rbank_wr = 5'b00001;
	else if (lwi) rbank_wr = lw_addr;
	else rbank_wr = ins[10:6];
	if (sw_add_e)
	begin
		rd_addr = sw_addr_d;
		rs_addr = sw_addr_s;
		data = rd[15:0];
		ri = 1'b0;
	end
	else
	begin
		rd_addr = ins[10:6];
		rs_addr = ins[5:1];
		data = 16'b0;
		ri = 1'b1;
	end
end
endmodule

module control(
input logic start, clk, reset, 
input logic [3:0] status,
input wire [15:0] ins, 
output logic [2:0] alu_cb,
output logic [4:0] lw_addr, sw_addr_d, sw_addr_s,
output logic [6:0] mem_addr,
output logic mem_we,reg_we,alusrc,reg_rd,lw_add_e,sw_add_e,lwi,done,w0,w1);
	wire [15:0] ins;
	logic [6:0] pc,ra;
	logic lwe,swe,swd,go,stop, lwei,lw_add_ei,mem_rd;
	logic [3:0] status_int;
	
	
	typedef enum logic [3:0] {s0, s1, s2, s3, s4, s5, s6, s7,s8,s9,s10,s11} statetype;
        statetype state, nextstate;
	always_ff @(posedge clk)
	begin
		if (reset)  state <= s0;
		else if (start) state <= s1;
		else if (go) state <= nextstate;
		
	end
	
	always_comb
        begin
                case (state)
                        s0: begin
				if(start) nextstate = s1;
				else nextstate = s0;
			    end
                        s1: nextstate = s2;
			s2: nextstate = s3;
			s3: nextstate = s5;
                        s4: begin 
				if(lwei) nextstate = s6;
				else if(lwe) nextstate = s8;
				else if (stop) nextstate = s9;
				else nextstate = s5;
			    end
			s5: nextstate = s4;
			s6: nextstate = s7;
			s7: nextstate = s10;
			s8: nextstate = s11;
                        s9: begin
				if (start) nextstate = s1; 
				else nextstate = s9;
			    end
			s10: nextstate = s11;
			s11: nextstate = s4;
			default: nextstate = s0;
                endcase
        end
	always_ff @(posedge clk)
	begin
	if (nextstate == s0)
	begin 
		go <= 1'b0;
		done <= 1'b0;
		stop <= 1'b0;
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		mem_rd <= 1'b1;
		reg_rd <= 1'b0;
		w0 <= 1'b0;
		w1 <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		lwi <= 1'b0;
		lwei <= 1'b0;
		swd <= 1'b0;
		alu_cb <= 3'b0;
		lw_addr <= 4'b0;
		sw_addr_d <= 4'b0;
		sw_addr_s <= 4'b0;
		lw_add_ei <= 1'b0;
		pc <= 7'd0;
		ra <= 7'd0;
		status_int <= 4'b0;
	end
	else if (nextstate == s1)
	begin
		go <= 1'b1;
		done <= 1'b0;
		
	end
	else if (nextstate == s2)
	begin
		w0 <= 1'b1;
		reg_we <= 1'b1;
	end
	else if (nextstate == s3)
	begin
		w0 <= 1'b0;
		w1 <= 1'b1;
		mem_rd <= 1'b1;
		reg_we <= 1'b1;
	end
	else if (nextstate == s4)
	begin
		reg_we <= 1'b0;
		mem_rd <= 1'b1;
		alusrc <= 1'b0;
		status_int <= status;
		if (lwe)
			begin
			reg_we <= 1'b1;
			end	
	end
	else if (nextstate == s5)
	begin
	w1 <= 1'b0;
	case (ins[15:12])
	4'd0: begin	
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		mem_rd <= 1'b1;
		reg_rd <= 1'b1;
		lwi <= 1'b0;
		if (ins[0])
		begin	
			stop <= 1'b1;
			pc <= pc;
		end
		else
			pc <= pc + 1;
	     end
	4'd1: begin
		alu_cb <= 3'b0;
		alusrc <= 1'b1;
		reg_we <= 1'b1;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= pc + 1;
	     end
	4'd2: begin
		alu_cb <= 3'b001;
		alusrc <= 1'b1;
		reg_we <= 1'b1;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= pc + 1;
	     end
	4'd3: begin
		alu_cb <= 3'b010;
		alusrc <= 1'b1;
		reg_we <= 1'b1;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= pc + 1;
	     end
	4'd4: begin
		alu_cb <= 3'b011;
		alusrc <= 1'b1;
		reg_we <= 1'b1;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= pc + 1;
	     end
	4'd5: begin
		alu_cb <= 3'b100;
		alusrc <= 1'b1;
		reg_we <= 1'b1;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= pc + 1;
	     end 
	4'd6: begin
		alu_cb <= 3'b101;
		alusrc <= 1'b1;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= pc + 1;
	     end
	4'd7:begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		sw_add_e <= 1'b0;
		swe <= 1'b0;
		lw_addr <= ins[10:6];
		if (ins[11])
		begin 
		lwei <= 1'b1;
		pc <= pc+1;
		end
		else
		begin
		lw_add_e <= 1'b1;
		lwei <= 1'b0;
		lwe <= 1'b1;
		pc <= pc;
		end
	   end
	4'd8:begin
		sw_addr_d <= ins[10:6];
		sw_addr_s <= ins[5:1];
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b1;
		lwe <= 1'b0;
		lwi <= 1'b0;
		pc <= pc + 1;
	   end
	4'd9: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lwi <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= ins[7:1];
	     end
	4'd10: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		if (status_int[3])
		pc <= ins[7:1];
		else pc <= pc + 1;
	     end
	4'd11: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		if (status_int[3] == 1'b0)
		pc <= ins[7:1];
		else pc <= pc + 1;
	     end
	4'd12: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		if (status_int[0])
		pc <= ins[7:1];
		else pc <= pc + 1;
	     end
	4'd13: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		if (status_int[2])
		pc <= ins[7:1];
		else pc <= pc + 1;
	     end
	4'd14: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		ra <= pc+1;
		pc <= ins[7:1];
	     end
	4'd15: begin
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwi <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		pc <= ra;
	     end
	endcase
	end		
	else if (nextstate == s6)
	begin
		lwei <= 1'b0;		 
	end
	else if (nextstate == s7)
	begin
		lwi <= 1'b1;
		reg_we <= 1'b1;		 
	end
	else if (nextstate == s8)
	begin
		lwe <= 1'b0;
		reg_we <= 1'b0;
		lw_add_e <= 1'b0;
		pc <= pc + 1;
	end
	else if (nextstate == s9)
	begin
		go <= 1'b0;
		lw_add_e <= 1'b0;
		sw_add_e <= 1'b0;
		swd <= 1'b0;
		alusrc <= 1'b0;
		reg_we <= 1'b0;
		lwe <= 1'b0;
		swe <= 1'b0;
		mem_rd <= 1'b0;
		reg_rd <= 1'b0;
		stop <= 1'b0;
		done <= 1'b1;
	end
	end
	
	assign mem_we=(mem_rd)?1'b1:1'b0;
	assign mem_addr = pc;
endmodule


module my_risc(
input logic Iclk, Ireset, Istart, Iwrb, Iaccess,
input logic [6:0] Iaddr, 
input logic [15:0] Idata_in,
output logic [15:0] Odata_out,
output logic O_done
);

logic clk, reset, start, wrb, access;
logic [6:0] addr; 
logic [15:0] data_in;
logic [15:0] data_out;
logic done,pad_dr;

logic we_in, mem_we,reg_we,alusrc,reg_rd,lw_add_e,sw_add_e,lwi,w0,w1,ri,OEB1,OEB2;
logic [3:0] status;
logic [6:0] addr_in,c_mem_addr,d_addr,daddr_in;
logic [15:0] mdata_in, ins, rdata_in, mdata_out, rdata_out;
//wire [15:0] mdata_out, rdata_out;
logic [2:0] alu_cb;
logic [4:0] lw_addr,sw_addr_d, sw_addr_s;
assign mdata_in = (access)?data_in : 0;
assign addr_in= (access)?addr : d_addr;
//assign addr_in= (access)?addr : 0;
assign ins= (access)?0 : mdata_out;
assign data_out = (access)? mdata_out : 0;
assign we_in = (access)? wrb:mem_we;
assign OEB1 = 1'b0;
assign OEB2 = 1'b0;
assign pad_dr = 1'b1;
//assign mdata_out = (OEB1) ? 16'bz : mdata_out1;
//assign rdata_out = (OEB2) ? 16'bz : rdata_out1;

ISH1025 pad0 ( .PADIO(Iclk), .R_EN(pad_dr), .DOUT(clk) );
ISH1025 pad1 ( .PADIO(Ireset), .R_EN(pad_dr), .DOUT(reset) );
ISH1025 pad2 ( .PADIO(Istart), .R_EN(pad_dr), .DOUT(start) );
ISH1025 pad3 ( .PADIO(Iwrb), .R_EN(pad_dr), .DOUT(wrb) );
ISH1025 pad4 ( .PADIO(Iaccess), .R_EN(pad_dr), .DOUT(access) );

ISH1025 pad5 ( .PADIO(Iaddr[0]), .R_EN(pad_dr), .DOUT(addr[0]) );
ISH1025 pad6 ( .PADIO(Iaddr[1]), .R_EN(pad_dr), .DOUT(addr[1]) );
ISH1025 pad7 ( .PADIO(Iaddr[2]), .R_EN(pad_dr), .DOUT(addr[2]) );
ISH1025 pad8 ( .PADIO(Iaddr[3]), .R_EN(pad_dr), .DOUT(addr[3]) );
ISH1025 pad9 ( .PADIO(Iaddr[4]), .R_EN(pad_dr), .DOUT(addr[4]) );
ISH1025 pad10 ( .PADIO(Iaddr[5]), .R_EN(pad_dr), .DOUT(addr[5]) );
ISH1025 pad11 ( .PADIO(Iaddr[6]), .R_EN(pad_dr), .DOUT(addr[6]) );

ISH1025 pad12 ( .PADIO(Idata_in[0]), .R_EN(pad_dr), .DOUT(data_in[0]) );
ISH1025 pad13 ( .PADIO(Idata_in[1]), .R_EN(pad_dr), .DOUT(data_in[1]) );
ISH1025 pad14 ( .PADIO(Idata_in[2]), .R_EN(pad_dr), .DOUT(data_in[2]) );
ISH1025 pad15 ( .PADIO(Idata_in[3]), .R_EN(pad_dr), .DOUT(data_in[3]) );
ISH1025 pad16 ( .PADIO(Idata_in[4]), .R_EN(pad_dr), .DOUT(data_in[4]) );
ISH1025 pad17 ( .PADIO(Idata_in[5]), .R_EN(pad_dr), .DOUT(data_in[5]) );
ISH1025 pad18 ( .PADIO(Idata_in[6]), .R_EN(pad_dr), .DOUT(data_in[6]) );
ISH1025 pad19 ( .PADIO(Idata_in[7]), .R_EN(pad_dr), .DOUT(data_in[7]) );
ISH1025 pad20 ( .PADIO(Idata_in[8]), .R_EN(pad_dr), .DOUT(data_in[8]) );
ISH1025 pad21 ( .PADIO(Idata_in[9]), .R_EN(pad_dr), .DOUT(data_in[9]) );
ISH1025 pad22 ( .PADIO(Idata_in[10]), .R_EN(pad_dr), .DOUT(data_in[10]) );
ISH1025 pad23 ( .PADIO(Idata_in[11]), .R_EN(pad_dr), .DOUT(data_in[11]) );
ISH1025 pad24 ( .PADIO(Idata_in[12]), .R_EN(pad_dr), .DOUT(data_in[12]) );
ISH1025 pad25 ( .PADIO(Idata_in[13]), .R_EN(pad_dr), .DOUT(data_in[13]) );
ISH1025 pad26 ( .PADIO(Idata_in[14]), .R_EN(pad_dr), .DOUT(data_in[14]) );
ISH1025 pad27 ( .PADIO(Idata_in[15]), .R_EN(pad_dr), .DOUT(data_in[15]) );

D2I1025 p_0 ( .DIN(data_out[0]), .EN(pad_dr), .PADIO(Odata_out[0]) );
D2I1025 p_1 ( .DIN(data_out[1]), .EN(pad_dr), .PADIO(Odata_out[1]) );
D2I1025 p_2 ( .DIN(data_out[2]), .EN(pad_dr), .PADIO(Odata_out[2]) );
D2I1025 p_3 ( .DIN(data_out[3]), .EN(pad_dr), .PADIO(Odata_out[3]) );
D2I1025 p_4 ( .DIN(data_out[4]), .EN(pad_dr), .PADIO(Odata_out[4]) );
D2I1025 p_5 ( .DIN(data_out[5]), .EN(pad_dr), .PADIO(Odata_out[5]) );
D2I1025 p_6 ( .DIN(data_out[6]), .EN(pad_dr), .PADIO(Odata_out[6]) );
D2I1025 p_7 ( .DIN(data_out[7]), .EN(pad_dr), .PADIO(Odata_out[7]) );
D2I1025 p_8 ( .DIN(data_out[8]), .EN(pad_dr), .PADIO(Odata_out[8]) );
D2I1025 p_9 ( .DIN(data_out[9]), .EN(pad_dr), .PADIO(Odata_out[9]) );
D2I1025 p_10 ( .DIN(data_out[10]), .EN(pad_dr), .PADIO(Odata_out[10]) );
D2I1025 p_11 ( .DIN(data_out[11]), .EN(pad_dr), .PADIO(Odata_out[11]) );
D2I1025 p_12 ( .DIN(data_out[12]), .EN(pad_dr), .PADIO(Odata_out[12]) );
D2I1025 p_13 ( .DIN(data_out[13]), .EN(pad_dr), .PADIO(Odata_out[13]) );
D2I1025 p_14 ( .DIN(data_out[14]), .EN(pad_dr), .PADIO(Odata_out[14]) );
D2I1025 p_15 ( .DIN(data_out[15]), .EN(pad_dr), .PADIO(Odata_out[15]) );

D2I1025 p_16 ( .DIN(done), .EN(pad_dr), .PADIO(O_done) );

//SRAM16x1024 ram(.A1(addr_in), .A2((daddr_in)) , .CE1(clk), .CE2(clk), .WEB1(we_in), .WEB2(ri), .OEB1(OEB1), .OEB2(OEB2), .I1(mdata_in), .I2(rdata_in), .O1(mdata_out), .O2(rdata_out));
SRAM16x128 ram(.A1(addr_in), .A2((daddr_in)) , .CE1(clk), .CE2(clk), .WEB1(we_in), .WEB2(ri), .OEB1(OEB1), .OEB2(OEB2), .CSB1(1'b0), .CSB2(1'b0), .I1(mdata_in), .I2(rdata_in), .O1(mdata_out), .O2(rdata_out));
control cb(.start(start), .clk(clk), .reset(reset), .status(status), .ins(ins), .alu_cb(alu_cb), .mem_addr(c_mem_addr), .mem_we(mem_we),.reg_we(reg_we),.alusrc(alusrc),.reg_rd(reg_rd),.lw_add_e(lw_add_e),.sw_add_e(sw_add_e),.lwi(lwi),.done(done), .w0(w0), .w1(w1), .lw_addr(lw_addr), .sw_addr_d(sw_addr_d), .sw_addr_s(sw_addr_s));
datapath dp(.clk(clk), .reg_we(reg_we), .alusrc(alusrc), .reg_rd(reg_rd), .lw_add_e(lw_add_e), .sw_add_e(sw_add_e), .lwi(lwi), .alu_cb(alu_cb), .mem_addr(c_mem_addr), .ins(ins), .addr(d_addr), .data(rdata_in), .status(status), .w0(w0), .w1(w1), .reset(reset), .lw_addr(lw_addr), .data_in(rdata_out), .daddr(daddr_in), .ri(ri), .sw_addr_d(sw_addr_d), .sw_addr_s(sw_addr_s));
endmodule
