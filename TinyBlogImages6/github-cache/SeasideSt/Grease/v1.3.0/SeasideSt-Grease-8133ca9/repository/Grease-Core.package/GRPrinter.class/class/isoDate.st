factory-http
isoDate
	"Ansers a printer that formats dates according to ISO(YYYY-MM-DD) E.g. 2003-12-24"

	^ self paddedYear , $- , self paddedMonth , $- , self paddedDay