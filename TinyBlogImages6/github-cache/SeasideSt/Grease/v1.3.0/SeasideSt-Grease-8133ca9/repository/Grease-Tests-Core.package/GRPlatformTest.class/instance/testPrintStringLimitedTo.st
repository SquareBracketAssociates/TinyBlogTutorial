tests
testPrintStringLimitedTo

	| longString shortString |
	longString := String streamContents: [ :stream |
		1 to: 1000 do: [ :i | stream nextPutAll: i printString ] ].
	"Squeak implementation adds 9 characters to limited string and VA Smalltalk adds 10, so we can't do an exact count."
	self assert: longString printString size > 65.
	shortString := longString printStringLimitedTo: 50.
	self assert: shortString size < 65