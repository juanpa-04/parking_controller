module tester (
	clock,
	reset,
	pin,
	senr_e,
	senr_x,
	gate_o,
	gate_cls,
	alm_pin,
	alm_blkg,
	ent_pin
);

output reg clock, reset, senr_e, senr_x, ent_pin;
output reg [7:0] pin;
input gate_o, gate_cls, alm_pin, alm_blkg;

always #5 clock = !clock;

initial begin
	clock = 0;
	reset = 0;
	senr_e = 0;
	senr_x = 0;
	pin = 0;
	ent_pin = 0;
	#5 reset = 1;
	#5 reset = 0;

	// Prueba #1
	#10 senr_e = 1;
	
	// Ingreso de Pin correcto 
	#10 pin = 8'd72;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	#10 senr_e = 0;
	#10 senr_x = 1;
	#10 senr_x = 0;
	
	// Prueba #2
	
	#20 senr_e = 1;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd74;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd22;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de pin correcto 
	#10 pin = 8'd72;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	#10 senr_e = 0;
	#10 senr_x = 1;
	#10 senr_x = 0;
	
	// Prueba #3
	#20 senr_e = 1;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd74;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd22;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd36;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd42;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de pin correcto 
	#10 pin = 8'd72;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	#10 senr_e = 0;
	#10 senr_x = 1;
	#10 senr_x = 0;
	
	// Prueba #4
	#10 senr_e = 1;
	
	// Ingreso de Pin correcto 
	#10 pin = 8'd72;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Se bloquea compuerta
	#10 senr_x = 1;
	
	// Ingreso de Pin incorrecto 
	#10 pin = 8'd22;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	
	// Ingreso de Pin correcto 
	#10 pin = 8'd72;
	#5 ent_pin = 1;
	#5 ent_pin = 0;
	#10 senr_x = 0;
	
	
	#30 $finish;
end

endmodule
