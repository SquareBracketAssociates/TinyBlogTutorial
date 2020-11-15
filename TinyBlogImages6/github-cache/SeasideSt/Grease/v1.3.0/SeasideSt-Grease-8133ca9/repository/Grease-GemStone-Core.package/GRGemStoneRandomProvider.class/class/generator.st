accessing
generator

	^SessionTemps current 
		at: #GRGemStoneRandomProvider_GENERATOR 
		ifAbsent: [
			SessionTemps current 
				at: #GRGemStoneRandomProvider_GENERATOR
				put: self randomClass new ]