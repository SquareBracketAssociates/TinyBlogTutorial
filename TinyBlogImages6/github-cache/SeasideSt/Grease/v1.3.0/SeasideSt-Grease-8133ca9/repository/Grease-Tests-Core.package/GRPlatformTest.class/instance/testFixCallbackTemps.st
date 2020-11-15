tests
testFixCallbackTemps
	"Make sure that #fixCallbackTemps is properly understood by block-contexts. Make sure that this is either a nop for Smalltalks with true block closures, or it properly fixes the context otherwise."

	| array blocks values |
	array := #(1 2 3).
	blocks := array collect: [ :each | [ each ] fixCallbackTemps ].
	values := blocks collect: [ :each | each value ].
	self assert: values = array