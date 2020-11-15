factory
readWriteByteStream
	"Return a ReadWriteStream on a ByteArray that stores integers 0..255
		^ReadWriteStream on: ByteArray new
	"

	^ self subclassResponsibility