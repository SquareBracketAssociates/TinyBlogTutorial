tests-processes
testTerminate
	| ensureRun ifCurtailedRun semaphore1 semaphore2 semaphore3 semaphore4 process |
	ensureRun := false.
	ifCurtailedRun := false.
	semaphore1 := self platform semaphoreClass new.
	semaphore2 := self platform semaphoreClass new.
	semaphore3 := self platform semaphoreClass new.
	semaphore4 := self platform semaphoreClass new.
	process := [
		[ [ semaphore1 signal. semaphore2 wait ]
			ensure: [ ensureRun := true. semaphore3 signal ] ]
			ifCurtailed: [ ifCurtailedRun := true. semaphore4 signal ] ] newProcess.
	self deny: (self platform isProcessTerminated: process).
	process resume.
	semaphore1 wait.
	self deny: (self platform isProcessTerminated: process).
	self platform terminateProcess: process.
	semaphore3 wait.
	self assert: ensureRun.
	semaphore4 wait.
	self assert: ifCurtailedRun.
	self assert: (self platform isProcessTerminated: process)