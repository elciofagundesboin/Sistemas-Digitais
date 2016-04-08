`include "../t4_triangulo.v"

module top;
	reg [10:0]ax;
	reg [9:0]ay;
	reg [10:0]bx;	
	reg [9:0]by;
	reg [10:0]cx;	
	reg [9:0]cy;
	reg [10:0]px;	
	reg [9:0]py;
	
	//Control regs
	reg clk=0;
	reg set=0;
	reg reset=0;
	integer i;
	
	//Control wires
	wire read;
	wire write;

	wire insideTriangle;

	integer	file_r,file_w,value;
	
	triangle T(clk,set,reset,ax,ay,bx,by,cx,cy,px,py,insideTriangle,read,write);
   
	initial begin
	 	file_r = $fopen("input.dat","r");
	 	file_w = $fopen("output_v.dat","w");
      value = 1;
		clk = 0;
	end

	always #2 begin
		clk <= ~clk;
		if(read && !$feof(file_r)) begin				

			value = $fscanf(file_r, "%d %d %d %d %d %d %d %d\n", px,py,ax,ay,bx,by,cx,cy);

		end //if(read && !$feof(file))
		else if(write) begin
			
			$fwrite(file_w, "%0d %0d %0d %0d %0d %0d %0d %0d = %0d\n", px,py,ax,ay,bx,by,cx,cy,insideTriangle);

		end //if(write)
		else if(read && $feof(file_r)) begin

			$finish;

		end //if($feof(file))		
   end // always #4
endmodule // top
