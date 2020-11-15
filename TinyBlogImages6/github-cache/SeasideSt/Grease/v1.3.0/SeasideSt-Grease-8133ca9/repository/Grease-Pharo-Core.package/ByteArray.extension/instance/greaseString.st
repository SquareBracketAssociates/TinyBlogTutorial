*grease-pharo-core
greaseString
	"ByteArrays should not automatically be converted to Strings. You should use a GRCodec for this."
	^ self printString