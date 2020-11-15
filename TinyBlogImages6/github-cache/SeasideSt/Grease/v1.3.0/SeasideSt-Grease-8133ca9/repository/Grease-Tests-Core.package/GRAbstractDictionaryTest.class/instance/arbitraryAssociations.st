configuration
arbitraryAssociations
	^ associations ifNil: [ associations := self createArbitraryAssociations ]