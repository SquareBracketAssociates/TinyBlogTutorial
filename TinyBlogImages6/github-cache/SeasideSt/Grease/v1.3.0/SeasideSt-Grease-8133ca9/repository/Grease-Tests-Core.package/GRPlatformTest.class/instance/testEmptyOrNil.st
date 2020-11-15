tests
testEmptyOrNil
	self assert: '' isEmptyOrNil.
	self assert: nil isEmptyOrNil.
	self assert: Array new isEmptyOrNil.
	self deny: 'Timberwolf' isEmptyOrNil