module FSM(
input rst_n_fsm,clk_fsm,coin_in_fsm,timer_pause_fsm,double_wash_fsm,
input Finished_fsm,
output reg wash_done_fsm,
output [2:0] state_fsm,
output reg start
);

localparam 
    Idle=3'b000,
    Filling_water=3'b001,
    Washing=3'b010,
    Rinsing=3'b011,
    Spinning=3'b100,
    Pause=3'b101;

reg [2:0]next_state,curr_state;
reg double_wash_reg;

assign state_fsm=curr_state;

always @(double_wash_fsm)
double_wash_reg=double_wash_fsm;

always @(negedge rst_n_fsm)
begin
	if(rst_n_fsm==0)
		begin
		next_state=Idle;
		wash_done_fsm=1;
		end
end

always @(posedge clk_fsm)
begin	
	case (curr_state)
        Idle:
        begin
            if (coin_in_fsm==1)
				begin
					wash_done_fsm<=0;
					next_state<=Filling_water;
					start<=1;
				end
        end
		Filling_water:
		begin
			if (Finished_fsm)
				begin
					next_state<=Washing;
                    start<=1;
				end 
		end
		Washing: 
		begin
			if (Finished_fsm)
				begin
					next_state<=Rinsing;
                    start<=1;
				end
		end
		Rinsing: 
		begin
			if (Finished_fsm)
				begin
				if(double_wash_reg==1)
					begin
						next_state<=Washing;
						double_wash_reg<=0;
					end
				else next_state<=Spinning;
                start<=1;
				end
		end
		Spinning:
		begin
			if(timer_pause_fsm)
				begin
					next_state<=Pause;
				end
			else if (Finished_fsm)
				begin
					next_state<=Idle;
					wash_done_fsm<=1;
                	start<=1;
				end
		end
		Pause:
		begin
			if(timer_pause_fsm==0)
				next_state<=Spinning;
		end
		default: next_state<=Idle;
	endcase
end

always @(next_state)
begin
curr_state=next_state;
end

endmodule