factory-http
rfc1123
	"Answers a printer that formats dates for HTTP1.1 (RFC 1123). Eg.
	Sun, 06 Nov 1994 08:49:37 GMT "
	
	^ GRMappedPrinter 
		block: [ :date | 
			"For the purposes of HTTP, GMT is exactly equal to UTC (Coordinated Universal Time)"
			date asUTC ]
		next: GRSequentialPrinter new , self abbreviatedWeekName , ', ' , self paddedDay , Character space , self abbreviatedMonthName , Character space , self paddedYear , Character space , self isoTime , ' GMT'