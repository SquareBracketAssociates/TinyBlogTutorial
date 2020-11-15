parts-date
weekName: anArray 
	^ GRPluggablePrinter on: [ :date | anArray at: date dayOfWeek ]