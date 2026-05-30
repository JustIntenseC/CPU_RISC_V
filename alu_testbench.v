`timescale 1ns / 1ps  


module alu_tb;

    reg [31:0] a;
    reg [31:0] b;
    reg [3:0] alu_ctrl;
    wire [31:0] result;
    alu test_alu(

        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,alu_tb);
        a = 5; b =4 ; alu_ctrl = 4'b0000;
        #10;
        a = 5 ; b = 4; alu_ctrl = 4'b0001;
        #10;
        $finish;
    end

endmodule;

