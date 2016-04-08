module triangle(
	input clk,
	input set,
	input reset,
	input [10:0]ax,
	input [9:0]ay,
	input [10:0]bx,
	input [9:0]by,
	input [10:0]cx,
	input [9:0]cy,
	input [10:0]px,
	input [9:0]py,

	output insideTriangle,
	output read,
	output write
	);
	
	//Control regs
	reg read_r=1;
	reg write_r=0;

	reg signed [18:0]detABC;
	reg signed [18:0]detABP;
	reg signed [18:0]detAPC;
	reg signed [18:0]detPBC;
	reg [18:0]mult1;
	reg [18:0]mult2;
	reg [4:0]state = 4'd0;
	reg insideTriangle_;

	assign insideTriangle = insideTriangle_;
	assign read = read_r;
	assign write = write_r;

	always @(clk) begin

		if (set) begin
			insideTriangle_ <= 1;
		end //if(set)		

		else if (reset) begin
			insideTriangle_ <= 0;
		end //if(rset)		

		else begin
			case(state)
				0:begin //Estado de leitura
				read_r <= 1;
				write_r <= 0;					
				state <= 1;
				end //0
				1:begin
					mult1 <= (ax*by);
					mult2 <= (ay*bx);

				read_r <= 0;
				state <= 2;
				end //1
				2:begin
					mult1 <= (px*cy);
					mult2 <= (py*cx);

					detABC <= mult1 - mult2;
					detABP <= mult1 - mult2;

				state <= 3;
				end //2
				3:begin
					mult1 <= (ay*cx);
					mult2 <= (bx*py);

					detAPC <= mult1 - mult2;
					detPBC <= mult2 - mult1;

				state <= 4;
				end //3
				4:begin
					mult1 <= (bx*cy);
					mult2 <= (ay*px);

					detABC <= detABC + mult1;
					detAPC <= detAPC + mult1;
					detABP <= detABP + mult2;
					detPBC <= detPBC - mult2;

				state <= 5;
				end //4
				5:begin
					mult1 <= (ax*cy);
					mult2 <= (by*px);

					detABC <= detABC + mult1;
					detPBC <= detPBC + mult1;
					detABP <= detABP + mult2;
					detAPC <= detAPC - mult2;

				state <= 6;
				end //5
				6:begin
					mult1 <= (by*cx);
					mult2 <= (ax*py);

					detABC <= detABC - mult1;
					detAPC <= detAPC - mult1;
					detABP <= detABP - mult2;
					detPBC <= detPBC + mult2;

				state <= 7;
				end //6
				7:begin
					detABC <= detABC - mult1;
					detPBC <= detPBC - mult1;
					detABP <= detABP - mult2;
					detAPC <= detAPC + mult2;

				state <= 8;
				end //7
				8:begin
					//Usa somadores para inverter sinais negativos
					if(detABC < 0)
						detABC <= ~detABC + 1;
					if(detABP < 0)
						detABP <= ~detABP + 1;
					if(detAPC < 0)
						detAPC <= ~detAPC + 1;
					if(detPBC < 0)
						detPBC <= ~detPBC + 1;

				state <= 9;
				end //8
				9:begin //Estado de escrita

						if(!detABC)
							insideTriangle_ <= 1'bx;
						else
							insideTriangle_ <= (detABC == detABP + detAPC + detPBC);

				write_r <= 1;
				state <= 0;
				end //9
			endcase //case(state)
		end //else
	end //always @(clk)

endmodule
