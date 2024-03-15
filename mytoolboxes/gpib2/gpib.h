#define WIN32

#include <windows.h>
#include "decl-32.h"		/* part of National Instruments GPIB distribution */
#define HUGE
#define ibevent(x,y)	NOSUPPORT
#define ibllo(x)		NOSUPPORT
#define ibsgnl(x,y)		NOSUPPORT

typedef int ITYPE;
