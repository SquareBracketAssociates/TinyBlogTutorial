parts-date
absOffsetHoursPadded
	^ GRMappedPrinter 
		block: [ :date | date offset hours abs ]
		next: (self numberWithAtLeastDigits: 2)