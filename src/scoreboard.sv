class scoreboard extends uvm_scoreboard;
 `uvm_component_utils(scoreboard)
	uvm_tlm_analysis_fifo #(seq_item)inp_mon_fifo;
	uvm_tlm_analysis_fifo #(seq_item)out_mon_fifo;

	seq_item inp_mon_tx;
	seq_item out_mon_tx;
        seq_item inp_mon_hold;
 function new(string name="scoreboard",uvm_component parent);
	super.new(name,parent);
	inp_mon_fifo=new("inp_mon_fifo",this);
	out_mon_fifo=new("out_mon_fifo",this);
 endfunction
bit x=0;
int PASS_COUNT=0;
int FAIL_COUNT=0;
task run_phase(uvm_phase phase);
 forever begin
    
    inp_mon_fifo.get(inp_mon_tx);
    out_mon_fifo.get(out_mon_tx);
    `uvm_info("SCB inp_mon_tx",$sformatf("OPA=%0d OPB=%0d CIN=%d CMD=%0d MODE=%0d CE=%0d INP_VALID=%0b", inp_mon_tx.OPA, inp_mon_tx.OPB,inp_mon_tx.CIN, inp_mon_tx.CMD, inp_mon_tx.MODE, inp_mon_tx.CE, inp_mon_tx.INP_VALID),UVM_LOW)
 if(x==0)begin
    inp_mon_hold=inp_mon_tx;
    x=1; end
   else begin
     reference(inp_mon_hold);
     inp_mon_hold=inp_mon_tx;
     end 
 //    reference(inp_mon_tx);
 //  compare();
 end
endtask
virtual function void extract_phase(uvm_phase phase);
  super.extract_phase(phase);
 `uvm_info("RESULTS",$sformatf("PASS_COUNT=%d FAIL_COUNT=%0d ", PASS_COUNT,FAIL_COUNT),UVM_LOW)
 
endfunction

bit [10:0] count;
bit [1:0]inp_v;
bit [7:0] A,B;
bit [15:0]res;
bit [15:0]temp_res;
bit err;
bit G,L,E,cout,oflow;
bit first_valid;
bit second_valid;
bit mode;
bit [4:0]cmd;
int delay=0;
task reference(seq_item tr);
 `uvm_info("SCB inp_mon_hold",$sformatf("OPA=%0d OPB=%0d CIN =%d CMD=%0d MODE=%0d CE=%0d INP_VALID=%0b", tr.OPA, tr.OPB, tr.CIN, tr.CMD, tr.MODE,tr.CE, tr.INP_VALID),UVM_LOW)

if(tr.CE) begin
  if(tr.MODE!=mode || tr.CMD!=cmd)
  	begin count=0; first_valid=0; second_valid=0; end 

  if(tr.INP_VALID==2'b11 )
      begin
		first_valid=1;
		second_valid=1;
		count=0;
	end
  else if(count==0 && (tr.INP_VALID==2'b01 || tr.INP_VALID==2'b10))
 	begin 
            	count=1; 
		first_valid=1;
                inp_v=tr.INP_VALID;
 		 mode=tr.MODE;
 		cmd=tr.CMD;
	 end
  else if(first_valid==1 && tr.INP_VALID!=inp_v && tr.INP_VALID!=2'b00 && count<16 && tr.MODE==mode
             && tr.CMD==cmd)
        begin
		second_valid=1;
		inp_v=tr.INP_VALID;
		count=0;
	end
  else
   count++;
 end
 if(tr.INP_VALID==2'b01)
  A=tr.OPA;

 if(tr.INP_VALID==2'b10)
  B=tr.OPB;

 if(tr.INP_VALID==2'b11)
  begin A=tr.OPA; B=tr.OPB;end

/* if(count==16)
  begin err=1; count=0;  end
 else
  err=0;*/


if(tr.CE)
   begin
   E=0;G=0;L=0;
   if(tr.CMD==9 || tr.CMD==10 && tr.MODE==1)
     res=temp_res;
 /*   tr.RES=res;
    tr.COUT=cout;
   tr.G=G;
   tr.E=E;
    tr.L=L;
    tr.OFLOW=oflow;
    tr.ERR=err;*/
    if(tr.MODE)
    begin
      	case(tr.CMD)             
   	 4'b0000: if(first_valid && second_valid ) begin         
                		res=A+B;
	      			cout=res[8]?1:0;
            	end
    	 4'b0001 :if(first_valid && second_valid ) begin 
             cout=(A<B)?1:0;
             res=A-B;
            end
    	 4'b0010:            
            if(first_valid && second_valid ) begin 
             res=A+B+tr.CIN;
             cout=res[8]?1:0;
            end
    	 4'b0011:             
           if(first_valid && second_valid ) begin 
            oflow=(A<B)?1:0;
            res=A-B-tr.CIN;
           end
    	 4'b0100:begin count =0; 
                       if(tr.INP_VALID==2'b01 || tr.INP_VALID==2'b11 ) res=A+1;     
		end
     	4'b0101:begin count=0;
		if(tr.INP_VALID==2'b01 || tr.INP_VALID==2'b11) res=A-1;    
		end
    	 4'b0110:begin count=0;
			if(tr.INP_VALID==2'b10 || tr.INP_VALID==2'b11) res=B+1;  
		end   
     	4'b0111:begin count=0;
		   	if(tr.INP_VALID==2'b10 || tr.INP_VALID==2'b11) res=B-1;
		end 
     	4'b1000: 
	 if(first_valid && second_valid )             
           begin 
            res=9'b0;
            if(A==B)
             begin
               E=1'b1;
               G=1'b0;
               L=1'b0;
             end
            else if(A>B)
             begin
               E=1'b0;
               G=1'b1;
               L=1'b0;
             end
            else 
             begin
               E=1'b0;
               G=1'b0;
               L=1'b1;
             end
           end

	4'b1001: if(first_valid && second_valid ) begin   
                    temp_res =(A+1) * (B +1);
                  end
	4'b1010: if(first_valid && second_valid ) begin   
                    temp_res =(A << 1) * (B); 
                  end

	default:   
            begin
            res=9'b0;
            cout=1'b0;
            oflow=1'b0;
            G=1'b0;
            E=1'b0;
            L=1'b0;
            err=1'b0;
           end
       endcase
     end

	else          
        begin 
            res=9'b0;
            cout=1'b0;
            oflow=1'b0;
            G=1'b0;
            E=1'b0;
            L=1'b0;
            err=1'b0;
	case(tr.CMD)    
             4'b0000:if(first_valid && second_valid ) res={1'b0,A&B};     
             4'b0001:if(first_valid && second_valid ) res={1'b0,~(A&B)};
	     4'b0010:if(first_valid && second_valid ) res={1'b0,A|B};  
 	     4'b0011:if(first_valid && second_valid ) res={1'b0,~(A|B)};
	     4'b0100:if(first_valid && second_valid ) res={1'b0,A^B};     
             4'b0101:if(first_valid && second_valid ) res={1'b0,~(A^B)};  
 	     4'b0110:begin count=0;
			if(tr.INP_VALID==2'b01 || tr.INP_VALID==2'b11) res={1'b0,~A};    
			end   
             4'b0111:begin count=0;
			   if(tr.INP_VALID==2'b10 || tr.INP_VALID==2'b11) res={1'b0,~B};
			end        
	     4'b1000:begin count=0;
 			if(tr.INP_VALID==2'b01 || tr.INP_VALID==2'b11) res={1'b0,A>>1};
		     end       
             4'b1001:begin count=0;
			if(tr.INP_VALID==2'b01 || tr.INP_VALID==2'b11) res={1'b0,A<<1};
		     end
	     4'b1010:begin count=0;
			if(tr.INP_VALID==2'b10 || tr.INP_VALID==2'b11) res={1'b0,B>>1}; 
		     end     
             4'b1011:begin count=0;
			if(tr.INP_VALID==2'b10 || tr.INP_VALID==2'b11) res={1'b0,B<<1};
                    end      
             4'b1100: begin
                        res = {8'b0,(A << B[2:0]) |(A >> (`DW-B[2:0]))};
                    if(B[`DW-1:4] != 0)
                        err = 1;
                   
                      end
 
             4'b1101: begin
                        res = {8'b0,(A >> B[2:0]) | (A << (`DW-B[2:0]))};
                    if(B[`DW-1:4] != 0)
                        err = 1;
       	            end  
            default:    
               begin
               res=0;
               cout=0;
               oflow=0;
               G=1'b0;
               E=1'b0;
               L=1'b0;
               err=1'b0;
               end
          endcase
       end
 end
  if(count==16)
  begin err=1; count=0;  end
 else
  err=0;

 tr.RES=res;
    tr.COUT=cout;
   tr.G=G;
   tr.E=E;
    tr.L=L;
    tr.OFLOW=oflow;
    tr.ERR=err;

`uvm_info("SCB",$sformatf("EXP: RES=%0d COUT=%0b OFLOW=%0b G=%0b E=%0b L=%0b ERR=%0b count_cycles=%d",
          tr.RES, tr.COUT, tr.OFLOW,
          tr.G, tr.E, tr.L, tr.ERR ,count),UVM_NONE)

 `uvm_info("SCB",$sformatf("OUT_MON IN SCD: RES=%0d COUT=%0b OFLOW=%0b G=%0b E=%0b L=%0b ERR=%0b",
          out_mon_tx.RES, out_mon_tx.COUT, out_mon_tx.OFLOW,
          out_mon_tx.G, out_mon_tx.E, out_mon_tx.L, out_mon_tx.ERR),UVM_NONE)
 if(out_mon_tx.RES===tr.RES && out_mon_tx.COUT===tr.COUT && out_mon_tx.G===tr.G && out_mon_tx.L===tr.L  && out_mon_tx.E===tr.E && out_mon_tx.OFLOW===tr.OFLOW && out_mon_tx.ERR===tr.ERR)
   begin `uvm_info("scb","PASS",UVM_NONE); 
          PASS_COUNT++;
	   `uvm_info("scb",$sformatf("PASS_CNT=%d",PASS_COUNT),UVM_NONE);	
           end
 else
  begin  
   	`uvm_info("scb","FAIL",UVM_NONE); FAIL_COUNT++; 
	   `uvm_info("scb",$sformatf("FAIL_CNT=%d",FAIL_COUNT),UVM_NONE);	
  end
endtask
/*task compare();
 `uvm_info("SCB",$sformatf("OUT_MON IN SCD: RES=%0d COUT=%0b OFLOW=%0b G=%0b E=%0b L=%0b ERR=%0b",
          out_mon_tx.RES, out_mon_tx.COUT, out_mon_tx.OFLOW,
          out_mon_tx.G, out_mon_tx.E, out_mon_tx.L, out_mon_tx.ERR),UVM_NONE)
 if(out_mon_tx.RES===tr.RES && out_mon_tx.COUT===tr.COUT && out_mon_tx.G===tr.G
           && out_mon_tx.L===tr.L  && out_mon_tx.E===tr.E && out_mon_tx.OFLOW===tr.OFLOW && out_mon_tx.ERR===tr.ERR)
   begin `uvm_info("scb","PASS",UVM_NONE); PASS_COUNT++; end
 else
  begin  `uvm_info("scb","FAIL",UVM_NONE); FAIL_COUNT++; end 
endtask*/

endclass
