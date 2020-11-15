running-checks
runRule: aClass selectors: aCollection ignoring: aCollectionOfClasses
	self run: aClass ignoring: aCollectionOfClasses do: [ :rule :rules |
		rule result classesAndSelectorsDo: [ :class :selector |
			self
				assert: (aCollection includes: selector)
				description: selector printString , ' should not be reported' ].
		aCollection do: [ :selector |
			self
				assert: (rule result classes
					anySatisfy: [ :class | rule result includesSelector: selector in: class ])
				description: selector printString , ' should be reported' ] ]