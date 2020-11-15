tests
testGreaseIntegerOnString
	self assert: '' greaseInteger isNil.
	self assert: 'a' greaseInteger isNil.
	self assert: ' 1' greaseInteger isNil.
	self assert: 'a1' greaseInteger isNil.
	self assert: '-' greaseInteger isNil.
	self assert: '-a' greaseInteger isNil.
	self assert: '0' greaseInteger = 0.
	self assert: '12' greaseInteger = 12.
	self assert: '123' greaseInteger = 123.
	self assert: '123456789' greaseInteger = 123456789.
	self assert: '-0' greaseInteger = 0.
	self assert: '-12' greaseInteger = -12.
	self assert: '-123.4' greaseInteger = -123.
	self assert: '-123456789' greaseInteger = -123456789