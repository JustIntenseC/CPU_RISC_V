module pc(
    input wire clk,
    input wire rst,
    input wire pc_write,
    input wire [31:0] pc_next,
    output reg [31:0] pc_current
);
    always @(posedge clk) begin
        if(rst) begin
            pc_current <= 32'h0000_0000;
        end
        else if(pc_write) begin
            pc_current <= pc_next;
        end
    end
endmodule