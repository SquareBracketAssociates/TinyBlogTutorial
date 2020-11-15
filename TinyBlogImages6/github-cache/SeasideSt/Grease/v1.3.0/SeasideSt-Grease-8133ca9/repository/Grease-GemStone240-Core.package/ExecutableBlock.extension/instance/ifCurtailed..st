*grease-gemStone240-core
ifCurtailed: aBlock

	| wasCurtailed |
	wasCurtailed := true.
	[
		self value.
		wasCurtailed := false.
	] ensure: [
		wasCurtailed ifTrue: aBlock.
	].