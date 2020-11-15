accessing
codecs
	^ (TextConverter allEncodingNames
		select:  [ :each | 
			"exclude UFT-8 which is handled by WAUtf8Codec"
			self supportsEncoding: each ])
		collect: [ :each |
			self basicForEncoding: each greaseString ]