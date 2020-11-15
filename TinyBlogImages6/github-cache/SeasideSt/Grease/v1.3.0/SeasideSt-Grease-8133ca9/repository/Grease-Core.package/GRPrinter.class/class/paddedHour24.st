parts-time
paddedHour24
	^ GRMappedPrinter 
		block: [ :time | time hour ]
		next: (self numberWithAtLeastDigits: 2)