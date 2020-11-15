parts-time
unpaddedHour24
	^ GRMappedPrinter 
		block: [ :time | time hour ]
		next: GRNumberPrinter new