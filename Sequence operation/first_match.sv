module first_match_1(
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
parameter   A = 1'b0 , B = 1'b1;
logic       state_next;
always_ff @( posedge clk ) begin : first_match_1
    case (state_next)
        A :
        if (en == 1'b1 ) begin
            state_next <= B;
            match      <= 1'b0;
            fail       <= 1'b0;
        end  
        else begin
            state_next <= A;
            match      <= 1'b0;
            fail       <= 1'b0;
        end
        B: 
        if (signal_in == 1'b1) begin
            state_next <= A;
            match      <= 1'b1;
            fail       <= 1'b0;
        end
        else begin
            state_next <= state_next;
            match      <= 1'b0;
            fail       <= 1'b1;
        end
    endcase
    if (rst_n == 1'b0) begin
        state_next <= A;  
    end
end
endmodule
                                                               