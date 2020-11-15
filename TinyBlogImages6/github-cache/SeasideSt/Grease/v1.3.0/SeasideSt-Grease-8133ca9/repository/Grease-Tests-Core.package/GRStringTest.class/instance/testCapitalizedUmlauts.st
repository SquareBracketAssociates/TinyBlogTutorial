tests-converting
testCapitalizedUmlauts
	self assert: 'äöü' capitalized = 'Äöü'.
	self assert: 'Äöü' capitalized = 'Äöü'.
	self assert: 'ÄÖÜ' capitalized = 'ÄÖÜ'.
	self assert: #'äöü' capitalized = #'Äöü'.
	self assert: #'Äöü' capitalized = #'Äöü'.
	self assert: #'ÄÖÜ' capitalized = #'ÄÖÜ'