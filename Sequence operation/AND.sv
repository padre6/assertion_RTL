module AND (
    input   logic   clk         ,
    input   logic   rst_n       ,
    input   logic   en          ,
    input   logic   signal_1    ,
    input   logic   signal_2    ,
    output  logic   match       ,
    output  logic   fail
);
/*-----------------------------------
FUNCTION: A high level can be continuously output
-----------------------------------*/
parameter   A = 1'b0 , B = 1'b1;
logic       state_next;
always_ff @( posedge clk ) begin : AND
    if (en == 1'b1) begin
        state_next <= A;
    end
    else begin
        state_next <= state_next;
    end
    case (state_next)
        A :
        if (signal_1 && signal_2 == 1'b1) begin
            state_next <= B;
        end  
        else begin
            state_next <= A;
        end
        B: 
        if (signal_1 ==1'b0 && signal_2 == 1'b0) begin
            state_next <= A;
        end
        else begin
            state_next <= B;
        end
        default: state_next <= state_next;
    endcase
    if (rst_n == 1'b0) begin
        state_next <= A;  
    end
end
assign  match = state_next   ;
assign  fail  = ~match       ;
endmodule