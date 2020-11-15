bindings
bindingOf: aClass
	"Answer the binding of aClass.
	The binding is the literal that get compiled into the method.
	We need the binding to be updated when the class is changed.
	The binding has to respond to #value.
	
	This is mostly an issue on GemStone/S because when we hold on
	to a class directly we will end up holding on to an old class version.
	
	Dialects with namespaces will need to override this.
	
	On VisualWorks this should like this
	^ aClass fullyQualifiedReference"
	^ Smalltalk associationAt: aClass name