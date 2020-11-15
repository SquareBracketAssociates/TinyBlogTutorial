class initialization
startUp
	generator := self randomClass new.
	mutex := Semaphore forMutualExclusion