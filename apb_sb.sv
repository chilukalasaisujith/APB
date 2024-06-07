`include "apb_base.sv"
class sb;
base pkt1,pkt2;
mailbox drv2sb, mon2sb;

bit[7:0]mem[15:0];


function new(base pkt1, pkt2, mailbox drv2sb, mon2sb);
  this.pkt1=pkt1;
  this.pkt2=pkt2;
  this.drv2sb=drv2sb;
  this.mon2sb=mon2sb;
endfunction 

task ref_run();
begin 
#10
drv2sb.try_get(pkt1);
if(pkt1.write==1)
  begin
    mem[pkt1.addr] = pkt1.data;
  end
#10
drv2sb.try_get(pkt1);
if(pkt1.write==0) 
   begin
     pkt1.exp_read_data = mem[pkt1.addr];
	$display("%t SCOREBOARD pkt1.exp_read_data=%d",$time ,pkt1.exp_read_data);
    end

end
endtask

task sb_run();
begin
ref_run();
mon2sb.get(pkt2);

if(pkt2.read_data==pkt1.exp_read_data)
  $display("%t Matched  pkt2.read_data=%p, pkt1.exp_read_data=%p",$time, pkt2.read_data, pkt1.exp_read_data);
else
$display("%t Not Matched  pkt2.read_data=%p, pkt1.exp_read_data=%p",$time, pkt2.read_data, pkt1.exp_read_data);

end
endtask

endclass





