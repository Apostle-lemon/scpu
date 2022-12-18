module PCSRC1GEN (
    input [31:0] pcsrc1in_inst,
    input [31:0] pcsrc1in_mem_alu_result,
    input [31:0] pcsrc1in_mem_rs1_data,
    input [31:0] pcsrc1in_mem_rs2_data,
    output pc_src1
);

reg pc_src1_reg;

always @(*) begin
    case(pcsrc1in_inst[6:0])
        7'b1100011: // b-type
            case(pcsrc1in_inst[14:12])
                3'b000: // beq
                    pc_src1_reg = pcsrc1in_mem_alu_result == 0;
                3'b001: // bne
                    pc_src1_reg = pcsrc1in_mem_alu_result != 0;
                3'b100: // blt
                    pc_src1_reg = pcsrc1in_mem_alu_result[31];
                3'b101: // bge
                    pc_src1_reg = !pcsrc1in_mem_alu_result[31];
                3'b110: // bltu 进行无符号比较
                    case(pcsrc1in_mem_rs1_data[31])
                        1'b0: 
                            case(pcsrc1in_mem_rs2_data[31])
                                1'b0: // rs1[31] == 0 && rs2[31] == 0
                                    pc_src1_reg = pcsrc1in_mem_rs1_data < pcsrc1in_mem_rs2_data? 1'b1: 1'b0;
                                1'b1: // rs1[31] == 0 && rs2[31] == 1 , rs1 < rs2
                                    pc_src1_reg = 1'b1;
                            endcase
                        1'b1:
                            case(pcsrc1in_mem_rs2_data[31])
                                1'b0: // rs1[31] == 1 && rs2[31] == 0 , rs1 > rs2
                                    pc_src1_reg = 1'b0;
                                1'b1: // rs1[31] == 1 && rs2[31] == 1
                                    pc_src1_reg = pcsrc1in_mem_rs1_data > pcsrc1in_mem_rs2_data? 1'b1: 1'b0;
                            endcase
                    endcase
                3'b111: // bgeu
                    case(pcsrc1in_mem_rs1_data[31])
                        1'b0: 
                            case(pcsrc1in_mem_rs2_data[31])
                                1'b0: // rs1[31] == 0 && rs2[31] == 0, 如果最终结果是一个>=0的数，那么最高位为0，ge 为1
                                    pc_src1_reg = !pcsrc1in_mem_alu_result[31];
                                1'b1: // rs1[31] == 0 && rs2[31] == 1 , rs1 < rs2
                                    pc_src1_reg = 1'b0;
                            endcase
                        1'b1:
                            case(pcsrc1in_mem_rs2_data[31])
                                1'b0: // rs1[31] == 1 && rs2[31] == 0 , rs1 > rs2
                                    pc_src1_reg = 1'b1;
                                1'b1: // rs1[31] == 1 && rs2[31] == 1
                                    pc_src1_reg = !pcsrc1in_mem_alu_result[31];
                            endcase
                    endcase
                default: // other-type
                    pc_src1_reg = 1'b0;
            endcase
        default: // other-type
            pc_src1_reg = 1'b0;
    endcase
end

assign pc_src1 = pc_src1_reg;

endmodule