#
# Master makefile for Miner source
#
# Makes all the executable by visiting subdirs and making there
#

# The only thing to make is the subdirs
SUBSYSTEMS = lib support includes mem misc fix cfile 2d bios iff div vecmat 3d texmap main

# What to make in the subdirs if nothing specified
SUBTARGETS = optimize no_mono no_debug linstall		#for release
##SUBTARGETS = linstall					#for debugging

# When making clean here, delete libs
CLEAN_TARGS = lib\*.lib

default .PHONY:
	%cd bios
	$(MAKE) $(MFLAGS) linstallh
	%cd ..\misc
	$(MAKE) $(MFLAGS) linstallh
	%cd ..\ui
	$(MAKE) $(MFLAGS) linstallh
	%cd ..\pslib
	$(MAKE) $(MFLAGS) linstallh
	%cd ..
	$(MAKE) $(MFLAGS) lsub
	$(MAKE) $(MFLAGS) bind

bind .PHONY:
	support\gwbind ..\original\descentr.exe main\descentr.exe

#all Miner makefiles should include this
%include $(INIT)\makefile.def
