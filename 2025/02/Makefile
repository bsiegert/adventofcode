GST=		gst
GST_SUNIT=	gst-sunit


run: day02.st
	${GST} -f day02.st input

run-example: day02.st
	${GST} -f day02.st example

check: day02.st day02-test.st
	${GST_SUNIT} -v  -f day02.st -f day02-test.st Day02Test
	
