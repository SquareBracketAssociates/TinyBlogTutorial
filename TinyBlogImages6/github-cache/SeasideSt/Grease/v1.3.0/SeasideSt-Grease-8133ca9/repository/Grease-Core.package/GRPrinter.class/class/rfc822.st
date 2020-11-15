factory-http
rfc822
	"Answers a printer that formats dates according to RFC 822 (email). Eg.
	Sun, 31 Aug 2008 19:41:46 +0200"

	^ self abbreviatedWeekName , ', ' , self paddedDay , Character space , self abbreviatedMonthName , Character space , self paddedYear , Character space , self isoTime , Character space , self offsetSign , self absOffsetHoursPadded , self absOffsetMinutesPadded