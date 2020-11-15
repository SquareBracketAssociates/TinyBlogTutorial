private
doSilently: aBlock
	^ SystemAnnouncer uniqueInstance suspendAllWhile:  aBlock