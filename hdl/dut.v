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

input wire clock, reset, pin, senr_e, senr_x;
output wire gate_o, gate_cls, alm_pin, alm_blkg;

// PIN de ingreso al estacionamiento
localparam PIN = 7'd72;

// Estados del controlador (codificación one-hot)
localparam idle = 8'd1,
	   waiting_pin = 8'd2, // Espera al ingreso del PIN
	   incorrect_pin = 8'd4, // Ingreso incorrecto del PIN
	   pin_alarm = 8'd8, // Activa la alarma de PIN después de 3 intentos
	   car_entering = 8'd16, // Ingreso de pin correcto y se abre compuerta
	   gate_closing = 8'd32, // Vehiculo terminó de ingresar y se cierra compuerta
	   gate_blocking = 8'd64; // Se bloquea puerta porque se activaron los 2 sensores

reg [6:0] state;
reg [6:0] next_state;

reg [1:0] counter;


// Transición de estados con el flanco de reloj
always @(posedge clock) begin
	if (reset) state <= idle;
	else state <=next_state;
end

// Calculo del proximo estado

always @(*) begin
	next_state = state;
	case (state) 
		idle: begin
			if(senr_e) next_state = waiting_pin;
		end
		waiting_pin: begin
			if(pin == PIN) next_state = car_entering;
			else next_state = incorrect_pin;
		end
		car_entering: begin
			if(senr_e & senr_x) next_state = gate_blocking;
			else if(senr_x) next_state = gate_closing;
		end
		incorrect_pin: begin
			if(counter == 3) next_state = pin_alarm;
			else if(pin == PIN) next_state = car_entering;
		end
		pin_alarm: begin
			if(pin == PIN) next_state = car_entering;
		end
		gate_closing: begin
			next_state = idle;
		end
		gate_blocking: begin
			if(pin == PIN) next_state = gate_closing;
		end
	endcase
end




endmodule



