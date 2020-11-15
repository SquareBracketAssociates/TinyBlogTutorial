initialization
initialize
	super initialize.
	self rewriteRule
		replace: '``@collection withIndexDo: [ :`each :`index |  | `@temps | ``@.body ]'
			with: '``@collection keysAndValuesDo: [ :`index :`each |  | `@temps | ``@.body ]';
		replace: '``@collection doWithIndex: [ :`each :`index |  | `@temps | ``@.body ]'
			with: '``@collection keysAndValuesDo: [ :`index :`each |  | `@temps | ``@.body ]';
		replace: '``@collection collect: ``@block1 thenDo: ``@block2'
			with: '(``@collection collect: ``@block1) do: ``@block2';
		replace: '``@collection collect: ``@block1 thenSelect: ``@block2'
			with: '(``@collection collect: ``@block1) select: ``@block2';
		replace: '``@collection pairsDo: [ :`t1 :`t2 | ``@.statements ]'
			with: '1 to: ``@collection size by: 2 do:  [ :index | | `t1 `t2 | `t1 := ``@collection at: index. `t2 := ``@collection at: index + 1. ``@.statements ]';
		replace: '``@collection reject: ``@block1 thenDo: ``@block2'
			with: '(``@collection reject: ``@block1) do: ``@block2';
		replace: '``@collection select: ``@block1 thenCollect: ``@block2'
			with: '(``@collection select: ``@block1) collect: ``@block2';
		replace: '``@collection select: ``@block1 thenDo: ``@block2'
			with: '(``@collection select: ``@block1) do: ``@block2';
		replace: '``@collection detectSum: [ :`t1 | ``@.statements. `.last ]'
			with: '``@collection inject: 0 into: [ :sum :`t1 | ``@.statements. sum + (`.last) ]';
		replace: '``@collection valuesDo: ``@block'
			with: '``@collection do: ``@block';
		replace: '``@collection reversed'
			with: '``@collection reverse';	
		replace: '``@dictionary keysSortedSafely'
			with: '``@dictionary keys asSortedCollection';
		replace: '``@collectionClass new: ``@size withAll: ``@character'
			with: '(``@collectionClass new: ``@size) atAllPut: ``@character'