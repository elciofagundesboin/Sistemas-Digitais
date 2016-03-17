module led_test(
	//Entradas/Saídas do modulo
	input CLOCK_50,
	output [1:0] LEDG
	);
	//Fim entradas/saidas

	//Registradores armazenam valores até que sejam alterados
	//gnd = constante em 0
	//state = liga/desliga o led
	//counter = vetor até 2^26 para regular o tempo do led
	//reset = inicio do clock
	reg gnd = 1'b0;
	reg state = 1'b0;
	reg [26:0]count = 26'd0;

	//"amarrando" os elementos
	assign LEDG[0] = gnd;
	assign LEDG[1] = state;
	
	//durante a execução
	always @ (posedge CLOCK_50) begin
		if(count == 26'd50000000)
			begin	
				count <= 26'd0; //reseta o count
				state <= ~state; //muda o estado
			end
		else
			begin
				//incrementa count
				count <= count + 1;
			end
	end  

endmodule
