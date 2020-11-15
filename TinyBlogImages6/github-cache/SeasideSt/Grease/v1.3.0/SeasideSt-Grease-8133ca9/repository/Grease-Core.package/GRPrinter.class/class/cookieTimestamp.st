factory-http
cookieTimestamp
	"Netscape's original proposal defined an Expires header that took a date value in a fixed-length variant format in place of Max-Age: Wdy, DD-Mon-YY HH:MM:SS GMT"

	^ GRMappedPrinter
		block: [ :timestamp | timestamp asUTC ]
		next: self abbreviatedWeekName , ', ' , self paddedDay , '-' , self abbreviatedMonthName , '-' , self paddedYear , ' ' , self isoTime , ' GMT'