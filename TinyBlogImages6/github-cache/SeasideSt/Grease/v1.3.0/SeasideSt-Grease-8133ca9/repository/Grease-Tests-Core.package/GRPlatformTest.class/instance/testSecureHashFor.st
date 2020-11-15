tests
testSecureHashFor
	"Make sure the platform class provides a #secureHashFor: method. The method is called by Seaside when hashing passwords. The Squeak implementation returns a SHA-1 hash but another equivalent hash method could also be used."
	
	| a b |
	a := self platform secureHashFor: 'foobar'.
	b := self platform secureHashFor: 'foobar'.
	
	self assert: (a = b)