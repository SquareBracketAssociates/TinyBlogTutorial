running
shouldExclude: aContext
	"The REST and OmniBrowser related packages are OK to have pragmas"
	| classCategory |
	classCategory := aContext methodClass theNonMetaClass category.
	^ #(#'-REST-' 'OmniBrowser') anySatisfy: [ :each |
		 (classCategory indexOfSubCollection: each startingAt: 1) ~= 0 ]