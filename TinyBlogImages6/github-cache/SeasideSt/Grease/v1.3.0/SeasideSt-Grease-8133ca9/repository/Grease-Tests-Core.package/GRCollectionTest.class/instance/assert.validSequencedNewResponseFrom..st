asserting
assert: responseCollection validSequencedNewResponseFrom: receiverCollection
	"Assert that the returned object is, in fact a new object, and that it is
	of a valid response class for the tested collection."
	
	self deny: responseCollection == receiverCollection.
	self assert: (self isValidNewSequencedResponseClass: responseCollection class)