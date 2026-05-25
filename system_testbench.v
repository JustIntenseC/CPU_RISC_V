`timescale 1ns / 1ps  

module adder_32bit_tb;

    reg [31:0] a;
    reg [31:0] b;
    reg c_in;
    wire [31:0] s;
    wire c_out;
    adder_32bit uut (
        .a(a),
        .b(b),
        .c_in(c_in),
        .s(s),
        .c_out(c_out)
    );

    initial begin
        $dumpfile("wave.vcd"); 
        $dumpvars(0, adder_32bit_tb);
        a = 32;   b = 28;   c_in = 0; 
        #10;                        
        a = 10;   b = 10;   c_in = 0; 
        #10;
        a = 15;  b = 20;   c_in = 0; 
        #10;
        $finish; 
    end

endmodule



