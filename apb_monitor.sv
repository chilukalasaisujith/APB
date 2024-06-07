`include "apb_base.sv"

class monitor;
base mpkt;
mailbox mon2sb;
virtual apb_if intf;

function new(base mpkt, mailbox mon2sb, virtual apb_if intf);
	this.mpkt=mpkt;
	this.mon2sb=mon2sb;
	this.intf=intf;
endfunction

task mon_run();
begin
#40
@(posedge intf.pclk) 
mpkt.read_data=intf.read_data;
$display("%0t MON intf.read_data=%b,addr=%0b",$time,intf.paddr,intf.read_data);
$display("%0t MON mpkt.read_data=%b",$time,mpkt.read_data);

mon2sb.put(mpkt);
end

endtask
endclass