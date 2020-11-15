factory-currency
swissCurrency
	^ GRSequentialPrinter new , 'CHF ' , GRSignPrinter new , (GRNumberPrinter new
			separator: $';
			precision: 2;
			accuracy: 0.05;
			yourself)