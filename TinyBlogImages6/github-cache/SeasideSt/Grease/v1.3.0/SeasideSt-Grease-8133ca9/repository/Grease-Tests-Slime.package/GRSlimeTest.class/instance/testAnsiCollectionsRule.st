tests-transform
testAnsiCollectionsRule
	| class |
	class := self
		defineClass: #GRSlimeMockObject
		superclass: #GRObject.
	self compile: 'withIndexDo #() withIndexDo: [ :each :index | each + index ]' in: class.
	self compile: 'doWithIndex #() doWithIndex: [ :each :index | each + index ]' in: class.
	self compile: 'collectThenDo #() collect: [ :a | a ] thenDo: [ :b | b ]' in: class.
	self compile: 'collectThenSelect #() collect: [ :a | a ] thenSelect: [ :b | true ]' in: class.
	self compile: 'detectSum #(1 2) detectSum: [ :each | each ]' in: class.
	self compile: 'detectSumMultiline #(1 2) detectSum: [ :each | #foo copy. each ]' in: class.
	self compile: 'pairsDo #(1 2 3 4) pairsDo: [ :a :b | b ]' in: class.
	self compile: 'rejectThenDo #() reject: [ :a | true ] thenDo: [ :b | b ]' in: class.
	self compile: 'selectThenCollect #() select: [ :a | true ] thenCollect: [ :b | b ]' in: class.
	self compile: 'selectThenDo #() select: [ :a | true ] thenDo: [ :b | b ]' in: class.
	self compile: 'valuesDo #() valuesDo: [ :a | a ]' in: class.
	self compile: 'reversed #() reversed' in: class.
	self compile: 'keysSortedSafely Dictionary new keysSortedSafely' in: class.
	self compile: 'newWithAll Array new: 4 withAll: $a' in: class.
	self 
		runTransformation: GRAnsiCollectionsRule
		changes: #( 
			'withIndexDo #() keysAndValuesDo: [ :index :each | each + index ]'
			'doWithIndex #() keysAndValuesDo: [ :index :each | each + index ]'
			'collectThenDo (#() collect: [ :a | a ]) do: [ :b | b ]'
			'selectThenDo (#() select: [ :a | true ]) do: [ :b | b ]'
			'rejectThenDo (#() reject: [ :a | true ]) do: [ :b | b ]'
			'selectThenCollect (#() select: [ :a | true ]) collect: [ :b | b ]'
			'pairsDo 1 to: #(1 2 3 4) size by: 2 do: [ :index | | a b | a := #(1 2 3 4) at: index. b := #(1 2 3 4) at: index + 1. b ]'
			'collectThenSelect (#() collect: [ :a | a ]) select: [ :b | true ]'
			'detectSum #(1 2) inject: 0 into: [ :sum :each | sum + each ]'
			'detectSumMultiline #(1 2) inject: 0 into: [ :sum :each | #foo copy. sum + each ]'
			'valuesDo #() do: [ :a | a ]'
			'reversed #() reverse'
			'keysSortedSafely Dictionary new keys asSortedCollection'
			'newWithAll (Array new: 4) atAllPut: $a'
			)