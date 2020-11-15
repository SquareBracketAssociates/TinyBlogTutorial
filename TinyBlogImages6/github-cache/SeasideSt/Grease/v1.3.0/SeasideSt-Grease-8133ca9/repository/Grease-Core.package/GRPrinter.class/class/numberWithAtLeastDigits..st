parts-units
numberWithAtLeastDigits: anInteger
	^ GRNumberPrinter new
		padding: $0;
		digits: anInteger;
		yourself