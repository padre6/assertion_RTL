module intersect(
input   logic   clk,
input   logic   rst_n,
input   logic   en,
input   logic   signal_1,
input   logic   signal_2,
output  logic   match,
output  logic   fail
);
parameter m = 4;
logic   [m:0] en_out;
logic   en_1, en_2, en_3, en_4;
logic   match_0;
assign  out = signal_1 & signal_2;
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
parameter   a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100, f = 3'b101;
logic       [2:0]next_state;
logic       flag_fail_A, flag_fail_B, flag_fail_C, flag_fail_D, flag_fail_E;
always_ff @( posedge clk ) begin : fail_out
    case (next_state)
        a:
        if (en == 1'b1) begin
            if (out == 1'b0) begin
                flag_fail_A <= 1'b1;
            end
            else begin
                flag_fail_A <= 1'b0;
            end
            next_state <= b;
            fail <= 1'b0;
        end 
        else begin
            next_state <= a;
            fail <= 1'b0;
        end
        b:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= c;
            flag_fail_B <= 1'b1;
        end
        else begin
           fail <= 1'b0;
           next_state <= c;
           flag_fail_B <= 1'b0; 
        end
        c:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= d;
            flag_fail_C <= 1'b1;
        end
        else begin
            fail <= 1'b0;
            next_state <= d;
            flag_fail_C <= 1'b0;
        end
        d:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= e;
            flag_fail_D <= 1'b1;       
        end
        else begin
            fail <= 1'b0;
            next_state <= e;
            flag_fail_D <= 1'b0;
        end
        e:
        if (out == 1'b0) begin
            fail <= 1'b0;
            next_state <= f;
            flag_fail_E <= 1'b1;
        end
        else begin
            fail <= 1'b0;
            next_state <= f;
            flag_fail_E <= 1'b0;
        end
        f:  begin
            next_state <= a;
            fail <= flag_fail_B & flag_fail_C & flag_fail_D & flag_fail_E & flag_fail_A;
        end    
    endcase
    if (rst_n == 1'b0) begin
        next_state <= a;
        fail <= 1'b0;
    end
end
endmodule
