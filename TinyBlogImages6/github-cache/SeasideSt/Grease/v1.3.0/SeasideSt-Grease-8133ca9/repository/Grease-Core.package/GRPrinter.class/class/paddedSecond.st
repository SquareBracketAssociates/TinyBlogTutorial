parts-time
paddedSecond
	^ GRMappedPrinter 
		block: [ :time | time second ]
		next: (GRNumberPrinter new
				padding: $0;
				digits: 2)