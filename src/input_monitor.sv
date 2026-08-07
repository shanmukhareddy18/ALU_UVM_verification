class input_monitor extends uvm_monitor;
 `uvm_component_utils(input_monitor)
 virtual inf.INP_MON vif;
  uvm_analysis_port#(seq_item) inp_ap;
 seq_item trans;
function new(string name="input_monitor",uvm_component parent);
  super.new(name,parent);
 endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 inp_ap=new("inp_ap",this);
 if(!uvm_config_db #(virtual inf)::get(this,"","vif",vif))
    `uvm_fatal(get_type_name(),"Monitor failed")
endfunction

task run_phase(uvm_phase phase);
begin
 
        repeat(5) @(vif.inp_mon_cb);
forever begin
trans=seq_item::type_id::create("trans");
            trans.CE        = vif.inp_mon_cb.CE;
            trans.INP_VALID = vif.inp_mon_cb.INP_VALID;
            trans.OPA       = vif.inp_mon_cb.OPA;
            trans.OPB       = vif.inp_mon_cb.OPB;
            trans.MODE      = vif.inp_mon_cb.MODE;
            trans.CMD       = vif.inp_mon_cb.CMD;
            trans.CIN        =vif.inp_mon_cb.CIN;
    `uvm_info("IN_MON",$sformatf("OPA=%0d OPB=%d CIN=%d CMD=%0d MODE=%0d CE=%0d INP_VALID=%0b",
          trans.OPA, trans.OPB,trans.CIN, trans.CMD, trans.MODE, trans.CE, trans.INP_VALID),UVM_LOW)
         @(vif.inp_mon_cb);
         inp_ap.write(trans);
       end

end
endtask
endclass

