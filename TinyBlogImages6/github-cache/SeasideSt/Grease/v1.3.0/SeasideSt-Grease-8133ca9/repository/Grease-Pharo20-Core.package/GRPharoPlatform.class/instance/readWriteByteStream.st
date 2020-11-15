factory
readWriteByteStream
	"ByteArray based read write stream"
	
	^ ReadWriteStream on: (ByteArray new: 4096)