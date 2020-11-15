tests-packages
testPackages
	| packages |
	packages := GRPackage grPackages.
	self assert: packages notEmpty.
	packages do: [ :each | 
		self assert: each name notEmpty.
		self assert: each license notNil.
		self assert: each url notNil ]