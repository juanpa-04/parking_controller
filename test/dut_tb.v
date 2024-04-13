`include "dut.v"
`include "tester.v"

module dut_tb;

	wire clock, reset, senr_e, senr_x,
	     gate_o, gate_cls, alm_pin, alm_blkg;
     	wire [7:0] pin;

	initial begin
		$dumpfile("results.vcd");
		$dumpvars(-1, CONTROLLER);

	end

	controller_fsm CONTROLLER (
		.clock (clock),
		.reset (reset),
		.pin (pin),
		.senr_e (senr_e),
		.senr_x (senr_x),
		.gate_o (gate_o),
		.gate_cls (gate_cls),
		.alm_pin (alm_pin),
		.alm_blkg (alm_blkg)
	);
	
	tester TESTER_CONTROLLER (
		.clock (clock),
		.reset (reset),
		.pin (pin),
		.senr_e (senr_e),
		.senr_x (senr_x),
		.gate_o (gate_o),
		.gate_cls (gate_cls),
		.alm_pin (alm_pin),
		.alm_blkg (alm_blkg)
	);
endmodule
