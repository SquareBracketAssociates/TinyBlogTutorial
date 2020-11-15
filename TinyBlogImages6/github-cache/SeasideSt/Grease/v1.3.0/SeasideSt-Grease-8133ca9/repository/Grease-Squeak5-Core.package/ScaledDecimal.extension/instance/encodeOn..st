*grease-squeak5-core
encodeOn: aDocument
	"not the ideal package but we don't have a Seaside-Squeak-Core"
	| converter |
	converter := GRSignPrinter new, (GRNumberPrinter new precision: self scale).
	converter print: self on: aDocument