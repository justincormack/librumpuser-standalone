SRCDIR=./librumpuser
LIBS=${SRCDIR}/librumpuser.a ${SRCDIR}/librumpuser.so ${SRCDIR}/librumpuser.so.0 ${SRCDIR}/librumpuser.so.0.1

RUMPMAKE=${PWD}/obj/tooldir/rumpmake

.PHONY:		all rump rumpuser clean test

default:	all

all:		rump rumpuser

rump:		
		./buildrump.sh/buildrump.sh -k -qq

rumpuser:	rump
		cp librumpuser/rumpuser_component.h rump/include/rump/
		( export CPPFLAGS=-DRUMPUSER_CONFIG=yes; \
		  cd librumpuser && ./configure && ${RUMPMAKE} )
		cp -a ${LIBS} rump/lib/

test:		
		( export LD_LIBRARY_PATH=${PWD}/rump/lib; cd ljsyscall && luajit test/test.lua rump )

clean:		
		rm -rf rump src obj ${LIBS} *~ \
		librumpuser/*.o librumpuser/*.a librumpuser/*.pico librumpuser/*.map librumpuser/*.cat3 \
		librumpuser/config.log librumpuser/config.status librumpuser/rumpuser_config.h


