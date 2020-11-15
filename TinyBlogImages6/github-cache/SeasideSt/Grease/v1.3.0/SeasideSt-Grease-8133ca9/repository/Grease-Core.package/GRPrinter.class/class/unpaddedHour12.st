parts-time
unpaddedHour12
	^ GRMappedPrinter 
		block: [ :time | (time hour - 1) \\ 12 + 1 ]
		next: GRNumberPrinter new