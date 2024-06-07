`include "apb_env.sv"
`include "apb_configuration.sv"

program test(apb_if inf);
configuration cfg;
env ENV;
initial begin
cfg=new();
cfg.txn_num=5;
ENV=new(cfg,inf);
ENV.env_run();

end
endprogram