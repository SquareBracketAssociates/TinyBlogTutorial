parts-time
unpaddedMinute
	^ GRMappedPrinter 
		block: [ :time | time minute ]
		next: GRNumberPrinter new