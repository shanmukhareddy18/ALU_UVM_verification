class output_monitor extends uvm_monitor;
 `uvm_component_utils(output_monitor)
 virtual inf.OUT_MON vif;
  uvm_analysis_port#(seq_item) out_ap;
 seq_item tr;
function new(string name="output_monitor",uvm_component parent);
  super.new(name,parent);
 endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 out_ap=new("out_ap",this);
 if(!uvm_config_db #(virtual inf)::get(this,"","vif",vif))
    `uvm_fatal(get_type_name(),"Monitor failed")
endfunction

task run_phase(uvm_phase phase);
begin

	 repeat(5)  @(vif.out_mon_cb);
 tr=seq_item::type_id::create("tr");
 forever begin
	  @(vif.out_mon_cb);
	tr.RES=vif.out_mon_cb.RES;
	tr.COUT=vif.out_mon_cb.COUT;
        tr.OFLOW=vif.out_mon_cb.OFLOW;
        tr.G=vif.out_mon_cb.G;
        tr.L=vif.out_mon_cb.L;
        tr.E=vif.out_mon_cb.E;
        tr.ERR=vif.out_mon_cb.ERR;
        `uvm_info("OUT_MON", $sformatf(
      "DUT Outputs -> RES:'h%0h | COUT:%0b | OFLOW:%0b | ERR:%0b",
      tr.RES, tr.COUT, tr.OFLOW, tr.ERR), UVM_NONE)
        out_ap.write(tr);
       end

end
endtask

endclass 

