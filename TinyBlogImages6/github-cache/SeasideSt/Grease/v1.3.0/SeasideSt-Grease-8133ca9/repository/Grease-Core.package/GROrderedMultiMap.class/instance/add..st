accessing
add: anAssociation
	self privateAt: anAssociation key put: anAssociation value.
	^ anAssociation