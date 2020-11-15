tests
testError
	"Make sure #error: signals a subclass of GRError."
	self 
		should: [ GRObject new error: 'oh dear' ]
		raise: GRError.
	self 
		should: [ GRObject error: 'oh dear' ]
		raise: GRError