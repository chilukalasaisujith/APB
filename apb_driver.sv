`include "apb_base.sv"

class drv;
base pkt;
mailbox tx2drv,gen2drv,drv2sb;
virtual apb_if intf;


function new(base pkt,mailbox tx2drv,gen2drv,drv2sb,virtual apb_if intf);
this.pkt=pkt;
this.tx2drv=tx2drv;
this.gen2drv=gen2drv;
this.drv2sb=drv2sb;
this.intf=intf;
endfunction

task idle();

begin
	wait(intf.preset)
	intf.psel=1'b0;
	intf.penable=1'b0;
	intf.paddr=pkt.addr;
	intf.pwrite=pkt.write;
	intf.pwdata=pkt.data;
end
    setup();
endtask
task setup();
begin
	tx2drv.get(pkt);
	$display("%0t drvget write=%0b,addr=%0b",$time,pkt.write,pkt.addr);
	@(negedge intf.pclk)
	intf.psel=1'b1;
	intf.penable=1'b0;
	intf.paddr=pkt.addr;
        intf.pwdata=pkt.data;
	intf.pwrite=pkt.write;
end
access();
endtask

task access();
begin
	$display("wr in access =%0b",pkt.write);
	@(negedge intf.pclk)
	intf.psel=1'b1;
	intf.penable=1'b1;

	wait(intf.pready)

	$display("wr in access =%0b",intf.pwrite);

	gen2drv.get(pkt);
	@(negedge intf.pclk);
	intf.pwrite=pkt.write;
	drv2sb.try_put(pkt);
	
	@(negedge intf.pclk);
end
endtask
endclass