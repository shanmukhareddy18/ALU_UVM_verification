class seq_item extends uvm_sequence_item;
  function new(string name="seq_item");
    super.new(name);
 endfunction
  rand logic [`DW - 1:0] OPA,OPB;
  rand logic CE,MODE,CIN;
  rand logic [`CW - 1:0] CMD;
  rand logic [1:0] INP_VALID;
  bit [`DW + 1:0] RES ;
  bit COUT ;
  bit OFLOW ;
  bit G ;
  bit E;
  bit L ;
  bit ERR ;
 `uvm_object_utils_begin(seq_item)
    `uvm_field_int(OPA,       UVM_ALL_ON )
    `uvm_field_int(OPB,       UVM_ALL_ON )
    `uvm_field_int(CMD,       UVM_ALL_ON )
    `uvm_field_int(INP_VALID, UVM_ALL_ON)
    `uvm_field_int(MODE,      UVM_ALL_ON )
    `uvm_field_int(CE,        UVM_ALL_ON )
  `uvm_object_utils_end


 constraint c1{
   CE dist {0:=1, 1:=100};
 }
  constraint c2{
 if(MODE==1)
   CMD inside {[0:10]};
 }
 constraint c3{
 if(MODE==0)
  CMD inside {[0:13]};
}

endclass
