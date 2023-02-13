module simple_assertion (
    input   logic signal_in ,   // input signal
    output  logic match     ,   // match signal
    output  logic fail          // fail  signal
);
/*---------------------------------------------
FUNCTION: Determine whether the signal is high or low with Combinational Circuits  (0/1)
---------------------------------------------*/
assign match = signal_in;
assign fail  = (!signal_in);
endmodule