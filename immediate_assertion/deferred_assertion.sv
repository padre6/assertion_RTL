module deferred_assertion (
    input   logic   clk         ,   //clock
    input   logic   rst_n       ,   //reset
    input   logic   en          ,   //enable signal from the pervious module's output
    input   logic   signal_in   ,   //input  signal
    output  logic   match       ,   //one of the outputs
    output  logic   fail            //one of the outputs
);
/*-----------------------------------------------
FUNCTION:Determine whether the signal is high or low with Sequential Circuits  (0/1)
-----------------------------------------------*/
logic   match_1 ;
logic   fail_1  ;       
logic   en_1    ;       // Prevents burrs 
always_ff @( posedge clk ) begin
    en_1 <= en;  
    if (signal_in == 1'b1) begin
        match_1 <= 1'b1   ;
        fail_1  <= 1'b0    ;
    end
    else begin
        match_1 <= 1'b0   ;
        fail_1  <= 1'b1   ;
    end
    if (rst_n == 1'b0) begin
        match_1 <= 1'b0;
        fail_1  <= 1'b0;
    end
end
assign match = match_1  &   en_1  ;     //The signal could be kept for a full cycle
assign fail  = ~match             ;     //The signal could be kept for a full cycle
endmodule