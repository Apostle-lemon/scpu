module CONTROL(
  input [6:0]  op_code,
  input [2:0]  funct3,
  input funct7_5,

  // Outputs
  output [4:0] id_ex,
  output [2:0] id_m,
  output [2:0] id_wb
  );

  reg reg_write_reg;
  reg alu_src_b_reg;
  reg[3:0] alu_op_reg;
  reg[1:0] mem_to_reg_reg;
  reg mem_write_reg;
  reg branch_reg;
  reg b_type_reg;

  always @* begin
    reg_write_reg = 0;
    alu_src_b_reg = 0;
    mem_to_reg_reg = 0;
    mem_write_reg = 0;
    branch_reg = 0;
    b_type_reg = 1'b0;

    case (op_code)
        //ADDI
        7'b0010011: begin 
          reg_write_reg = 1'b1; 
          alu_src_b_reg = 1'b1;
          alu_op_reg = {1'b0, funct3};
          mem_to_reg_reg = 2'b00; 
          end
        //lw
        7'b0100011: begin 
          reg_write_reg = 1'b0; 
          alu_src_b_reg = 1'b1;
          alu_op_reg = 4'b0000;
          mem_to_reg_reg = 2'b01; //arbitrary 
          mem_write_reg = 1'b1;
          end
        //sw
        7'b0000011: begin 
          reg_write_reg = 1'b1; 
          alu_src_b_reg = 1'b1;
          alu_op_reg = 4'b0000;
          mem_to_reg_reg = 2'b11; 
          end
        // bne, beq
        7'b1100011: begin
          branch_reg = 1'b1;
          reg_write_reg = 1'b0;
          alu_src_b_reg = 1'b0;
          alu_op_reg = 4'b1000;
          mem_to_reg_reg = 2'b00; //arbitrary
          if(funct3 == 3'b000) begin
            // beq
            b_type_reg = 1'b1;
          end
          else begin
            b_type_reg = 1'b0;
          end
          end
        // lui
        7'b0110111: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b1;//from imm
          alu_op_reg = 4'b0000;//arbitrary
          mem_to_reg_reg = 2'b01; 
          end
        //jal
        7'b1101111: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b0;//arbitrary
          alu_op_reg = 4'b0000;//arbitrary
          mem_to_reg_reg = 2'b10; 
          end
        //jalr
        7'b1100111: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b1;
          alu_op_reg = 4'b0000;//arbitrary
          mem_to_reg_reg = 2'b10; 
          end
        7'b0110011: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b0;
          alu_op_reg = {1'b0,funct3};
          mem_to_reg_reg = 2'b00;
          end
        // auipc
        7'b0010111: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b1;//from imm
          alu_op_reg = 4'b0000;//arbitrary
          mem_to_reg_reg = 2'b00;// from alu_result
          end
        // other instructions
        default: alu_op_reg = 0;
    endcase
end

    assign id_ex = {alu_src_b_reg, alu_op_reg};
    assign id_m = {branch_reg, b_type_reg, mem_write_reg};
    assign id_wb = {reg_write_reg, mem_to_reg_reg};

endmodule




