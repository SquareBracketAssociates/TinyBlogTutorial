parts-date
unpaddedYear
	^ GRMappedPrinter 
		block: [ :date | date year ]
		next: GRNumberPrinter new