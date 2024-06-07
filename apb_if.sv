interface apb_if(input pclk,preset);
logic [7:0]read_data;
logic [3:0]paddr;
logic [7:0]pwdata;
logic pwrite;
logic psel,penable,pready;

////modport dut(input pclk,preset,paddr,pwdata,pwrite,psel,penable,pready, output read_data);
//modport tb(input pclk,read_data, output preset,paddr,pwdata,pwrite,psel,penable,pready);

endinterface