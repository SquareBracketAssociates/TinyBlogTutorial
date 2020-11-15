factory-currency
usCurrency
	^ GRSignPrinter new , $$ , (GRNumberPrinter new
			separator: $,;
			precision: 2;
			yourself)