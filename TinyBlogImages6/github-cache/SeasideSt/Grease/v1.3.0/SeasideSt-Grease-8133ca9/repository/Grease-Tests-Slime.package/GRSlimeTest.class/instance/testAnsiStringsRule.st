tests-transform
testAnsiStringsRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'stringCr String cr, (String with: Character cr)' in: class.
	self compile: 'stringTab String tab, (String with: Character tab)' in: class.
	self compile: 'stringLf String lf, (String with: Character lf)' in: class.
	self compile: 'stringCrLf String crlf, (String with: Character cr with: Character lf)' in: class.
	self compile: 'stringSpace String space, (String with: Character space)' in: class.
	self compile: 'findTokens ''123'' findTokens: '',''' in: class.
	self compile: 'findTokensCharacter ''123'' findTokens: $,' in: class.
	self compile: 'findTokensArray ''123'' findTokens: #($, $;)' in: class.
	self compile: 'includesSubString ''1234'' includesSubString: ''23''' in: class.
	self compile: 'includesSubString ''1234'' includesSubstring: ''23''' in: class.
	self 
		runTransformation: GRAnsiStringsRule
		changes: #( 
			'stringCr (String with: Character cr), (String with: Character cr)'
			'stringTab (String with: Character tab), (String with: Character tab)'
			'stringLf (String with: Character lf), (String with: Character lf)'
			'stringCrLf (String with: Character cr with: Character lf), (String with: Character cr with: Character lf)'
			'stringSpace (String with: Character space), (String with: Character space)'
			'findTokens ''123'' subStrings: '','''
			'findTokensCharacter ''123'' subStrings: '',''' 
			'findTokensArray ''123'' subStrings: '',;'''
			'includesSubString (''1234'' indexOfSubCollection: ''23'' startingAt: 0) ~= 0'
			'includesSubString (''1234'' indexOfSubCollection: ''23'' startingAt: 0) ~= 0')