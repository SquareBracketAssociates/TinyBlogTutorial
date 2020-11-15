tests
testSymbolAsMutator
	"test for:
	Symbol >> #asMutator
	^ (self copyWith: $:) asSymbol"
	self assert: #name asMutator = #name: