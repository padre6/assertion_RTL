module  OR(
input   logic   clk         ,
input   logic   rst_n       ,
input   logic   en          ,
input   logic   signal_1    ,
input   logic   signal_2    ,
output  logic   match       ,
output  logic   fail        
);
/*----------------------------------------
FUNCTION: Logic OR
----------------------------------------*/
parameter m = 4;
logic   [m:0] en_out;
logic   en_1, en_2, en_3, en_4;
logic   match_0;
assign  out = signal_1 | signal_2;
always_ff @( posedge  clk ) begin : en_delay
    en_1 <= en;
    en_2 <= en_1;
    en_3 <= en_2;
    en_4 <= en_3;
end
assign  en_out = en + en_1 + en_2 + en_3 + en_4;
always_ff @( posedge clk ) begin : match_out
    match_0 <= out & en_out;
    match   <= match_0;
    if (rst_n == 1'b0) begin
        match <= 1'b0;
    end
end
parameter   A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
logic       [2:0]next_state;
logic       flag_fail_B, flag_fail_C, flag_fail_D, flag_fail_E, flag_fail_F;
always_ff @( posedge clk ) begin : fail_out
    case (next_state)
        A:
        if (en == 1'b1) begin
            next_state <= B;
            fail <= 1'b0;
        end 
        else begin
            next_state <= A;
            fail <= 1'b0;
        end
        B:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= C;
            flag_fail_B <= 1'b1;
        end
        else begin
           fail <= 1'b0;
           next_state <= C;
           flag_fail_B <= 1'b0; 
        end
        C:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= D;
            flag_fail_C <= 1'b1;
        end
        else begin
            fail <= 1'b0;
            next_state <= D;
            flag_fail_C <= 1'b0;
        end
        D:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= E;
            flag_fail_D <= 1'b1;       
        end
        else begin
            fail <= 1'b0;
            next_state <= E;
            flag_fail_D <= 1'b0;
        end
        E:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= F;
            flag_fail_E <= 1'b1;
        end
        else begin
            fail <= 1'b0;
            next_state <= F;
            flag_fail_E <= 1'b0;
        end
        F:
        if (out == 1'b0) begin
            next_state <= A;
            flag_fail_F <= 1'b1;
            fail <= flag_fail_B & flag_fail_C & flag_fail_D & flag_fail_E & flag_fail_F;
        end
        else begin
            next_state <= A;
            flag_fail_F <= 1'b0;
            fail <= flag_fail_B & flag_fail_C & flag_fail_D & flag_fail_E & flag_fail_F;
        end
    endcase
    if (rst_n == 1'b0) begin
        next_state <= A;
        fail <= 1'b0;
    end
end
endmodule
