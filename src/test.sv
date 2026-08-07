class test extends uvm_test;
`uvm_component_utils(test)
function new(string name="test",uvm_component parent);
 super.new(name,parent);
endfunction

env ee;

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 ee=env::type_id::create("ee",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
 super.end_of_elaboration_phase(phase);
 uvm_top.print_topology();
endfunction

sequence10 s10;
sequence11 s11;
sequence12 s12;
sequence1 s1;
sequence2 s2;
sequence3 s3;
sequence4 s4;
sequence5 s5;
sequence6 s6;
sequence7 s7;
sequence8 s8;
sequence9 s9;

task run_phase(uvm_phase phase);
 phase.raise_objection(this);
 s10=sequence10::type_id::create("s10");
 s11=sequence11::type_id::create("s11");
 s12=sequence12::type_id::create("s12");
 s1=sequence1::type_id::create("s1");
 s2=sequence2::type_id::create("s2");
 s3=sequence3::type_id::create("s3");
 s4=sequence4::type_id::create("s4");
 s5=sequence5::type_id::create("s5");
 s6=sequence6::type_id::create("s6");
 s7=sequence7::type_id::create("s7");
 s8=sequence8::type_id::create("s8");
 s9=sequence9::type_id::create("s9");

#40;
 s9.start(ee.agnt_a.seqr);
/* s10.start(ee.agnt_a.seqr);
 s11.start(ee.agnt_a.seqr);
 s12.start(ee.agnt_a.seqr);
 s1.start(ee.agnt_a.seqr);
 s2.start(ee.agnt_a.seqr);
 s3.start(ee.agnt_a.seqr);
 s4.start(ee.agnt_a.seqr);
 s5.start(ee.agnt_a.seqr);
 s7.start(ee.agnt_a.seqr);
 s8.start(ee.agnt_a.seqr);
 s9.start(ee.agnt_a.seqr);*/
phase.phase_done.set_drain_time(this, 50);
 phase.drop_objection(this);
endtask

endclass
