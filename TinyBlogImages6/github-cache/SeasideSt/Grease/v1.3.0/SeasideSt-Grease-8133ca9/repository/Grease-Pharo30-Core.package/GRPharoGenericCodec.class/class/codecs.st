accessing
codecs
	^ (TextConverter allEncodingNames
		select:  [ :each | 
			"exclude UFT-8 which is handeled by WAUtf8Codec"
			self supportsEncoding: each ])
		collect: [ :each |
			self basicForEncoding: each greaseString ]