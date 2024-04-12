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

// PIN de ingreso al estacionamiento
localparam PIN = 7'd72;

// Estados del controlador (codificación one-hot)
localparam idle = 8'd1,
	   waiting_pin = 8'd2, // Espera al ingreso del PIN
	   car_entering = 8'd4, // Dectecta carro con el sensor de entrada
	   incorrect_pin = 8'd8, // Ingreso incorrecto del PIN
	   pin_alarm = 8'd16, // Activa la alarma de PIN después de 3 intentos
	   car_entering = 8'd32, // Ingreso de pin correcto y se abre compuerta
	   gate_closing = 8'd64, // Vehiculo terminó de ingresar y se cierra compuerta
	   gate_blocking = 8'd128; // Se bloquea puerta porque se activaron los 2 sensores



endmodule
