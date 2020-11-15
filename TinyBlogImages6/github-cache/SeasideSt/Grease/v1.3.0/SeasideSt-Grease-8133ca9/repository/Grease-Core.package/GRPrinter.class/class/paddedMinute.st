parts-time
paddedMinute
	^ GRMappedPrinter 
		block: [ :time | time minute ]
		next: (self numberWithAtLeastDigits: 2)