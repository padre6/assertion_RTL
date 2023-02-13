module intersect(
input   logic   signal_1  ,
input   logic   signal_2  ,
output  logic   match     ,
output  logic   fail         
);
/*-------------------------------------------
FUNCTION: Logic AND
-------------------------------------------*/
assign  match = signal_1 && signal_2 ;
assign  fail  = ~match               ;
endmodule