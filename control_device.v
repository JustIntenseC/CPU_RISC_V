module control_device(
    input wire [6:0] opcode,
    output reg       reg_write,    // запись в регистр
    output reg       alu_src,      // 0 = rs2, 1 = immediate
    output reg [3:0] alu_ctrl,     // что делать ALU
    output reg       mem_read,     // читать память
    output reg       mem_write,    // писать в память
    output reg       mem_to_reg,   // 0=ALU, 1=память
    output reg       branch,       // условный переход
    output reg       jump
);

    always @(*) begin
        // Значения по умолчанию
        reg_write  = 0;
        alu_src    = 0;
        alu_ctrl   = 4'b0000;
        mem_read   = 0;
        mem_write  = 0;
        mem_to_reg = 0;
        branch     = 0;
        jump       = 0;

        case (opcode)
            
            // R-type: add, sub, and, or и др.
            7'b0110011: begin
                reg_write = 1;
                alu_src   = 0;       // берём rs2
                alu_ctrl  = 4'b0000; // ADD (пока упрощённо)
            end

            // I-type: addi, andi, ori, lw и т.д.
            7'b0010011: begin        // addi и логические с immediate
                reg_write = 1;
                alu_src   = 1;       // immediate
                alu_ctrl  = 4'b0000; // ADD / ADDI
            end

            // Load: lw
            7'b0000011: begin
                reg_write  = 1;
                alu_src    = 1;
                alu_ctrl   = 4'b0000;
                mem_read   = 1;
                mem_to_reg = 1;
            end

            // Store: sw
            7'b0100011: begin
                alu_src   = 1;
                alu_ctrl  = 4'b0000;
                mem_write = 1;
            end

            // Branch: beq
            7'b1100011: begin
                branch    = 1;
                alu_ctrl  = 4'b0001; // SUB (для сравнения)
            end

            // jal
            7'b1101111: begin
                reg_write = 1;
                jump      = 1;
            end

            default: ;
        endcase
    end
endmodule;