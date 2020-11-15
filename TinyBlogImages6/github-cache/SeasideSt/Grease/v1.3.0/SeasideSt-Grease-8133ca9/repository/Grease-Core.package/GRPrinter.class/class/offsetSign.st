parts-date
offsetSign
	^ GRMappedPrinter 
		block: [ :date | date offset ]
		next: (GRSignPrinter new
				positivePrinter: $+;
				negativePrinter: $-;
				yourself)