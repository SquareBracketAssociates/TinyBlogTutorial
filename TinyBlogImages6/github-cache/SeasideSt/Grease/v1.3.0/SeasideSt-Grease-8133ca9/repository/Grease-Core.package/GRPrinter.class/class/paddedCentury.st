parts-date
paddedCentury
	^ GRMappedPrinter 
		block: [ :date | date year \\ 100 ]
		next: (self numberWithAtLeastDigits: 2)