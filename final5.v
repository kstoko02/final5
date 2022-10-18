`timescale 1ns/10ps
module final5(clk,reset,LightA,LightB,HEX,LED);
input clk,reset;
output [2:0] LightA,LightB;
output [0:6]HEX;
output LED;

reg LED;
reg [24:0] counter;
reg [0:6]HEX;
reg[31:0] ccount=32'd0;   
reg[31:0] ncount;
reg[1:0] cs=2'b00;
reg[1:0]ns;
reg[2:0] LightA,LightB;
parameter [1:0] s0=2'b00;
parameter [1:0] s1=2'b01;
parameter [1:0] s2=2'b10;
parameter [1:0] s3=2'b11;

always@(posedge clk or negedge reset)begin
if(!reset)
   begin
      ccount=32'd0;
      cs=2'b00;
   end
else begin  
     ccount<=ncount;
     cs<=ns;
   end
end

always@(*)begin
 case(cs)
  s0: begin
  ncount=(ccount<32'd300000000)?ccount+32'd1:ccount+32'd1;//6 seconds
     ns =(ccount<32'd300000000)?s0:s1;
  end
  s1: begin
    ncount=(ccount<32'd450000000)?ccount+32'd1:32'd0;//3 seconds
     ns =(ccount<32'd450000000)?s1:s2;
 end
  s2: begin
  ncount=(ccount<32'd300000000)?ccount+32'd1:ccount+32'd1;//6 seconds
     ns =(ccount<32'd300000000)?s2:s3;
 end
  s3: begin
  ncount=(ccount<32'd450000000)?ccount+32'd1:32'd0;//3 seconds
     ns =(ccount<32'd450000000)?s3:s0;
  end
 endcase
end

always@(*)begin
   case(ns)
   s0:
   begin
      LightA=3'b001;//A green
      LightB=3'b100;//B red
   end
   s1:
   begin
      LightA=3'b010;//A yellow
      LightB=3'b100;//B red
   end
  s2:
   begin
      LightA=3'b100;//A red
      LightB=3'b001;//B green
   end
  s3:
   begin
      LightA=3'b100;//A red
      LightB=3'b010;//B yellow
   end
  endcase
end

always@(posedge clk) begin
case(ccount)
		0:HEX=7'b0100000;//6
		50000000:HEX=7'b0100100;//5
		100000000:HEX=7'b1001100;//4
		150000000:HEX=7'b0000110;//3
		200000000:HEX=7'b0010010;//2
		250000000:HEX=7'b1001111;//1
		300000000:HEX=7'b0000110;//3
		350000000:HEX=7'b0010010;//2
		400000000:HEX=7'b1001111;//1
 endcase
end

always@(posedge clk)begin
case(cs)
s0:begin
counter<=counter+1;
if(counter==32'd25000000)begin
  LED<=~LED;
  counter<=0;
  end
 end
 s1:begin
counter<=counter+1;
if(counter==32'd2500000)begin
  LED<=~LED;
  counter<=0;
  end
 end
 s2:begin
counter<=counter+1;
if(counter==32'd25000000)begin
  LED<=~LED;
  counter<=0;
  end
 end
 s3:begin
counter<=counter+1;
if(counter==32'd2500000)begin
  LED<=~LED;
  counter<=0;
  end
 end
 endcase
end
endmodule 

 