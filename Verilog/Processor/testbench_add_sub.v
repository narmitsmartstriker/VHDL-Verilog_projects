`timescale 1ns / 1ps

module test_processor;

reg clk1, clk2;
integer k;
integer j;

Processor mips(clk1, clk2);

initial begin                        //generating two phase clock
clk1 =0; clk2 =0;                    
repeat (50)
	begin
	     #5 clk1 =1; #5 clk1 =0;
	     #5 clk2 =1; #5 clk2 =0;
	end
end

initial begin
for (k=0; k<16; k=k+1)
	mips.Reg[k] =k;               //initialising all the register values with k

 
    mips.Mem[1] = 9'b010011100;   //add R4 to R3 => R3 = 7
    mips.Mem[2] = 9'b011110101;   //sub R5 from R6 => R6 = 1
    
  
    
	

	            
	mips.PC = 0;
	

	#20000
	
	$display("Mem[7]= %2d , Mem[0]= %6d", mips.Mem[7], mips.Mem[0]);
end

initial begin
  
    
    
	$monitor("R1: %4d",mips.Reg[1]);
	$monitor("R2: %4d",mips.Reg[2]);
	$monitor("R3: %4d",mips.Reg[3]);
	$monitor("R4: %4d",mips.Reg[4]);
	$monitor("R5: %4d",mips.Reg[5]);
	$monitor("R6: %4d",mips.Reg[6]);
	$monitor("R7: %4d",mips.Reg[7]);
	

	 #3000;
	 
	   for (j=0; j<12; j=j+1)
       begin
       
       
       $display("R%0d: %4d",j, mips.Reg[j]);
       end
	
end

endmodule
