*grease-gemstone-core
copyFrom: anObject

	(anObject isKindOf: Dictionary) ifFalse: [
		^super copyFrom: anObject.
	].
	self keysDo: [:each | self removeKey: each].
	anObject keysAndValuesDo: [:key :value | 
		self at: key put: value.
	].