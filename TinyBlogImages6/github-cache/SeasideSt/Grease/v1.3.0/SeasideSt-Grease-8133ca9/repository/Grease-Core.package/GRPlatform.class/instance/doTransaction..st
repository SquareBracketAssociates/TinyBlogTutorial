transactions
doTransaction: aBlock
	"for Gemstone/S compatibility
	http://gemstonesoup.wordpress.com/2007/05/10/porting-application-specific-seaside-threads-to-gemstone/
	use when modifying an object from an outside thread"

	^ aBlock value