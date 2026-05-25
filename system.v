
// 32 разрядное ариметико-логическое устройство Начало

module adder (
    input wire a,
    input wire b,
    input wire c_in,
    output wire s,
    output wire c_out 
);
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (b & c_in) | (a & c_in);
endmodule


module adder_32bit (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire        c_in,
    output wire [31:0] s,
    output wire       c_out
);

    wire [32:0] carry;        
    assign carry[0] = c_in;

    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : full_adder
            adder bit(
                .a(a[i]),
                .b(b[i]),
                .c_in(carry[i]),
                .s (s[i]),
                .c_out(carry[i+1])
            );
        end
    endgenerate
    assign c_out = carry[32];

endmodule

module alu(

    input wire [31:0] a,           
    input wire [31:0] b,           
    input wire [3:0]  alu_ctrl,    
    output reg [31:0] result,      
    output wire       zero

);

    wire [31:0] add_result;
    wire        adder_cout;
    wire [31:0] b_for_sub;
    wire        cin_for_sub;

    assign b_for_sub   = (alu_ctrl == 4'b0001) ? ~b : b;
    assign cin_for_sub = (alu_ctrl == 4'b0001) ? 1'b1 : 1'b0;

    adder_32bit adder_inst(
            .a(a),
            .b(b_for_sub),
            .c_in(cin_for_sub),
            .s(add_result),
            .c_out(adder_cout)
    );

    always @(*) begin
        case(alu_ctrl)
            4'b0000: result = add_result;     // ADD
            4'b0001: result = add_result;     // SUB
            4'b0010: result = a & b;          // AND
            4'b0011: result = a | b;          // OR
            default: result = 32'b0;
        endcase
    end
    assign zero = (result == 32'b0);
endmodule;

// 32 разрядное ариметико-логическое устройство конец