SRCDIR=./librumpuser
LIBS=${SRCDIR}/librumpuser.a ${SRCDIR}/librumpuser.so ${SRCDIR}/librumpuser.so.0 ${SRCDIR}/librumpuser.so.0.1

RUMPMAKE=${PWD}/obj/tooldir/rumpmake

.PHONY:		all rump rumpuser clean test

default:	all

all:		rump rumpuser

rump:		
		./buildrump.sh/buildrump.sh -k

rumpuser:	rump
		( cd librumpuser && ${RUMPMAKE} && cd .. )
		cp -a ${LIBS} rump/lib/

test:		
		( LD_LIBRARY_PATH=${PWD}/rump/lib cd ljsyscall && luajit test/test.lua && cd .. )

clean:		
		rm -rf rump src obj ${LIBS} *~

