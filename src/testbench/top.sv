`include "interface.sv"
`include "ALU_DESIGN.sv"
`include "alu_pkg.sv"
module top;
import uvm_pkg::*;
 import alu_pkg::*;
 bit clk;
 bit reset;
	inf vif(clk,reset);
        ALU_DESIGN DUV(.OPA(vif.OPA),.OPB(vif.OPB),.CLK(clk),.RST(reset),.CE(vif.CE),.MODE(vif.MODE),
		.CIN(vif.CIN),.CMD(vif.CMD),.INP_VALID(vif.INP_VALID),.RES(vif.RES),.COUT(vif.COUT),
		.OFLOW(vif.OFLOW),.G(vif.G),.E(vif.E),.L(vif.L),.ERR(vif.ERR));
      initial
       begin
        reset = 1;
        repeat(4) @(posedge clk);
        reset = 0;
       #60; reset=1;
       #10; reset=0;
      end

 	initial
	begin
		uvm_config_db#(virtual inf)::set(null,"*","vif",vif);
        run_test("test");
	end
	initial
	begin
	clk=1'b0;
         forever 
	 #5 clk=~clk;
	end

endmodule

