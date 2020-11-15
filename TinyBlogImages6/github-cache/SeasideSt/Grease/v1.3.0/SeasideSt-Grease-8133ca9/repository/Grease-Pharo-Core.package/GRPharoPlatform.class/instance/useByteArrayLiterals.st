private-file library
useByteArrayLiterals
	"whether ByteArray literals can/should be used"
	| hasSettings |
	hasSettings := Smalltalk at: #PragmaSetting ifAbsent: [ nil ].
	^ hasSettings isNil
		ifTrue: [
			(Smalltalk at: #Preferences)
				valueOfFlag: #compileUseNewCompiler
				ifAbsent: [ false ] ]
		ifFalse: [ false ]