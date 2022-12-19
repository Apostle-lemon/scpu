module PC(
    input clk,
    input rst,
    input [31:0] addr,
    input [31:0] cur_inst,
    input [31:0] mtvec_data,
    input [31:0] mepc_data,
    input pc_write,
    input set_pc_to_mepc,
    output [31:0] new_addr
);

// PC 的逻辑是，如果取到的是 btype 或者 jtype 就会保持不变
// 如果取到的是 ecall 指令，九江 pc 的值设置为 mtvec_data (当然，这里可能会有问题)
// 在 mem 阶段将 if 取得的指令设置为 nop 后，取到的指令就不再是 btype 或者 jtype 了
// 而且 pc_write 因为判断的是 nop，因此 pc_write 为 1,即 pc 会加 4

    reg [31:0] addr_reg = 0;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            addr_reg <= 0;
        end else begin
            if(cur_inst[6:0] == 7'b1101111 || cur_inst[6:0] == 7'b1100111 || cur_inst[6:0] == 7'b1100011) begin
                addr_reg <= addr_reg;
            end else if(cur_inst == 32'h73) begin // ecall
                addr_reg <= mtvec_data;
            end else if(cur_inst == 32'hc0001073) begin // unimp
                addr_reg <= mtvec_data;
            end else if(cur_inst == 32'h30200073) begin // mret
                addr_reg <= addr_reg; // 如果当前取到的是 mret，那么就不要改变 pc 的值
            end else if (set_pc_to_mepc) begin // 如果设置了 set_pc_to_mepc，那么就将 pc 设置为 mepc
                addr_reg <= mepc_data;
            end  else if (pc_write) begin
                addr_reg <= addr;
            end else begin
                addr_reg <= addr_reg;
            end
        end
    end
    
    assign new_addr = addr_reg;

endmodule