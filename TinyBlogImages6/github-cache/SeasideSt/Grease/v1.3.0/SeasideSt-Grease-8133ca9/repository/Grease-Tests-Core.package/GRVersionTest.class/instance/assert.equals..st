asserting
assert: aVersionArray equals: bVersionArray
	| a b |
	a := self buildVersion: aVersionArray.
	b := self buildVersion: bVersionArray.
	self deny: a < b.
	self assert: a <= b.
	self deny: b < a.
	self assert: b <= a.
	self deny: b > a.
	self assert: b >= a.
	self deny: a > b.
	self assert: a >= b.
	self assert: a = b