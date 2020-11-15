accessing
allCodecs
	"Answer all codecs supported in this system. This is a collection of codec instances."

	^ self subclasses
		inject: self codecs asArray
		into: [ :result :each | result , each allCodecs ]