*grease-gemstone200-core
generateHardBreak
	"Generate a GemStone hard break"

	| errorNumber allArgs |
	allArgs := { 'interrupted for Seaside debugging' } .
	errorNumber := self _errorSymbolToNumber: #rtErrHardBreak args: allArgs .
	^System signal: errorNumber args: allArgs signalDictionary: GemStoneError