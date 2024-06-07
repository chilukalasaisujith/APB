`include "apb_if.sv"
`include "slave.sv"
`include "apb_test.sv"

module top();
bit pclk,preset;

apb_if intf(pclk,preset);
apb_slave dut(.pclk(intf.pclk),.preset(intf.preset),.psel(intf.psel),.penable(intf.penable),.pwrite(intf.pwrite),.paddr(intf.paddr),.pwdata(intf.pwdata),.pready(intf.pready),.read_data(intf.read_data));
test tb(intf);

initial
begin
pclk=0;
forever #5 pclk=~pclk;
end

initial
begin
preset=0;
#10
preset=1;
end
endmodule
