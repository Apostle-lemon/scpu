// 头文件，用来定义个寄存器的名字，方便后面的调用
//`ifndef csr_name_H
//`define csr_name_H

// mtvec, mepc, mstatus
parameter mtvec = 12'h305,
          mepc  = 12'h341,
          mstatus = 12'h300,
          mcause = 12'h342;
//`endif