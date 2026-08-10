class env extends uvm_env;
`uvm_component_utils(env)
function new(string name="env",uvm_component parent);
super.new(name,parent);
endfunction

agent_active agnt_a;
agent_passive agnt_p;
scoreboard scb;
subscriber sub;

function void build_phase(uvm_phase phase);
super.build_phase(phase);
agnt_a=agent_active::type_id::create("agnt_a",this);
agnt_p=agent_passive::type_id::create("agnt_p",this);
scb=scoreboard::type_id::create("scb",this);
sub=subscriber::type_id::create("sub",this);
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
	agnt_a.inp_mon.inp_ap.connect(scb.inp_mon_fifo.analysis_export);
	agnt_p.out_mon.out_ap.connect(scb.out_mon_fifo.analysis_export);
	agnt_a.inp_mon.inp_ap.connect(sub.ap);
endfunction

endclass
