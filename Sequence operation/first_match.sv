module First_match(
input   logic   clk         , 
input   logic   rst_n       ,
input   logic   en          ,
input   logic   signal_in   ,
output  logic   match       ,
output  logic   fail
);
/*-------------------------------------------
FUNCTION: catch the first match
-------------------------------------------*/
parameter   A = 2'b00, B = 2'b01, C = 2'b10;
logic       [1:0]state_next;
logic       [2:0]flag;
logic       match_0;
always_ff @( posedge clk ) begin : AND
    case (state_next)
        A :
        if (en == 1'b1) begin
            if (signal_in == 1'b1) begin
                state_next <= C;
            end
            else begin
                state_next <= B;
            end
            flag <= flag + 3'b001;
            match_0 <= signal_in;
            match <= match_0;
        end  
        else begin
            state_next <= A;
            flag    <= 3'b000;
        end
        B: 
        if (flag < 3'b101) begin
            if (signal_in == 1'b1) begin
                state_next <= C;
                match_0   <= 1'b1;
                match <= match_0;
                flag    <= flag +3'b001;
            end
            else begin
                state_next <= B;
                match_0   <= 1'b0;
                match <= match_0;
                flag    <=flag + 3'b001;
            end
        end
        else  begin
            state_next <= A;
            flag <= 3'b000;
            match_0 <= 1'b0;
            match <= match_0;
        end
        C:
        if (flag < 3'b101) begin
            state_next <= C;
            match_0 <= 1'b0;
            match <= match_0;
            flag <= flag + 3'b001;
        end
        else begin
            state_next <= A;
            flag <= 3'b000;
            match_0 <= 1'b0;
            match <= match_0;
        end
    endcase
    if (rst_n == 1'b0) begin
        state_next <= A;
        flag <= 3'b000;
        match_0 <= 1'b0;
        match <= match_0;  
    end
end
parameter   a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100, f = 3'b101;
logic       [2:0]next_state;
logic       flag_fail_A, flag_fail_B, flag_fail_C, flag_fail_D, flag_fail_E;
always_ff @( posedge clk ) begin : fail_out
    case (next_state)
        a:
        if (en == 1'b1) begin
            if (signal_in == 1'b0) begin
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
        if (signal_in == 1'b0) begin
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
        if (signal_in == 1'b0) begin
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
        if (signal_in == 1'b0) begin
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
        if (signal_in == 1'b0) begin
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
                                                               
