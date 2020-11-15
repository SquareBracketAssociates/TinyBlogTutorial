initialization
initialize
	super initialize.
	self rewriteRule
		replace: '`{ :node :context | node isVariable and: [ (Smalltalk includesKey: node name asSymbol) not and: [ context at: ''`receiver'' ifAbsentPut: [ node ]. true ] ] } cr'
			with: '`{ :context | context at: ''`receiver'' } nextPut: Character cr';
		replace: '`{ :node :context | node isVariable and: [ (Smalltalk includesKey: node name asSymbol) not and: [ context at: ''`receiver'' ifAbsentPut: [ node ]. true ] ] } lf'
			with: '`{ :context | context at: ''`receiver'' } nextPut: Character lf';
		replace: '``@stream nextPut: Character cr; nextPut: Character lf'
			with: '``@stream crlf';
		replace: '``@collection writeStream'
			with: 'WriteStream on: ``@collection'