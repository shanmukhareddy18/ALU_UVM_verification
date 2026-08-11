class subscriber extends uvm_subscriber#(seq_item);
 seq_item tr;
`uvm_component_utils(subscriber);
 uvm_analysis_imp#(seq_item,subscriber) ap;
covergroup cg;
 coverpoint tr.CMD{
           bins b1[]={[0:13]};}
 coverpoint tr.MODE;
 coverpoint tr.INP_VALID;
endgroup

function new(string name="subscriber",uvm_component parent);
 super.new(name,parent);
 cg=new();
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 ap=new("ap",this);
endfunction

function void write(seq_item t);
tr=t;
cg.sample();
endfunction;

endclass
