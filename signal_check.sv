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
logic   output_0    ;
logic   output_1    ;   // delay one clock
logic   en_0        ;
logic   en_1        ;    // delay one clock
always_ff @(posedge clk ) begin
    output_0 <= signal_in;
    output_1 <= output_0;
    en_0 <= en;
    en_1 <= en_0;
    if (rst_n == 1'b0) begin
        output_1 <= 1'b0;
    end
end
assign match = output_1 & en_1  ;
assign fail  = ~output_1 & en_1  ;
endmodule
