class agent_active extends uvm_agent;
`uvm_component_utils(agent_active) 
function new(string name="agent_active",uvm_component parent);
   super.new(name,parent);
 endfunction

input_monitor inp_mon;
driver drv;
sequencer seqr;

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 seqr=sequencer::type_id::create("seqr",this);
 drv=driver::type_id::create("drv",this);
 inp_mon=input_monitor::type_id::create("inp_mon",this);
endfunction

function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass 
