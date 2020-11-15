accessing
allAt: aKey ifAbsent: absentBlock
	| results |
	results := self allAt: aKey.
	^ results isEmpty
		ifTrue: [ absentBlock value ]
		ifFalse: [ results ]