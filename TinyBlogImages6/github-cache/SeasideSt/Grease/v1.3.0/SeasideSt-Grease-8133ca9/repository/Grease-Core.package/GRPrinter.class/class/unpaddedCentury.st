parts-date
unpaddedCentury
	^ GRMappedPrinter 
		block: [ :date | date year \\ 100 ]
		next: GRNumberPrinter new