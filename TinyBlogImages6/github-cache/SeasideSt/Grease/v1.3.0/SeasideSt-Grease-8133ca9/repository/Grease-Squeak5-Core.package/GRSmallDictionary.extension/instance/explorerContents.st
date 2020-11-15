*grease-squeak5-core
explorerContents
	| contents |	
	contents := OrderedCollection new.
	self keysAndValuesDo: [ :key :value |
		contents add: (ObjectExplorerWrapper
			with: value
			name: (key printString contractTo: 32)
			model: self) ].
	^ contents