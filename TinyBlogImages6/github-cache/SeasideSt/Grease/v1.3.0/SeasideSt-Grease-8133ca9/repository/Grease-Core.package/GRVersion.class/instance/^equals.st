comparing
= otherVersion
	^ (major = otherVersion major) and: [
		((minor ifNil: [ 0 ]) = (otherVersion minor ifNil: [ 0 ])) and: [
		((revision ifNil: [ 0 ] ) = (otherVersion revision ifNil: [ 0 ])) and: [
		(stageLabel = otherVersion stage) and: [
		(stageNumber ifNil: [ 1 ]) = (otherVersion stageNumber ifNil: [ 1 ]) ] ] ] ]