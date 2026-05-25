
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

// 32 разрядное ариметико-логическое устройство Конец