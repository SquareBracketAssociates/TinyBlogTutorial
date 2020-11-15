querying
grPackages
	"Answer a list of all registered packages. A package is registered by adding a class extension to the receiving class answering an instance of the receiving class."

	| packages package |
	packages := Dictionary new.
	self class selectors do: [ :each |
		(each numArgs = 0 and: [ each ~= #grPackages ]) ifTrue: [ 
			package := self perform: each.
			packages at: package name put: package ] ].
	packages do: [ :each | each resolveWith: packages ].
	^ packages values