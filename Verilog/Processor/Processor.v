`timescale 1ns / 1ps

module Processor(clk1,clk2);

input clk1, clk2;

reg [8:0] PC, IF_ID_IR, IF_ID_NPC;
reg [8:0] ID_EX_IR, ID_EX_NPC, ID_EX_A, ID_EX_B, ID_EX_Imm;
reg [1:0] ID_EX_type, EX_MEM_type, MEM_WB_type;
reg [8:0] EX_MEM_IR, EX_MEM_ALUOut, EX_MEM_B;
reg [8:0] MEM_WB_IR, MEM_WB_ALUOut;

reg [8:0] Reg [0:11];   //12 Registers storing 9 bit data
reg [8:0] Mem [0:1023]; //1024 x 9 bit memory

parameter MV = 3'b000,MVI = 3'b001 ,ADD = 3'b010,SUB = 3'b011,
          AND = 3'b100, OR = 3'b101, XOR = 3'b110,NOT=3'b111;

parameter RR_ALU=1'b00, RM_ALU=1'b01;



//Instruction Fetch stage
always @(posedge clk1)
	

	    begin
	             IF_ID_IR  <= #2 Mem[PC];                           //picking instruction from memory
	             IF_ID_NPC <= #2 PC+1;                              //updating new program counter
		         PC        <= #2 PC+1;                              //updating program counter
		end
	
	     

//Instruction Decode Stage
always @(posedge clk2)
	
	begin
	    if (IF_ID_IR[5:3] ==5'b000)                            //updating register A
		ID_EX_A <=0;
	    else
		ID_EX_A <= #2 Reg[IF_ID_IR[5:3]];  //rx

	    if (IF_ID_IR[2:0] ==5'b000)                            //updating register B
		ID_EX_B <=0;
	    else
		ID_EX_B <= #2 Reg[IF_ID_IR[2:0]];  //ry

	     ID_EX_NPC  <= #2 IF_ID_NPC;                               //forwarding NPC to execution stage
	     ID_EX_IR   <= #2 IF_ID_IR;                                //forwarding instruction to execution stage
	     ID_EX_Imm  <= #2 {{6{IF_ID_IR[2]}}, {IF_ID_IR[2:0]}};         //sign extending immediate value to 9bits

	    case (IF_ID_IR[8:6])                                    //declaring type of opcode
	    
		MV,ADD,SUB,AND,OR,XOR,NOT:   ID_EX_type <= #2 RR_ALU;
		MVI :	                     ID_EX_type <= #2 RM_ALU;
		
		endcase
	end

//Execution Stage
always @(posedge clk1)
	
	begin
	     EX_MEM_type   <= #2 ID_EX_type;                          //forwarding type of opcode memory stage
	     EX_MEM_IR     <= #2 ID_EX_IR;                            //forwarding instruction to memory stage
	                                   

	case (ID_EX_type)                                             //executing function according to type                  
		RR_ALU: begin
			case (ID_EX_IR[8:6])
                MV:    begin  
                         ID_EX_A <= #1 ID_EX_B ;
                         EX_MEM_ALUOut <= #1 ID_EX_A; 
                       end
				ADD:     EX_MEM_ALUOut <= #2 ID_EX_A + ID_EX_B;
				SUB:     EX_MEM_ALUOut <= #2 ID_EX_A - ID_EX_B;
				AND:     EX_MEM_ALUOut <= #2 ID_EX_A & ID_EX_B;
				OR:      EX_MEM_ALUOut <= #2 ID_EX_A | ID_EX_B;
				XOR:     EX_MEM_ALUOut <= #2 ID_EX_A ^ ID_EX_B;
				
				default: EX_MEM_ALUOut <= #2 9'bxxxxxxxx;
			endcase
			end

		RM_ALU: begin
			case (ID_EX_IR[8:6])
				
		                MVI: begin 
		                     ID_EX_A       <= #1 ID_EX_Imm; 
                             EX_MEM_ALUOut <= #1 ID_EX_A; 
                             end
		                default: EX_MEM_ALUOut <= #2 9'bxxxxxxxx;
			endcase
			end

		
	endcase
	end

//Memory Stage 
always @(posedge clk2)
	
	begin
	     MEM_WB_type <= #2 EX_MEM_type;                           //forwarding type to write back stage
	     MEM_WB_IR   <= #2 EX_MEM_IR;                             //forwarding instruction to write back stage

	case (EX_MEM_type)
		RR_ALU, RM_ALU: MEM_WB_ALUOut <= #2 EX_MEM_ALUOut;

	endcase
	end

//Write Back Stage
always @(posedge clk1)
	begin


	case ( MEM_WB_type)
		RR_ALU: Reg[MEM_WB_IR[5:3]] <= #2 MEM_WB_ALUOut;           //writing back in destination register(rd) 

		RM_ALU: Reg[MEM_WB_IR[2:0]] <= #2 MEM_WB_ALUOut;           //writing back in destination register(rt)

	

		
	endcase
	end


endmodule




