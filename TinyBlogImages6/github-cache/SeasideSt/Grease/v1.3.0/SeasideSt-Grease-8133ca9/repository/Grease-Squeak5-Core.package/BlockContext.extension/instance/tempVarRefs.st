*grease-squeak5-core
tempVarRefs
	| method scanner end tempVars byte type offset |
	home ifNil: [ ^ false ].
	tempVars := Set new.
	method := self method.
	"Determine end of block from long jump preceding it"
	end := (method at: startpc - 2) \\ 16 - 4 * 256 + (method at: startpc - 1) + startpc - 1.
	scanner := InstructionStream new method: method pc: startpc.
	[ scanner pc <= end ] whileTrue: [
		byte  := scanner nextByte.
		type := byte // 16.
		offset := byte \\ 16.
		type = 1 ifTrue: [ tempVars add: offset + 1 ].
		scanner nextInstruction ].
	^ tempVars