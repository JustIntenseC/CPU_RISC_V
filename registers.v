module reg_file(
    input wire clk,
    input wire rst,
    input wire we,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] wd,
    output wire [31:0] rd1,
    output wire [31:0] rd2
);
    reg [31:0] registers [31:0];
    assign rd1 = (rs1 == 5'b00000) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 5'b00000) ? 32'b0 : registers[rs2];
    always @(posedge clk) begin
        if(rst) begin
            for(integer i = 0; i < 32; i+=1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (we && (rd != 5'b00000)) begin
            registers[rd] <= wd;
        end
    end

endmodule