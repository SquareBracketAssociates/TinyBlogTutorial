class initialization
initialize
	(Smalltalk hasClassNamed: #UTF8TextConverter) "guard for Squeak 37"
		ifFalse: [ ^ self ].

	Latin1ToUtf8Map := ByteArray new: 256.
	Latin1ToUtf8Encodings := Array new: 256.
	0 to: 255 do:[ :index |
		| latin1 utf8 |
		latin1 := String with: (Character codePoint: index).
		utf8 := latin1 convertToWithConverter: UTF8TextConverter new.
		latin1 = utf8
			ifTrue:[
				Latin1ToUtf8Map at: index + 1 put: 0 ] "no translation needed"
			ifFalse:[
				Latin1ToUtf8Map at: index + 1 put: 1. "no translation needed"
				Latin1ToUtf8Encodings at: index + 1 put: utf8 ] ]