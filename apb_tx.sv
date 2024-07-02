`include "apb_base.sv"

class tx;
base pkt;
mailbox tx2drv;
function new(base pkt, mailbox tx2drv);
 	this.pkt=pkt;
	this.tx2drv=tx2drv;
endfunction

task tx_run();
	begin
	#10
	pkt.randomize();
	pkt.write=1'b1;
	$display("%0t tx pkt.write=%d",$time,pkt.write);
	$display("%0t tx data=%d",$time,pkt.data);
	$display("%0t tx addr=%d",$time,pkt.addr);
	tx2drv.try_put(pkt);
	$display("%0t txput data=%d",$time,pkt.data);
	$display("%0t txput addr=%d",$time,pkt.addr);
	
	#10
	pkt.write=1'b0;
	$display("%0t tx pkt.write=%d",$time,pkt.write);
	tx2drv.try_put(pkt);
	$display("%0t txput2 addr=%d",$time,pkt.addr);
	
end
endtask
endclass
