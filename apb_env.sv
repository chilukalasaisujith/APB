`include "apb_base.sv"
`include "apb_tx.sv"
//`include "apb_drv.sv"
`include "apb_driver.sv"
`include "apb_monitor.sv"
`include "apb_sb.sv"
`include "apb_configuration.sv"
class env;
base pkt1,pkt2;
mailbox tx2drv,drv2sb,mon2sb;
tx tx;
drv drv;
monitor mon;
sb sb;
configuration cfg;
virtual apb_if intf;

function new(configuration cfg,virtual apb_if intf);

pkt1=new();
pkt2=new();
tx2drv=new();
drv2sb=new();
mon2sb=new();
this.intf=intf;
this.cfg = cfg;
tx=new(pkt1,tx2drv);
drv=new(pkt1,tx2drv,drv2sb,intf);
mon=new(pkt2,mon2sb,intf);
sb=new(pkt1,pkt2,drv2sb,mon2sb);

endfunction

task env_run;
begin
repeat(cfg.txn_num)
fork
	tx.tx_run();
	//drv.drv();
	drv.idle();
	//drv.drv();
	mon.mon_run();
	sb.sb_run();
join
end
endtask
endclass
