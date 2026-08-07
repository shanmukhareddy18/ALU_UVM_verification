class driver extends uvm_driver #(seq_item);
 `uvm_component_utils(driver)
 virtual inf.DRV vif;
function new(string name="driver",uvm_component parent);
 super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_config_db #(virtual inf)::get(this,"","vif",vif))
   `uvm_fatal(get_type_name(),"Driver failed")
endfunction
task  run_phase(uvm_phase phase);
 begin
 repeat(1) @(vif.drv_cb);
  forever begin
	  seq_item_port.get_next_item(req);
 	 drive(req);
  	seq_item_port.item_done();
   end
 end
endtask
task drive(seq_item trans);
 begin
     @(vif.drv_cb);
       `uvm_info("DRV",$sformatf("------------------------------------------------------------------------------"),UVM_LOW)

	
  	    vif.drv_cb.CE        <= trans.CE;
	    vif.drv_cb.INP_VALID <= trans.INP_VALID;
	    vif.drv_cb.OPA        <= trans.OPA;
	    vif.drv_cb.OPB        <= trans.OPB;
            vif.drv_cb.MODE      <= trans.MODE;
	    vif.drv_cb.CMD       <= trans.CMD;
	    vif.drv_cb.CIN        <=trans.CIN;
        `uvm_info("DRV",$sformatf("OPA=%0d OPB=%0d CMD=%0d MODE=%0d CE=%0d INP_VALID=%0b",
          trans.OPA, trans.OPB, trans.CMD, trans.MODE, trans.CE, trans.INP_VALID),UVM_LOW)
     
  end
endtask
endclass
