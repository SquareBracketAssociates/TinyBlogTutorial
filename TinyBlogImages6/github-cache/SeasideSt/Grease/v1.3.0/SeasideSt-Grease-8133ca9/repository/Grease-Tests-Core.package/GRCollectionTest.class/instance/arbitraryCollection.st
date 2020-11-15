configuration
arbitraryCollection
	"An general collection for testing. It should meet the needs of #duplicateElement,
	#excludedElement, #includedElement, and so on where appropriate.  Make sure the
	duplicated element doesn't end up being in the first or last position both before
	and after sorting."
	
	^ self collectionClass withAll: #(4 3 1 2 3 5)