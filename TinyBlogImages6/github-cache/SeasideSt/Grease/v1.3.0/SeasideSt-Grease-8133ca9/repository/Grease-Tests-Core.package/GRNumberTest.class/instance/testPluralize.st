tests
testPluralize
	self assert: (0 pluralize: 'person') = '0 people'.
	self assert: (1 pluralize: 'person') = '1 person'.
	self assert: (2 pluralize: 'person') = '2 people'.
	self assert: (3 pluralize: 'person') = '3 people'.
	
	self assert: (0 pluralize: 'penis') = '0 penises'.
	self assert: (1 pluralize: 'penis') = '1 penis'.
	self assert: (2 pluralize: 'penis') = '2 penises'.
	
	self assert: (0 pluralize: 'person' with: 'members') = '0 members'.
	self assert: (1 pluralize: 'person' with: 'members') = '1 person'.
	self assert: (2 pluralize: 'person' with: 'members') = '2 members'.
	self assert: (3 pluralize: 'person' with: 'members') = '3 members'