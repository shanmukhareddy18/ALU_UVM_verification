class agent_passive extends uvm_agent;
`uvm_component_utils(agent_passive)
function new(string name="agent_passive",uvm_component parent);
   super.new(name,parent);
 endfunction

output_monitor out_mon;

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 out_mon=output_monitor::type_id::create("out_mon",this);
endfunction


endclass
