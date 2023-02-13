module signal_check (
input   logic   clk         ,
input   logic   rst_n       ,
input   logic   en          ,
input   logic   signal_in   ,
output  logic   match       ,
output  logic   fail        
);
/*-----------------------------------------------
FUNCTION: check the signal_in against the clock
-----------------------------------------------*/
logic   output_tri  ; //    the result of the D trigger 
always_ff @(posedge clk ) begin
    output_tri <= signal_in;
    if (rst_n == 1'b0) begin
        output_tri <= 1'b0;
    end
end
assign match = output_tri & en;
assign fail  = ~match         ;
endmodule