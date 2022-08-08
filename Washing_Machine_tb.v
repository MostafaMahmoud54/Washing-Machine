module Washing_Machine_tb;

reg CLK_tb,rst_n_tb;
reg [1:0] CLK_Freq_tb;
reg coin_in_tb;
reg double_wash_tb,timer_pause_tb;
wire wash_done_tb;
wire [2:0] Min_flag_timer_op_tb;
wire [5:0]sec_flag_op_tb;
wire [2:0] state_op_tb;


Washing_Machine w1(
    .CLK(CLK_tb),
    .rst_n(rst_n_tb),
    .CLK_Freq(CLK_Freq_tb),
    .coin_in(coin_in_tb),
    .double_wash(double_wash_tb),
    .timer_pause(timer_pause_tb),
    .wash_done(wash_done_tb),
    .Min_flag_timer_op(Min_flag_timer_op_tb),
    .sec_flag_op(sec_flag_op_tb),
    .state_op(state_op_tb)
);

initial
begin
    CLK_tb=1;
    rst_n_tb=1;
    coin_in_tb=1;
    CLK_Freq_tb=2'b00;
end

always 
#500000 CLK_tb=~CLK_tb;

endmodule