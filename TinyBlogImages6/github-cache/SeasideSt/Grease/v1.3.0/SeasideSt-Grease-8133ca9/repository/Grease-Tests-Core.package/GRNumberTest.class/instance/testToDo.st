tests
testToDo
	| collection |
	collection := OrderedCollection new.
	1 to: 5 do: [ :ea | collection add: ea ].
	self assert: collection asArray = #(1 2 3 4 5).
	
	collection := OrderedCollection new.
	4 to: 4 do: [ :ea | collection add: ea ].
	self assert: collection asArray = #(4).
	
	collection := OrderedCollection new.
	4 to: 4 do: [ :ea | collection add: ea ].
	self assert: collection asArray = #(4).
	
	collection := OrderedCollection new.
	5 to: 4 do: [ :ea | collection add: ea ].
	self assert: collection asArray = #().
	
	collection := OrderedCollection new.
	-3 to: -1.5 do: [ :ea | collection add: ea ].
	self assert: collection asArray = #(-3 -2).
	
	collection := OrderedCollection new.
	1.5 to: 4 do: [ :ea | collection add: ea ].
	self assert: collection asArray = #(1.5 2.5 3.5)