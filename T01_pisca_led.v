module pisca_led(
	input clock, //informa a entrada clock
	output led  //informa a saída, que no caso é o led
	);
	
	assign led = clock; //"amarra" o led com o clock, assim, quando o clock pisca, o led piscará também

endmodule

module teste_pisca;
	reg clock; //define o clock como registrador
	wire led; //declara led como saída
	
	pisca_led vars(clock, led);
	always #1 clock = ~clock; //inverte o valor do clock a cada 1 intervalo de tempo

	initial begin 
		$dumpvars(0, vars);
		#0
		clock <= 0;
		#100;
		$finish;
	end

endmodule