encoding
base64Decode: aString
	^ (Base64MimeConverter mimeDecodeToChars: aString readStream) contents