!classDefinition: #LogsTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogsTest
	instanceVariableNames: 'marsRoverCuriosity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:23:22'!
test00MarsRoverNoChangesInPosition

	
	| marsRoverCuriosityPositionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityPositionLog := MarsRoverPositionLog forTracing: marsRoverCuriosity.
	self assert: (marsRoverCuriosityPositionLog show) isEmpty .
	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:27:02'!
test01MarsRoverChangesInPositionWindowTracing

	
	| marsRoverCuriosityPositionWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityPositionWindow := MarsRoverPositionWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'f'.

	self assert: 0@1 equals: (marsRoverCuriosityPositionWindow show).

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:57:35'!
test02MarsRoverChangesInPositionLogTracing

	
	| marsRoverCuriosityPositionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityPositionLog := MarsRoverPositionLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'f'.

	self assert: (OrderedCollection with: (0@1)) equals: marsRoverCuriosityPositionLog show.

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:58:22'!
test03MarsRoverManyChangesInPositionWindowTracing

	
	| marsRoverCuriosityPositionWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityPositionWindow := MarsRoverPositionWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'fff'.
	self assert: 0@3 equals: (marsRoverCuriosityPositionWindow show) .

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:56:29'!
test04MarsRoverManyChangesInPositionLogTracing

	
	| marsRoverCuriosityPositionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityPositionLog := MarsRoverPositionLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'frrllflrb'.
	self assert: (OrderedCollection with: (0@1) with: (0@2)  with: (0@1)) equals: (marsRoverCuriosityPositionLog show) .

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:13:51'!
test05MarsRoverNoChangesInHeadingLog

	
	| marsRoverCuriosityHeadingLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityHeadingLog := MarsRoverHeadingLog forTracing: marsRoverCuriosity.

	self assert: (marsRoverCuriosityHeadingLog show) isEmpty .
	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:19:04'!
test06MarsRoverChangesInHeadingWindowTracing

	
	| marsRoverCuriosityHeadingWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityHeadingWindow := MarsRoverHeadingWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'r'.

	self assert: 'East' equals: (marsRoverCuriosityHeadingWindow show).

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:30:08'!
test07MarsRoverChangesInHeadingLogTracing

	
	| marsRoverCuriosityHeadingLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityHeadingLog := MarsRoverHeadingLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'l'.

	self assert: (OrderedCollection with: 'West') equals: marsRoverCuriosityHeadingLog show.

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:34:37'!
test08MarsRoverManyChangesInHeadingWindowTracing

	
	| marsRoverCuriosityHeadingWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityHeadingWindow := MarsRoverHeadingWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'rr'.
	self assert: 'South' equals: (marsRoverCuriosityHeadingWindow show) .

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:37:03'!
test09MarsRoverManyChangesInHeadingLogTracing

	
	| marsRoverCuriosityHeadingLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityHeadingLog := MarsRoverHeadingLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'rlfl'.
	self assert: (OrderedCollection with: 'East' with: 'North'  with: 'West') equals: (marsRoverCuriosityHeadingLog show) .

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 15:07:30'!
test10MarsRoverNoChangesInGeographicLog

	
	| marsRoverCuriosityDirectionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionLog := MarsRoverGeographicLog forTracing: marsRoverCuriosity.

	self assert: (marsRoverCuriosityDirectionLog show) isEmpty .
	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 15:28:47'!
test11MarsRoverChangesInGeographicWindowTracingPositioning

	
	| marsRoverCuriosityDirectionWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionWindow := MarsRoverGeographicWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'f'.

	self assert: 0@1 equals: (marsRoverCuriosityDirectionWindow show).

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 15:29:10'!
test12MarsRoverChangesInGeographicWindowTracingRotating

	
	| marsRoverCuriosityDirectionWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionWindow := MarsRoverGeographicWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'r'.

	self assert: ('East') equals: (marsRoverCuriosityDirectionWindow show).

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 14:55:10'!
test13MarsRoverChangesInGeographicLogTracingRotating

	
	| marsRoverCuriosityDirectionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionLog := MarsRoverGeographicLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'l'.

	self assert: (OrderedCollection with: 'West') equals: marsRoverCuriosityDirectionLog show.

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 14:55:21'!
test14MarsRoverChangesInGeographicLogTracingPositioning

	
	| marsRoverCuriosityDirectionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionLog := MarsRoverGeographicLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'f'.

	self assert: (OrderedCollection with: 0@1) equals: marsRoverCuriosityDirectionLog show.

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 15:05:27'!
test15MarsRoverManyChangesInGeographicWindowTracing

	
	| marsRoverCuriosityDirectionWindow |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionWindow := MarsRoverGeographicWindow forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'rrflb'.
	self assert: (OrderedCollection with: -1@-1 with: 'East') equals: (marsRoverCuriosityDirectionWindow show) .

	
! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 14:55:40'!
test16MarsRoverManyChangesInGeographicLogTracing

	
	| marsRoverCuriosityDirectionLog |
	marsRoverCuriosity := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	marsRoverCuriosityDirectionLog := MarsRoverGeographicLog forTracing: marsRoverCuriosity.

	marsRoverCuriosity process: 'frlflb'.
	self assert: (OrderedCollection with: (0@1) with: 'East'  with: 'North' with: 0@2 with: 'West' with: 1@2) equals: (marsRoverCuriosityDirectionLog show) .

	
! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observedBy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'AF 6/3/2023 11:29:19'!
initializeAt: aPosition heading: aHeadingType
	position := aPosition.
	head := aHeadingType for: self .
	observedBy := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'AF 6/3/2023 11:41:12'!
rotateLeft
	
	head rotateLeft.
	self changesHaveBeenMade .! !

!MarsRover methodsFor: 'heading' stamp: 'AF 6/3/2023 11:41:22'!
rotateRight
	
	head rotateRight.
	self changesHaveBeenMade.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'observing' stamp: 'AF 6/3/2023 11:31:01'!
addNewObserver: anObserver
	observedBy add: anObserver .! !

!MarsRover methodsFor: 'observing' stamp: 'AF 6/3/2023 11:39:22'!
changesHaveBeenMade
	observedBy do: [:anObserver| anObserver updateObservation].! !


!MarsRover methodsFor: 'moving' stamp: 'AF 6/3/2023 11:40:45'!
moveBackward
	
	head moveBackward.
	self changesHaveBeenMade .! !

!MarsRover methodsFor: 'moving' stamp: 'AF 6/3/2023 11:36:23'!
moveEast
	
	position := position + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'AF 6/3/2023 11:40:58'!
moveForward
	
	head moveForward.
	self changesHaveBeenMade .! !

!MarsRover methodsFor: 'moving' stamp: 'AF 6/3/2023 11:36:37'!
moveNorth
	
	position := position + (0@1).
! !

!MarsRover methodsFor: 'moving' stamp: 'AF 6/3/2023 11:36:44'!
moveSouth
	
	position := position + (0@-1).
! !

!MarsRover methodsFor: 'moving' stamp: 'AF 6/3/2023 11:36:41'!
moveWest
	
	position := position + (-1@0).
! !


!MarsRover methodsFor: 'accesing' stamp: 'AF 6/3/2023 12:18:12'!
heading
^head .! !

!MarsRover methodsFor: 'accesing' stamp: 'AF 6/3/2023 11:34:55'!
position
^position .! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:25:37'!
nameOfHeading
	^'East'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:26:34'!
nameOfHeading
	^'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:26:29'!
nameOfHeading
	^'South'.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:26:25'!
nameOfHeading
	^'West'.! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'marsRoverTracked'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 12:00:33'!
initializeSpecificObserver: aMarsRover
	^self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:31:57'!
initializeTracing: aMarsRover
	marsRoverTracked := aMarsRover .
	self initializeSpecificObserver: aMarsRover .
	aMarsRover addNewObserver: self.! !

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:44:12'!
updateObservation
^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'as yet unclassified' stamp: 'AF 6/3/2023 11:18:01'!
forTracing: aMarsRover
	^(self new) initializeTracing: aMarsRover.! !


!classDefinition: #MarsRoverGeographicLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverGeographicLog
	instanceVariableNames: 'log position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverGeographicLog methodsFor: 'initialization' stamp: 'AF 6/3/2023 14:00:23'!
initializeSpecificObserver: aMarsRover
 	log:= OrderedCollection new.
	position := aMarsRover position .
	heading := aMarsRover heading .! !


!MarsRoverGeographicLog methodsFor: 'updating' stamp: 'AF 6/3/2023 14:37:55'!
actuallyUpdateHeading
	log add: (marsRoverTracked heading nameOfHeading ) .
	heading  := marsRoverTracked heading.! !

!MarsRoverGeographicLog methodsFor: 'updating' stamp: 'AF 6/3/2023 14:37:41'!
actuallyUpdatePosition
	log add: (marsRoverTracked position) .
	position := marsRoverTracked position.! !

!MarsRoverGeographicLog methodsFor: 'updating' stamp: 'AF 6/3/2023 14:01:16'!
updateObservation
	self isHeadingUpdateNecesary ifTrue: [self actuallyUpdateHeading .].
	self isPositionUpdateNecesary ifTrue: [self actuallyUpdatePosition .].! !


!MarsRoverGeographicLog methodsFor: 'checking' stamp: 'AF 6/3/2023 13:59:44'!
isHeadingUpdateNecesary
	^(heading = (marsRoverTracked heading)) not.
	! !

!MarsRoverGeographicLog methodsFor: 'checking' stamp: 'AF 6/3/2023 14:00:02'!
isPositionUpdateNecesary
	^(position = (marsRoverTracked position )) not.
	! !


!MarsRoverGeographicLog methodsFor: 'display' stamp: 'AF 6/3/2023 13:25:33'!
show
^log .! !


!classDefinition: #MarsRoverGeographicWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverGeographicWindow
	instanceVariableNames: 'lastChange heading position hasMovedHead hasMovedPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverGeographicWindow methodsFor: 'initialization' stamp: 'AF 6/3/2023 15:14:32'!
initializeSpecificObserver: aMarsRover
	heading := aMarsRover heading.
	position := aMarsRover position.
	hasMovedHead := false.
	hasMovedPosition := false.
! !


!MarsRoverGeographicWindow methodsFor: 'checking' stamp: 'AF 6/3/2023 15:21:59'!
isHeadingUpdateNecesary
^((marsRoverTracked heading) = heading ) not.! !

!MarsRoverGeographicWindow methodsFor: 'checking' stamp: 'AF 6/3/2023 15:22:19'!
isPositionUpdateNecesary
^((marsRoverTracked position ) = position ) not.! !


!MarsRoverGeographicWindow methodsFor: 'updating' stamp: 'AF 6/3/2023 15:24:58'!
updateObservation

	| currentHeading currentPosition |
	currentHeading := marsRoverTracked heading .
	currentPosition  := marsRoverTracked position .
	(self isHeadingUpdateNecesary) ifTrue: [heading := currentHeading. hasMovedHead := true.] .
	(self isPositionUpdateNecesary )  ifTrue: [position := currentPosition . hasMovedPosition := true.] .! !


!MarsRoverGeographicWindow methodsFor: 'display' stamp: 'AF 6/3/2023 15:28:07'!
show
	(hasMovedHead and: [hasMovedPosition ]) ifTrue: [^self showBoth ].
	(hasMovedHead and: [hasMovedPosition not]) ifTrue: [^self showHeading ].
	((hasMovedHead not) and: [hasMovedPosition ]) ifTrue: [^self showPosition ].
	((hasMovedHead not) and: [hasMovedPosition not]) ifTrue: [^self showNothing ].! !

!MarsRoverGeographicWindow methodsFor: 'display' stamp: 'AF 6/3/2023 15:12:24'!
showBoth
	^OrderedCollection with: position with: heading nameOfHeading.! !

!MarsRoverGeographicWindow methodsFor: 'display' stamp: 'AF 6/3/2023 15:12:59'!
showHeading
	^heading nameOfHeading.! !

!MarsRoverGeographicWindow methodsFor: 'display' stamp: 'AF 6/3/2023 15:28:21'!
showNothing
	^'nada'! !

!MarsRoverGeographicWindow methodsFor: 'display' stamp: 'AF 6/3/2023 15:12:43'!
showPosition
	^position.! !


!classDefinition: #MarsRoverHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverHeadingLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLog methodsFor: 'checking' stamp: 'AF 6/3/2023 13:00:54'!
isUpdateNecesary
	^(log isEmpty) or: [((log last) = (marsRoverTracked heading nameOfHeading )) not].
	! !


!MarsRoverHeadingLog methodsFor: 'updating' stamp: 'AF 6/3/2023 13:00:23'!
actuallyUpdate
	log add: (marsRoverTracked heading nameOfHeading ).! !

!MarsRoverHeadingLog methodsFor: 'updating' stamp: 'AF 6/3/2023 12:58:39'!
updateObservation
	self isUpdateNecesary  ifTrue:  [self actuallyUpdate.]! !


!MarsRoverHeadingLog methodsFor: 'display' stamp: 'AF 6/3/2023 12:09:27'!
show
^log .! !


!MarsRoverHeadingLog methodsFor: 'initialization' stamp: 'AF 6/3/2023 12:09:07'!
initializeSpecificObserver: aMarsRover
 log:= OrderedCollection new.! !


!classDefinition: #MarsRoverHeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverHeadingWindow
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWindow methodsFor: 'initialization' stamp: 'AF 6/3/2023 12:11:12'!
initializeSpecificObserver: aMarsRover
	heading := aMarsRover heading.! !


!MarsRoverHeadingWindow methodsFor: 'display' stamp: 'AF 6/3/2023 12:22:34'!
show
	^heading nameOfHeading.! !


!MarsRoverHeadingWindow methodsFor: 'updating' stamp: 'AF 6/3/2023 12:11:45'!
updateObservation
	heading := marsRoverTracked heading .! !


!classDefinition: #MarsRoverPositionLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverPositionLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLog methodsFor: 'display' stamp: 'AF 6/3/2023 11:23:03'!
show
^log .! !


!MarsRoverPositionLog methodsFor: 'updating' stamp: 'AF 6/3/2023 12:49:01'!
actuallyUpdate
	log add: (marsRoverTracked position).! !

!MarsRoverPositionLog methodsFor: 'updating' stamp: 'AF 6/3/2023 12:52:37'!
updateObservation
	self isUpdateNecesary  ifTrue:  [self actuallyUpdate.]! !


!MarsRoverPositionLog methodsFor: 'checking' stamp: 'AF 6/3/2023 12:55:12'!
isUpdateNecesary
	^(log isEmpty) or: [((log last) = (marsRoverTracked position)) not].
	! !


!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'AF 6/3/2023 11:32:11'!
initializeSpecificObserver: aMarsRover
 log:= OrderedCollection new.! !


!classDefinition: #MarsRoverPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverPositionWindow
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionWindow methodsFor: 'display' stamp: 'AF 6/3/2023 11:25:30'!
show
	^position.! !


!MarsRoverPositionWindow methodsFor: 'updating' stamp: 'AF 6/3/2023 11:45:55'!
updateObservation
	position := marsRoverTracked position .! !


!MarsRoverPositionWindow methodsFor: 'initialization' stamp: 'AF 6/3/2023 11:34:04'!
initializeSpecificObserver: aMarsRover
	position := aMarsRover position.! !
