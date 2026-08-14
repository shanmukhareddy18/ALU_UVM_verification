class sequence10 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence10)
 function new(string name="sequence10");
  super.new(name);
 endfunction
 task body();
 repeat(3) begin
  for(int i=0;i<=8;i++)
   begin
   req=seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize() with { INP_VALID==2'b11; MODE==1 ;CMD==i;  } );
   finish_item(req);
   end
 end
 endtask
endclass
class sequence11 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence11)
 function new(string name="sequence11");
  super.new(name);
 endfunction
 task body();
 for(int i=9;i<=10;i++)
  begin
  repeat(10) begin
   req=seq_item::type_id::create("req");
   start_item(req);
    assert(req.randomize() with { INP_VALID==2'b11; MODE==1 ;CMD==i;  } );
   finish_item(req);
  end
 end
 endtask
endclass

class sequence12 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence12)
 function new(string name="sequence12");
  super.new(name);
 endfunction
 task body();
 repeat(100) begin
  for(int i=0;i<=13;i++)
  begin
   req=seq_item::type_id::create("req");
   start_item(req);
    assert(req.randomize() with { INP_VALID==2'b11; MODE==0 ;CMD==i;  } );
   finish_item(req);
  end
 end
 endtask
endclass


class sequence1 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence1)
 function new(string name="sequence1");
  super.new(name);
 endfunction
int c;
task wait_cycles();
 repeat(6) begin  
 req=seq_item::type_id::create("req");
 start_item(req);
   assert(req.randomize() with {
                          MODE==1; INP_VALID==2'b01; CMD==local::c;
                              });
   finish_item(req);end
endtask

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with { 
			  MODE==1; INP_VALID==2'b01; !(CMD inside{4,5,6,7});
                              }); 
   c=req.CMD; 
  finish_item(req);
  wait_cycles();  
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==1; INP_VALID==2'b10; CMD==local::c;
                              });
  finish_item(req);
 end
endtask
endclass

class sequence2 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence2)
 function new(string name="sequence2");
  super.new(name);
 endfunction
int c;
task wait_cycles();
 repeat(6) begin
  req=seq_item::type_id::create("req");
 start_item(req);
   assert(req.randomize() with {
                          MODE==1; INP_VALID==2'b10; CMD==c;
                              });
   finish_item(req);end
endtask

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==1; INP_VALID==2'b10; !(CMD inside{4,5,6,7});
                              });
  c=req.CMD;
  finish_item(req);
  wait_cycles();
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==1; INP_VALID==2'b01; CMD==c;
                              });
  finish_item(req);
 end
endtask
endclass

class sequence3 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence3)
 function new(string name="sequence3");
  super.new(name);
 endfunction

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==1; INP_VALID!=2'b00; CMD inside{4,5,6,7};
                              });
  finish_item(req);
 end
endtask
endclass


class sequence4 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence4)
 function new(string name="sequence4");
  super.new(name);
 endfunction
int c;
task wait_cycles();
 repeat(6) begin
  req=seq_item::type_id::create("req");
 start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID==2'b01; CMD==c;
                              });
   finish_item(req);end
endtask

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID==2'b01; !(CMD inside{6,7,8,9,10,11});
                              });
  c=req.CMD;
  finish_item(req);
  wait_cycles();
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID==2'b10; CMD==c;
                              });
  finish_item(req);
 end
endtask
endclass


class sequence5 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence5)
 function new(string name="sequence5");
  super.new(name);
 endfunction
int c;
task wait_cycles();
 repeat(6) begin
  req=seq_item::type_id::create("req");
 start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID==2'b10; CMD==c;
                              });
   finish_item(req);end
endtask

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID==2'b10; !(CMD inside{6,7,8,9,10,11});
                              });
  c=req.CMD;
  finish_item(req);
  wait_cycles();
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID==2'b01; CMD==c;
                              });
  finish_item(req);
 end
endtask
endclass


class sequence6 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence6)
 function new(string name="sequence6");
  super.new(name);
 endfunction

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0; INP_VALID!=2'b00; CMD inside{6,7,8,9,10,11};
                              });
  finish_item(req);
 end
endtask
endclass

class sequence7 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence7)
 function new(string name="sequence7");
  super.new(name);
 endfunction
 task body();
 repeat(5) 
 begin
  for(int i=4;i<=7;i++)
   begin
   req=seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize() with { INP_VALID!=2'b11; MODE==1 ;CMD==i;  } );
   finish_item(req);
   end
 end
 endtask
endclass

class sequence8 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence8)
 function new(string name="sequence8");
  super.new(name);
 endfunction
 task body();
 repeat(5)
 begin
  for(int i=6;i<=11;i++)
   begin
   req=seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize() with { INP_VALID!=2'b11; MODE==0 ;CMD==i;  } );
   finish_item(req);
   end
 end
 endtask
endclass

class sequence9 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence9)
 function new(string name="sequence9");
  super.new(name);
 endfunction
int c;
task wait_cycles();
 repeat(20) begin
  req=seq_item::type_id::create("req");
 start_item(req);
   assert(req.randomize() with {
                          MODE==0;CE==1; INP_VALID==2'b10; CMD==c;
                              });
   finish_item(req);end
endtask

task body();
 begin
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0; CE==1; INP_VALID==2'b10; !(CMD inside{6,7,8,9,10,11});
                              });
  c=req.CMD;
  finish_item(req);
  wait_cycles();
  req=seq_item::type_id::create("req");
  start_item(req);
   assert(req.randomize() with {
                          MODE==0;CE==1; INP_VALID==2'b01; CMD==c;
                              });
  finish_item(req);
 end
endtask
endclass

class sequence13 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence13)
 function new(string name="sequence13");
  super.new(name);
 endfunction
 task body();
 repeat(5)
 begin
   req=seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize() with {CE==1 ; CMD>13;  } );
   finish_item(req);
 end
 endtask
endclass

class sequence14 extends uvm_sequence#(seq_item);
 `uvm_object_utils(sequence14)
 function new(string name="sequence14");
  super.new(name);
 endfunction
 task body();
 repeat(5)
 begin
   req=seq_item::type_id::create("req");
   start_item(req);
   assert(req.randomize() with {CE==1 ;MODE==1; CMD==8; OPA==OPB;  } );
   finish_item(req);
 end
 endtask
endclass

