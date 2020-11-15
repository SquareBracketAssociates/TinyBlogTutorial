exceptions
stackDepth

	| depth current |
	depth := 0.
	current := thisContext.
	[ current isNil ] whileFalse: [
		current := current sender.
		depth := depth + 1 ].
	^ depth - 1