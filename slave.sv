module apb_slave(
input pclk,preset,psel,penable,pwrite,
input [3:0] paddr,
input [7:0] pwdata,
output reg [7:0] read_data,
output reg pready);

reg [7:0] mem [0:15];

assign pready=(psel&&penable)?1:0;

always@(posedge pclk)
	begin
		if(preset==0)
		begin
		   read_data=0;
		end		
	     else
		begin
		  if(psel&&penable&&pready)	
			begin
			
		         if(pwrite==1)
				begin
				$display("%0t dut pwrite=%0d",$time,pwrite);
				mem[paddr] <= pwdata;
				$display("%0t dut pwdata=%p",$time,pwdata);
				$display("%0t dut addr=%p",$time,mem[paddr]);
				
				end
			 else
				read_data  <= mem[paddr];
				$display("%0t dut read_data=%p",$time,read_data);
			end
		end
	end
endmodule
/*
module slave_tb;
reg pclk,preset,psel,penable,pwrite;
reg [3:0] paddr;
reg [7:0] pwdata;
wire  [7:0] read_data;
wire  pready;
apb_slave dut(.pclk(pclk),.preset(preset),.psel(psel),.penable(penable),.pwrite(pwrite),.paddr(paddr),.pwdata(pwdata),.pready(pready),.read_data(read_data));

initial
begin
pclk=0;
forever #5 pclk=~pclk;
end

initial
begin
preset=1'b0;
#10
preset=1'b1;
end

initial
begin
#10
psel=1;
penable=1;
pwrite=1'b1;
#10
paddr=4'b1111;
pwdata=16'b1;
#10
paddr=4'b1110;
pwdata=16'b10;

#30
pwrite=1'b0;
paddr=4'b1111;
#10
paddr=4'b1110;

end
endmodule*/
