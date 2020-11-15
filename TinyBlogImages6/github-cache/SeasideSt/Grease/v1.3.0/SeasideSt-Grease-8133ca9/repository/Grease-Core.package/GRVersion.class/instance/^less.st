comparing
< otherVersion
	(major < otherVersion major) ifTrue: [ ^ true ].
	(otherVersion major < major) ifTrue: [ ^ false ].
	((minor ifNil: [ 0 ]) < (otherVersion minor ifNil: [ 0 ])) ifTrue: [ ^ true ].
	((otherVersion minor ifNil: [ 0 ]) < (minor ifNil: [ 0 ])) ifTrue: [ ^ false ].
	((revision ifNil: [ 0 ]) < (otherVersion revision ifNil: [ 0 ])) ifTrue: [ ^ true ].
	((otherVersion revision ifNil: [ 0 ]) < (revision ifNil: [ 0 ])) ifTrue: [ ^ false ].
	(stageLabel = otherVersion stage) ifTrue: [
		^ ((stageNumber ifNil: [ 1 ]) < (otherVersion stageNumber ifNil: [ 1 ])) ].
	stageLabel isNil ifTrue: [ ^ false ].
	otherVersion stage isNil ifTrue: [ ^ true ].
	^ stageLabel < otherVersion stage
	
	