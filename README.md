# MIPS CPU
Xilinx Project for MIPS Pipeline CPU with 5 stages
![MIPS Pipeline CPU](http://www.evangelopoulos.net/wp-content/uploads/2015/03/qC8uK.jpg)
___
## Statements
This is a repository maintained for Computer Architecture Studies  
The MIPS CPU supports MIPS-C4 Instruction Set  
MIPS-C4 = {`LB`、`LBU`、`LH`、`LHU`、`LW`、`SB`、`SH`、`SW`、`ADD`、`ADDU`、`SUB`、`SUBU`、`MULT`、`MULTU`、`DIV`、`DIVU`、`SLL`、`SRL`、`SRA`、`SLLV`、`SRLV`、`SRAV`、`AND`、`OR`、`XOR`、`NOR`、`ADDI`、`ADDIU`、`ANDI`、`ORI`、`XORI`、`LUI`、`SLT`、`SLTI`、`SLTIU`、`SLTU`、`BEQ`、`BNE`、`BLEZ`、`BGTZ`、`BLTZ`、`BGEZ`、`J`、`JAL`、`JALR`、`JR`、`MFHI`、`MFLO`、`MTHI`、`MTLO`、`ERET`、`MFC0`、`MTC0`}  

## Details
| Project | Feature | Folder |
| :-: | :-: | :-: |
| 1 | Supports MIPS-C4 ISA | `Basic CPU` |
| 2 | Adds Pause and Interrupt | `Standard CPU` |
| 3 | Supports MIPS Microsystems | `Advanced CPU` |

## Further Explanations
### Project 1
* MIPS Instruction Set  
![MIPS ISA](https://www.cise.ufl.edu/~mssz/CompOrg/Figure2.7-MIPSinstrFmt.gif)  

[Full Instruction Document for MIPS32](https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf)

* Five Stage Pipeline  

![Five Stage Process](https://qph.ec.quoracdn.net/main-qimg-696a7840fbcca52be4681b8396a4d80b)

Designed to be Five-stage Pipeline  

![Guide](https://i.stack.imgur.com/7yPhC.jpg)  

* Fetch Instruction at F-Stage 
* Access Register Files at D-Stage  
* Do Arithmatic at E-Stage  
* Access Memory and Devices at M-Stage
* Write Back to Register File at W-Stage

### Project 2
Adds CoProcessor 0 which handles Pauses and Interrupts  
* Pause
Pause will arise from outside devices such as Timers  
When Pause signal arrives, CP0 Processor will hold & clear the pipeline until Exception Handler Code arrives  
**Memory Mapping**
| Address | Function | R/W |
| :-: | :-: | :-: |
| 0x00000000-0x00003000 | Data Memory | `R``W` |
| 0x00003000-0x00004fff | Instruction Memory | `R` |
| 0x00004fff-0x0000xxxx | Device Space | `R``W?` |

* Interrupt
