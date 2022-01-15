INCLUDE=z:\home\arne\binwin\watcom\h
export INCLUDE
LIB=z:\home\arne\binwin\watcom\lib
export LIB
#CFLAGS=-dNETWORK=1 -dRELEASE=1 -dNDEBUG=1 -dNMONO=1 -dTACTILE=1
#-ox -oe -ot -on -oa -s -u__NT__
OPT_FLAGS =/ox /oe /ot
CFLAGS_OPT=$(OPT_FLAGS) /5r
CFLAGS_STACK = /s
CFLAGS_INCPATH = -i=fake -i=commlib -i=external -i=div -i=misc -i=mem -i=fix -i=cfile -i=pa_null -i=2d -i=vga -i=bios -i=iff -i=div0 -i=ui -i=vecmat -i=3d -i=texmap -i=includes -i=pslib
CFLAGS_DEBUG=/dNDEBUG=1
CFLAGS_MONO=/dNMONO=""
CFLAGS = /d1 /zq /zld /w3 /on /oa $(CFLAGS_INCPATH) $(CFLAGS_DEBUG) $(CFLAGS_OPT) $(GLOBAL_CFLAGS) $(CFLAGS_STACK) $(CFLAGS_MONO)
CFLAGS += -u__NT__
GLOBAL_INCFILES=main/settings.h
CFLAGS_MAIN = /fi=$(subst /,\\,$(GLOBAL_INCFILES))
AFLAGS_DEBUG = /DNDEBUG /DNMONO
AFLAGS = /c /W3 /Zd /nologo $(AFLAGS_INCPATH) $(AFLAGS_DEBUG) $(GLOBAL_AFLAGS)

main/%.obj: main/%.c
	wcc386 $(CFLAGS) $(CFLAGS_MAIN) -fo=$(subst /,\\,$@) $(subst /,\\,$^)
%.obj: %.c
	wcc386 $(CFLAGS)  -fo=$(subst /,\\,$@) $(subst /,\\,$^)
%.obj: %.asm
	ml $(AFLAGS) /Iincludes /Ifix /Ivecmat /I2d /Idiv /Fo$(subst /,\\,$@) $(subst /,\\,$<)
#%.lib: %.obj
#	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)

all: wineserver main/descentr.exe

wineserver:
	pgrep wineserver>/dev/null||wineserver -p

MISC_OBJS = parsarg.obj error.obj
main/misc.lib: $(patsubst %,misc/%,$(MISC_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
FIX_OBJS = fix.obj
main/fix.lib: $(patsubst %,fix/%,$(FIX_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
CFILE_OBJS = cfile.obj
main/cfile.lib: $(patsubst %,cfile/%,$(CFILE_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
GR_OBJS = linear.obj vesa.obj modex.obj canvas.obj bitmap.obj gr.obj font.obj \
	bitblt.obj scanline.obj pixel.obj poly.obj disc.obj rect.obj box.obj  \
	gpixel.obj palette.obj line.obj lbitblt.obj        \
	scale.obj scalea.obj circle.obj ibitblt.obj rle.obj pcx.obj
main/gr.lib: $(patsubst %,2d/%,$(GR_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
IO_OBJS = key.obj joy.obj mouse.obj timer.obj mono.obj joyc.obj dpmi.obj ipx.obj
main/io.lib: $(patsubst %,bios/%,$(IO_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
IFF_OBJS = iff.obj
main/iff.lib: $(patsubst %,iff/%,$(IFF_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
DIV0_OBJS =  div0.obj
main/div0.lib: $(patsubst %,div/%,$(DIV0_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
MEM_OBJS = mem.obj
main/mem.lib: $(patsubst %,mem/%,$(MEM_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
VECMAT_OBJS = vecmat.obj
main/vecmat.lib: $(patsubst %,vecmat/%,$(VECMAT_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
3D_OBJS = globvars.obj setup.obj matrix.obj points.obj draw.obj clipper.obj \
	horizon.obj instance.obj rod.obj interp.obj
main/3d.lib: $(patsubst %,3d/%,$(3D_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)
TEXMAP_OBJS = 	ntmap.obj tmapflat.obj
TEXMAP_OBJS +=	tmap_per.obj tmap_lin.obj tmap_ll.obj tmap_flt.obj tmapfade.obj tmap_fl1.obj
TEXMAP_OBJS += scanline.obj
main/texmap.lib: $(patsubst %,texmap/%,$(TEXMAP_OBJS))
	wlib -n $(subst /,\\,$@) $(subst /,\\,$^)


DESCENT_LIBS =	3d.lib gr.lib fix.lib io.lib iff.lib vecmat.lib \
		cfile.lib \
		mem.lib \
		div0.lib misc.lib texmap.lib
		#ui.lib \
		#editor.lib
DESCENT_LIBS += ../support/sosdigi.lib ../support/sosmidi.lib \
		../external/commlib.lib ../external/loadpats.lib
		#lzw.lib sosdwxcr.lib sosmwxcr.lib


DESCENT_OBJS = inferno.obj game.obj gauges.obj mglobal.obj \
			 scores.obj object.obj laser.obj physics.obj bm.obj \
			 menu.obj gamesave.obj switch.obj effects.obj texmerge.obj polyobj.obj \
			 gamemine.obj fireball.obj ai.obj aipath.obj hostage.obj \
			 powerup.obj fuelcen.obj digi.obj render.obj hash.obj piggy.obj args.obj \
			 gameseg.obj wall.obj collide.obj lighting.obj \
			 robot.obj morph.obj vclip.obj weapon.obj fvi.obj newdemo.obj titles.obj \
			 vfx.obj vfxread.obj gameseq.obj controls.obj automap.obj text.obj \
			 network.obj victor.obj newmenu.obj netmisc.obj victor.obj\
			 gamefont.obj joydefs.obj hud.obj playsave.obj \
			 endlevel.obj terrain.obj kconfig.obj modem.obj  \
			 multi.obj cntrlcen.obj credits.obj config.obj soscodec.obj kmatrix.obj	\
			 paging.obj mission.obj iglasses.obj songs.obj bmread.obj multibot.obj \
			 state.obj
			 #slew.obj dumpmine.obj
#demo.obj garage.obj radar.obj coindev.obj serial.obj vfxread.obj victor.obj


main/descentr.exe:  $(patsubst %,main/%,$(DESCENT_OBJS)) $(patsubst %,main/%,$(DESCENT_LIBS))
	wcl386 -d1 -k50k -fm=$(subst /,\\,$(patsubst %.exe,%.map,$@)) -fe=$(subst /,\\,$@) -l=dos4g $(subst /,\\,$^)

clean:
	rm -f main/*.lib
	find -name \*.obj -delete

main/vfxread.obj: support/binextr/binextr support/main.def
	support/binextr/binextr -e support/descentr.exe support/main.def
	ml /c /Fomain\\vfxread.obj vfxread.asm

BINEXTR_SRC = binextr.c loadle.c loadmap.c inslen.c
support/binextr/binextr: $(patsubst %,support/binextr/%,$(BINEXTR_SRC))
	$(CC) -g -o $@ -I support/binextr $^

%.lib: %.def
	support/binextr/binextr -e support/descentr.exe $<
	$(MAKE) $(shell awk '/^[a-zA-Z]/{print $$1 ".obj"}' $<)
	rm -f $@
	wlib $(subst /,\\,$@) $(shell awk '/^[a-zA-Z]/{print $$1 ".obj"}' $<)
