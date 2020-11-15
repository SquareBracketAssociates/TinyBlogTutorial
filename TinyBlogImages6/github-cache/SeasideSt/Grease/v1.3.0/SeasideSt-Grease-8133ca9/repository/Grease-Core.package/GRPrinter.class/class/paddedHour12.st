parts-time
paddedHour12
	^ GRMappedPrinter 
		block: [ :time | (time hour - 1) \\ 12 + 1 ]
		next: (self numberWithAtLeastDigits: 2)