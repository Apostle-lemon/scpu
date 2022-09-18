module Control(
  input [6:0]  op_code,
  input [2:0]  funct3,
  input funct7_5,
  input zero_wire,

  // Outputs
  output [1:0]pc_src,
  output reg_write,
  output alu_src_b,
  output [3:0]alu_op,
  output [1:0]mem_to_reg,
  output mem_write,
  output branch,
  output b_type
  );

  reg[1:0] pc_src_reg;
  reg reg_write_reg;
  reg alu_src_b_reg;
  reg[3:0] alu_op_reg;
  reg[1:0] mem_to_reg_reg;
  reg mem_write_reg;
  reg branch_reg;
  reg b_type_reg;

  always @* begin
    pc_src_reg = 0;
    reg_write_reg = 0;
    alu_src_b_reg = 0;
    mem_to_reg_reg = 0;
    mem_write_reg = 0;
    branch_reg = 0;
    b_type_reg = 1'b0;

    case (op_code)
        7'b0010011: begin 
          reg_write_reg = 1'b1; 
          alu_src_b_reg = 1'b1;
          alu_op_reg = {1'b0, funct3};
          mem_to_reg_reg = 2'b00; 
          pc_src_reg = 2'b00;
          end
        //lw
        7'b0100011: begin 
          reg_write_reg = 1'b0; 
          alu_src_b_reg = 1'b1;
          alu_op_reg = 4'b0000;
          mem_to_reg_reg = 2'b01; //arbitrary 
          pc_src_reg = 2'b00;
          mem_write_reg = 1'b1;
          end
        //sw
        7'b0000011: begin 
          reg_write_reg = 1'b1; 
          alu_src_b_reg = 1'b1;
          alu_op_reg = 4'b0000;
          mem_to_reg_reg = 2'b11; 
          pc_src_reg = 2'b00;
          end
        // bne, beq
        7'b1100011: begin
          reg_write_reg = 1'b0;
          alu_src_b_reg = 1'b0;
          alu_op_reg = 4'b1000;
          mem_to_reg_reg = 2'b00; //arbitrary
          if(funct3 == 3'b000) begin
            // beq
            b_type_reg = 1'b1;
            if(zero_wire == 1'b0) begin
              pc_src_reg = 2'b00;
            end else begin
              pc_src_reg = 2'b10;
            end
          end
          else begin
            b_type_reg = 1'b0;
            if(zero_wire == 1'b1) begin
              pc_src_reg = 2'b00;
            end else begin
              pc_src_reg = 2'b10;
            end
          end
          end
        // lui
        7'b0110111: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b0;//arbitrary
          alu_op_reg = 4'b0000;//arbitrary
          mem_to_reg_reg = 2'b01; 
          pc_src_reg = 2'b00;
          end
        //jal
        7'b1101111: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b0;//arbitrary
          alu_op_reg = 4'b0000;//arbitrary
          mem_to_reg_reg = 2'b10; 
          pc_src_reg = 2'b10;
          end
        7'b0110011: begin
          reg_write_reg = 1'b1;
          alu_src_b_reg = 1'b0;
          alu_op_reg = {1'b0,funct3};
          mem_to_reg_reg = 2'b00;
          pc_src_reg = 2'b00;
          end
        
        // other instructions
        default: alu_op_reg = 0;
    endcase
end

    assign pc_src = pc_src_reg;
    assign reg_write = reg_write_reg;
    assign alu_src_b = alu_src_b_reg;
    assign alu_op = alu_op_reg;
    assign mem_to_reg = mem_to_reg_reg;
    assign mem_write = mem_write_reg;
    assign branch = branch_reg;
    assign b_type = b_type_reg;
endmodule




