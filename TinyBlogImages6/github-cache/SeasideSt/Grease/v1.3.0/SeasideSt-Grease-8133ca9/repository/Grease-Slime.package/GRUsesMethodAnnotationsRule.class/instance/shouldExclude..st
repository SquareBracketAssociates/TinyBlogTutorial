running
shouldExclude: aContext
	"The REST and OmniBrowser related packages are OK to have pragmas"
	| classCategory |
	classCategory := aContext selectedClass theNonMetaClass category.
	^ #(#'-REST-' 'OmniBrowser') anySatisfy: [ :each |
		 (classCategory indexOfSubCollection: each startingAt: 1) ~= 0 ]