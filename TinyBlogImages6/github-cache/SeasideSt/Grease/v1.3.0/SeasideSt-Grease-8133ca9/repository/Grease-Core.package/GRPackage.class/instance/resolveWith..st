dependencies
resolveWith: aDictionary
	dependencies := dependencies 
		collect: [ :each |
			aDictionary at: each ifAbsent: [
				"if Foo-Pharo-Bar fails try Foo-Pharo20-Bar and Foo-Pharo30-Bar"
				(each indexOfSubCollection: '-Pharo-' startingAt: 1) ~= 0 ifTrue: [ 
					"try -Pharo20-"
					aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo20-') ifAbsent: [
						"try -Pharo30-"
						aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo30-') ifAbsent: [
							"try -Pharo40-"
							aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo40-') ifAbsent: [
								"try -Pharo50-"
								aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo50-') ifAbsent: [
									"try -Pharo60-"
									aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Pharo60-') ifAbsent: [
										"try -Squeak-"
										aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Squeak-') ifAbsent: [
											"try -Squeak5-"
											aDictionary at: (each copyReplaceAll: '-Pharo-' with: '-Squeak5-') ifAbsent: [
											self error: self name printString , ' depends on unknown package ' , each printString ] ] ] ] ] ] ] ] ] ]