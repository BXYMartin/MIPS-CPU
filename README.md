# MIPS CPU
Xilinx Project for MIPS Pipeline CPU with 5 stages
![MIPS Pipeline CPU](http://www.evangelopoulos.net/wp-content/uploads/2015/03/qC8uK.jpg)
## Statements
This is a repository maintained for Computer Architecture Studies  
The MIPS CPU supports MIPS-C4 Instruction Set  
MIPS-C4 = {`LB`、`LBU`、`LH`、`LHU`、`LW`、`SB`、`SH`、`SW`、`ADD`、`ADDU`、`SUB`、`SUBU`、`MULT`、`MULTU`、`DIV`、`DIVU`、`SLL`、`SRL`、`SRA`、`SLLV`、`SRLV`、`SRAV`、`AND`、`OR`、`XOR`、`NOR`、`ADDI`、`ADDIU`、`ANDI`、`ORI`、`XORI`、`LUI`、`SLT`、`SLTI`、`SLTIU`、`SLTU`、`BEQ`、`BNE`、`BLEZ`、`BGTZ`、`BLTZ`、`BGEZ`、`J`、`JAL`、`JALR`、`JR`、`MFHI`、`MFLO`、`MTHI`、`MTLO`、`ERET`、`MFC0`、`MTC0`}  

## Details
| Stage | Feature | Folder |
| :-: | :-: | :-: |
| 1 | Supports MIPS-C4 ISA | `Basic CPU` |
| 2 | Supports Pause and Interrupt | `Standard CPU` |
| 3 | Supports MIPS Microsystems | `Advanced CPU` |

## Further Explanations
### Stage 1
* MIPS Instruction Set  
![MIPS ISA](http://images.slideplayer.com/36/10672563/slides/slide_45.jpg)
[Full Instruction Document for MIPS32](https://www.cs.cornell.edu/courses/cs3410/2008fa/MIPS_Vol2.pdf)

* Five Stage Pipeline
![Five Stage Process](https://qph.ec.quoracdn.net/main-qimg-696a7840fbcca52be4681b8396a4d80b)
