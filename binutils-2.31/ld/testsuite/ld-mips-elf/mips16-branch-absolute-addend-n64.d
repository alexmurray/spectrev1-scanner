#objdump: -dr --prefix-addresses --show-raw-insn
#name: MIPS16 link branch to absolute expression with addend (n64)
#source: ../../../gas/testsuite/gas/mips/mips16-branch-absolute-addend.s
#as: -EB -64 -march=from-abi
#ld: -EB -Ttext 0x12340000 -e foo
#dump: mips16-branch-absolute-addend.d
