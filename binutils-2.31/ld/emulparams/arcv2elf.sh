. ${srcdir}/emulparams/arc-endianness.sh
MACHINE=
SCRIPT_NAME=elfarcv2
if [ "x${ARC_ENDIAN}" = "xbig" ]; then
  OUTPUT_FORMAT="elf32-bigarc"
else
  OUTPUT_FORMAT="elf32-littlearc"
fi
ICCM_SIZE=2M
RAM_START_ADDR=0x80000000
RAM_SIZE=2M
STARTUP_MEMORY=ICCM
TEXT_MEMORY=ICCM
DATA_MEMORY=DCCM
SDATA_MEMORY=DCCM
ARCH=arc
MAXPAGESIZE="CONSTANT (MAXPAGESIZE)"
EMBEDDED=yes
GENERIC_BOARD=no
TEMPLATE_NAME=elf32
LITTLE_OUTPUT_FORMAT="elf32-littlearc"
BIG_OUTPUT_FORMAT="elf32-bigarc"
TEXT_START_ADDR=0x100
ENTRY=__start
SDATA_START_SYMBOLS='__SDATA_BEGIN__ = . + 0x100;'
JLI_START_TABLE='__JLI_TABLE__ = .;'
OTHER_SECTIONS="/DISCARD/ : { *(.__arc_profile_*) }"
