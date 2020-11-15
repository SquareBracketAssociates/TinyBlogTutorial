tests
testCodecUtf8ShortestForm
	"Non shortest form characters should be rejected
	See Corrigendum #1: UTF-8 Shortest Form http://www.unicode.org/versions/corrigendum1.html"
	#('UTF-8' 'utf-8') do: [ :codecName |
		| codec abc |
		codec := GRCodec forEncoding: codecName.
		abc := self asString: #(193 129 193 130 193 131 ).
		self
			should: [ self deny: (codec decode: abc) = 'ABC' ]
			raise: Error ]