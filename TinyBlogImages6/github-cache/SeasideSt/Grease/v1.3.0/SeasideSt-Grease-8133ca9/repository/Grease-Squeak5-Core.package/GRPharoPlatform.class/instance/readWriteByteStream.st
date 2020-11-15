factory
readWriteByteStream
	"ByteArray based read write stream"
	
	^ RWBinaryOrTextStream on: (ByteArray new: 4096)