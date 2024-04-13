module tester (
	clock,
	reset,
	pin,
	senr_e,
	senr_x,
	gate_o,
	gate_cls,
	alm_pin,
	alm_blkg
);

output reg clock, reset, senr_e, senr_x;
output reg [7:0] pin;
input gate_o, gate_cls, alm_pin, alm_blkg;

initial begin
	clock = 0;
	reset = 0;
	senr_e = 0;
	senr_x = 0;
	pin = 0;
	#5 reset = 1;
	#5 reset = 0;

	// Prueba #1
	#10 senr_e = 1;
	#10 pin = 8'd71;
	#10 senr_e = 0;
	#10 senr_x = 1;


end

always begin
	#5 clock = !clock;
end

endmodule
