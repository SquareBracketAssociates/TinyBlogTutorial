factory
readWriteCharacterStream
	"String based read write stream"

	^ ReadWriteStream on: (String new: 4096)