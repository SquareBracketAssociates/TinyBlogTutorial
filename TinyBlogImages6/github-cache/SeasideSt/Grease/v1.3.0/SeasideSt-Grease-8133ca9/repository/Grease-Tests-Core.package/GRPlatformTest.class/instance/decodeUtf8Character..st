private
decodeUtf8Character: aCollectionOfIntegers 
	"Decodes a collection of bytes into a single character. We have this so we can avoid having non-ASCII characters in the source."
	| codec toDecode decoded |
	codec := GRCodec forEncoding: 'utf-8'.
	toDecode := aCollectionOfIntegers asByteArray.
	decoded := codec decode: toDecode.
	self assert: decoded size = 1.
	^ decoded first