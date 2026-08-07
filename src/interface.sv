`include "defines.svh"
interface inf(input clk, input reset);
  logic [`DW -1:0] OPA,OPB;
  logic CE,MODE,CIN;
  logic [`CW -1:0] CMD;
  logic [1:0] INP_VALID;
  logic [`DW +1:0] RES ;
 logic COUT ;
  logic OFLOW ;
  logic G ;
  logic E;
  logic L ;
  logic ERR ;
clocking drv_cb @(posedge clk);
  default input #1 output #1;
  output OPA,OPB,CE,MODE,CIN,CMD,INP_VALID;
endclocking
clocking inp_mon_cb @(posedge clk);
  default input #1 output #1;
   input  OPA,OPB,CE,MODE,CIN,CMD,INP_VALID;
endclocking
clocking out_mon_cb @(posedge clk);
  default input #1 output #1;
   input RES,COUT,OFLOW,G,E,L,ERR;
endclocking

modport DRV(clocking drv_cb);
modport INP_MON(clocking inp_mon_cb);
modport OUT_MON(clocking out_mon_cb);
endinterface
