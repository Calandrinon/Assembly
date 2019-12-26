#!/bin/sh

wine ../nasm/nasm.exe -fobj week12.asm
wine ../nasm/nasm.exe -fobj longest_common_prefix.asm
wine ../nasm/ALINK.EXE week12.obj longest_common_prefix.obj -oPE -subsys console -entry start
