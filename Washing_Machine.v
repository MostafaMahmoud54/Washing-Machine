module Washing_Machine(
input CLK,rst_n,
input [1:0] CLK_Freq,
input coin_in,
input double_wash,timer_pause,
output wash_done,
output [2:0] Min_flag_timer_op,
output [5:0]sec_flag_op,
output [2:0]state_op
);
wire [2:0] state;
wire start_;
wire Finished_;
assign state_op=state;

timer t1(
    .clk_timer(CLK),
    .state_timer(state),
    .clk_freq_timer(CLK_Freq),
    .Min_flag_timer(Min_flag_timer_op),
    .sec_flag(sec_flag_op),
    .Finished(Finished_),
    .start_timer(start_)
);

FSM f1(
    .rst_n_fsm(rst_n),
    .clk_fsm(CLK),
    .coin_in_fsm(coin_in),
    .timer_pause_fsm(timer_pause),
    .double_wash_fsm(double_wash),
    .Finished_fsm(Finished_),
    .wash_done_fsm(wash_done),
    .state_fsm(state),
    .start(start_)
);

endmodule