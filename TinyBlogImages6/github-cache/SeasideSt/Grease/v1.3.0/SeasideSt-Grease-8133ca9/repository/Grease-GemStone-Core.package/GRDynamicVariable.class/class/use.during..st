accessing
use: anObject during: aBlock

	| p oldValue result |
	"Proper implementation instead of use 'super value:during:' because that one does not return value, perhaps this should be fixed in DynamicVariable?"
	p := Processor activeProcess.
	oldValue := p environmentAt: self ifAbsent: [self default].
	[
		p environmentAt: self put: anObject.
		result := aBlock value.
	] ensure: [ 
		p environmentAt: self put: oldValue 
	].
	^ result