module fell (
    input   logic   clk         ,       //clock
    input   logic   rst_n       ,       //reset
    input   logic   en          ,       //enable signal
    input   logic   signal_in   ,       //input signal
    output  logic   match       ,       //match signal
    output  logic   fail                //fail signal
);
/*-------------------------------------------------------------
FUNCTION:Get the result of rose
-------------------------------------------------------------*/    
logic   delay_in_1  ;
logic   delay_in_2  ;
logic   en_1        ;
logic   en_2        ;   
always_ff @( posedge clk ) begin : rose_SV
        delay_in_1 <= signal_in ;
        delay_in_2 <= delay_in_1;
        en_1 <= en;
        en_2 <= en_1;
    if (rst_n == 1'b0) begin                //reset operation
        delay_in_1 <= 1'b0  ;
        delay_in_2 <= 1'b0  ;
    end
end
assign match = (delay_in_2 & ~delay_in_1) & en_2 ;
assign fail  = ~match;
endmodule