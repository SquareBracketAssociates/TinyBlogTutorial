private
assertEncodingIgnoresLanguageTat: aStringWithLanguageTag
	| codec withLanguageTag withoutLanguageTag |
	codec := GRCodec forEncoding: 'utf-8'.
	withLanguageTag := codec encode: aStringWithLanguageTag.
	withoutLanguageTag := codec encode: (self stripLeadingCharFrom: aStringWithLanguageTag).
	self assert: withLanguageTag = withoutLanguageTag