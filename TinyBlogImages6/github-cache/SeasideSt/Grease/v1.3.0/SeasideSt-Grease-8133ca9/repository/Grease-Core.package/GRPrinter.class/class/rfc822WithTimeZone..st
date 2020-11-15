factory-http
rfc822WithTimeZone: aString
	"Answers a privter that formats dates according to RFC 822 (email) with the given time zone String. Eg.
	Sun, 31 Aug 2008 19:41:46 <aString>"

	^ self abbreviatedWeekName , ', ' , self paddedDay , Character space , self abbreviatedMonthName , Character space , self paddedYear , Character space , self isoTime , Character space , aString