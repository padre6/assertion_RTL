module  OR(
input   logic   signal_in_1,
input   logic   signal_in_2,
output  logic   match      ,
output  logic   fail        
);
/*----------------------------------------
FUNCTION: Logic OR
----------------------------------------*/
assign match = signal_in_1 || signal_in_2;
assign fail  = ~match                    ;
endmodule