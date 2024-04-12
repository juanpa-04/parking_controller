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
localparam idle = 7'd1,
	   waiting_pin = 7'd2, // Espera al ingreso del PIN
	   incorrect_pin = 7'd4, // Ingreso incorrecto del PIN
	   pin_alarm = 7'd8, // Activa la alarma de PIN después de 3 intentos
	   car_entering = 7'd16, // Ingreso de pin correcto y se abre compuerta
	   gate_closing = 7'd32, // Vehiculo terminó de ingresar y se cierra compuerta
	   gate_blocking = 7'd64; // Se bloquea puerta porque se activaron los 2 sensores

// Registros de estado, próximo estado, y contador
reg [6:0] state;
reg [6:0] next_state;
reg [1:0] counter = 2'b00;

// Transición de estados con el flanco de reloj
always @(posedge clock) begin
	if (reset) begin 
		state <= idle;
		counter <= 0;
	end else state <=next_state;
end

// Calculo del próximo estado
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
		default: next_state = idle;
	endcase
end

// Asignación de salidas
assign gate_o = (state == car_entering) | (state == gate_blocking);
assign gate_cls = (state == gate_closing);
assign alm_pin = (state == pin_alarm);
assign alm_blkg = (state == gate_blocking);

// Asignación del counter interno
// Para de aumentar el counter cuando llegue a 3
// Cuando se ingrese el pin correcto se limpia el contador
always @(posedge clock) begin
	case (state)
		incorrect_pin: begin
			if (counter != 3) counter <= counter + 1;
		end
		car_entering: begin
			counter <= 0;
		end
	endcase
end

endmodule
