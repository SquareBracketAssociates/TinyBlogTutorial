parts-date
paddedYear
	^ GRMappedPrinter 
		block: [ :date | date year ]
		next: (self numberWithAtLeastDigits: 4)