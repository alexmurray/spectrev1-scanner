
# Makefile for building SPECTRE v1 vulnerability scanner.
#
#   Copyright (c) 2016-2018 Red Hat.
#
#   This is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published
#   by the Free Software Foundation; either version 3, or (at your
#   option) any later version.
#
#   It is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.  */

# Choose the target to build:

# all: x86_64-scanner
# all: aarch64-scanner
all: x86_64-scanner

clean:
	rm -f *.o core.* *-scanner 

# ---- You will need to edit some of the settings below --------------

# Flags:

CFLAGS = -Wall -I.

# If you encounter internal problems with the scanner
# then enabling debugging may help.
CFLAGS += -O3  
# CFLAGS  += -g

# If you are building the tool in a separate directory
# to the sources, then you will need to add a path to
# the scanner.h header file.
CFLAGS += -I .

# The scanner uses some header files that are part of
# the binutils sources, but which are not normally
# distributed with binary packages.  (eg elf/internal.h)
# You can get the binutils sources from:
#   https://ftp.gnu.org/gnu/binutils/
CFLAGS += -I ./../../binutils/build/include -I ./../../binutils/build/bfd

# Building a static version of the scanner makes it easier
# to export to other users, but it can trigger a warning like
# this from the linker:
#   .../libbfd.a(plugin.o): In function `try_load_plugin':
#   warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
# LDFLAGS = -static
LDFLAGS =

# The scanner uses libraries that are distributed as
# part of the binutils.  (Usually the binutils-devel
# package).  You can also build your own set of the
# binutils using the sources you have downloaded and
# just point the LIBS setting below at these.
LIBS = -L ./../../binutils/build/opcodes/ -lopcodes -L ./../../binutils/build/bfd/ -lbfd -L ./../../binutils/build/libiberty -liberty

# The z and dl libraries (from zlib and glibc-static
# respectively) are needed by the bfd library mentioned
# above.
LIBS += -lm -lz -ldl

# The AArch64 scanner also uses a simulator library
# that is part of the GDB package.  You can download
# the GDB sources from here:
#   https://ftp.gnu.org/gnu/gdb/
AARCH64_CFLAGS  = -I /path/to/gdb/source/sim/aarch64
AARCH64_CFLAGS += -I /path/to/gdb/source/sim/common

# Unfortunately the libsim library is not often
# included in a GDB distribution, so you may need to
# build it yourself.
AARCH64_LDFLAGS = -L /path/to/gdb/build/sim/aarch64
AARCH64_LIBS = -lsim

# If you are building on a cross-hosted system you
# will also need the opcodes library specific to the
# AArch64.
AARCH64_LDFLAGS += -L /path/to/gdb/build/opcodes

# In a cross-hosted system it might also be that
# the libiberty library is missing.
AARCH64_LDFLAGS += -L /path/to/gdb/build/libiberty


# ---- You should not need to modify anything below here --------------

HEADERS  = scanner.h

# The AArch64 scanner has overrides for some of the AArch64
# simulator's memory and register access functions.
AARCH64_LDFLAGS += \
		  -Wl,--wrap,aarch64_set_reg_u64 \
		  -Wl,--wrap,aarch64_set_reg_s64 \
		  -Wl,--wrap,aarch64_set_reg_u32 \
		  -Wl,--wrap,aarch64_set_reg_s32 \
		  -Wl,--wrap,aarch64_get_reg_u64 \
		  -Wl,--wrap,aarch64_get_reg_s64 \
		  -Wl,--wrap,aarch64_get_reg_u32 \
		  -Wl,--wrap,aarch64_get_reg_s32 \
		  -Wl,--wrap,aarch64_get_reg_u16 \
		  -Wl,--wrap,aarch64_get_reg_s16 \
		  -Wl,--wrap,aarch64_get_reg_u8 \
		  -Wl,--wrap,aarch64_get_reg_s8 \
		  -Wl,--wrap,aarch64_set_mem_u64 \
		  -Wl,--wrap,aarch64_set_mem_s64 \
		  -Wl,--wrap,aarch64_set_mem_u32 \
		  -Wl,--wrap,aarch64_set_mem_s32 \
		  -Wl,--wrap,aarch64_set_mem_u16 \
		  -Wl,--wrap,aarch64_set_mem_s16 \
		  -Wl,--wrap,aarch64_set_mem_u8  \
		  -Wl,--wrap,aarch64_set_mem_s8  \
		  -Wl,--wrap,aarch64_get_mem_u64 \
		  -Wl,--wrap,aarch64_get_mem_s64 \
		  -Wl,--wrap,aarch64_get_mem_u32 \
		  -Wl,--wrap,aarch64_get_mem_s32 \
		  -Wl,--wrap,aarch64_get_mem_u16 \
		  -Wl,--wrap,aarch64_get_mem_s16 \
		  -Wl,--wrap,aarch64_get_mem_u8  \
		  -Wl,--wrap,aarch64_get_mem_s8  \


# Rules:

scanner.o: scanner.c $(HEADERS)
	gcc -c $< $(CFLAGS)

x86_64-scanner.o: x86_64-scanner.c $(HEADERS)
	gcc -c $< $(CFLAGS)

x86_64-scanner: scanner.o x86_64-scanner.o
	gcc $^ -o $@ $(LDFLAGS) $(LIBS)

aarch64-scanner.o: aarch64-scanner.c $(HEADERS)
	gcc -c $< $(CFLAGS) $(AARCH64_CFLAGS)

aarch64-scanner: scanner.o aarch64-scanner.o
	gcc $^ -o $@ $(LDFLAGS) $(AARCH64_LDFLAGS) $(AARCH64_LIBS) $(LIBS)
