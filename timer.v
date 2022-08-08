module timer(
input clk_timer,start_timer,
input [2:0] state_timer,
input [1:0]clk_freq_timer,
output [2:0] Min_flag_timer,
output [5:0]sec_flag,
output reg Finished
);

reg [31:0]ticks=1;
reg [23:0]value;
reg [5:0]sec_flag_reg=0;
reg [2:0]Min_flag_timer_reg=0;
reg [2:0]Min_count=0;

assign sec_flag=sec_flag_reg;
assign Min_flag_timer=Min_flag_timer_reg;

localparam	
	freq_1=2'b00,
	freq_2=2'b01,
	freq_4=2'b10,
	freq_8=2'b11;

//states
localparam 
	Idle=3'b000,
	Filling_water=3'b001,
    Washing=3'b010,
    Rinsing=3'b011,
    Spinning=3'b100,
    Pause=3'b101;
	
always @(clk_freq_timer)
begin
	case(clk_freq_timer)
		freq_1:value=1000000;
		freq_2:value=2000000;
		freq_4:value=4000000;
		freq_8:value=8000000;
	endcase
end

always @(state_timer)
begin
	case(state_timer)
		Idle: 
			begin
				Min_count=3'b000;
			end
		Filling_water: 
			begin
				Min_count=3'b001;
			end
    	Washing: 
			begin
				Min_count=3'b001;
			end
   	 	Rinsing: 
			begin
				Min_count=3'b001;
			end
    	Spinning: 
			begin
				Min_count=3'b001;
			end
    	Pause: 
			begin
				Min_count=3'b000;
			end
	endcase
end

always@(posedge clk_timer)
begin
if(start_timer)
begin
    Finished<=0;
end
if((state_timer != Pause) && (state_timer != Idle) && (~Finished))
begin
	ticks <= ticks+1;
	if(ticks==value)
	begin
		sec_flag_reg<=sec_flag_reg+1;
		ticks<=1;
	end
	if(sec_flag_reg==59)
	begin
		Min_flag_timer_reg<=Min_flag_timer_reg+1;
		sec_flag_reg<=0;
	end
	if(Min_flag_timer_reg == Min_count)
	begin
		Min_flag_timer_reg<=0;
		Finished<=1;
	end
end
end
endmodule

