exceptions
stackDepth

	| i |
	i := 1.
	[(GsProcess _frameContentsAt: i) notNil]
		whileTrue: [i := i + 1].
	^i - 1.