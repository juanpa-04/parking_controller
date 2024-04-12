module controller_fsm (
	clock,
	reset,
	pin, // PIN de 8 bits
	senr_e, // Sensor de entrada
	senr_x, // Sensor de entrada completa
	gate_o, // Señal de abrir compuerta
	gate_cls, // Señal de cerrar compuerta
	alm_pin, // Señal de alarma de pin
	alm_blkg // Señal de bloqueo de compuerta
);

input clock, reset, pin, senr_e, senr_x;
output reg gate_o, gate_cls, alm_pin, alm_blkg;

endmodule
