!classDefinition: #DenotativeObjectTestResultWindow category: #'DenotativeObject-TestSupport'!
TestResultWindow subclass: #DenotativeObjectTestResultWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

!DenotativeObjectTestResultWindow methodsFor: 'actions' stamp: 'HAW 7/14/2017 20:19:56'!
debug

	model selection ifNotNil: [ :selection | | test |
		test := DenotativeObjectTestCase for: selection compiledMethod.
		test debug.
		testResult removeFromDefectsAndAddToPassed: test.
		model removeMessageFromBrowserKeepingLabel.
		self setLabel: testResult printString ]! !

!DenotativeObjectTestResultWindow methodsFor: 'actions' stamp: 'HAW 7/14/2017 20:21:21'!
runSuite

	| suite |

	suite := TestSuite new.
	suite addTests: testResult tests.
	self delete.
	(DenotativeObjectProgessiveTestRunner for: suite) value.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DenotativeObjectTestResultWindow class' category: #'DenotativeObject-TestSupport'!
DenotativeObjectTestResultWindow class
	instanceVariableNames: ''!

!DenotativeObjectTestResultWindow class methodsFor: 'instance creation' stamp: 'HAW 7/14/2017 20:03:44'!
methodReferencesOf: tests

	^tests collect: [:aTest | aTest asMethodReference]! !


!classDefinition: #DenotativeObjectProgessiveTestRunner category: #'DenotativeObject-TestSupport'!
ProgessiveTestRunner subclass: #DenotativeObjectProgessiveTestRunner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

!DenotativeObjectProgessiveTestRunner methodsFor: 'show result - private' stamp: 'HAW 7/14/2017 19:58:26'!
openTestResultWindow

	DenotativeObjectTestResultWindow openFor: testResult
	! !


!classDefinition: #DenotativeObjectTestCase category: #'DenotativeObject-TestSupport'!
TestCase subclass: #DenotativeObjectTestCase
	instanceVariableNames: 'testMethod realTest realTestSelector denotativeObject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

!DenotativeObjectTestCase methodsFor: 'converting' stamp: 'HAW 9/10/2017 19:02:44'!
asMethodReference

	^ (MethodReference class: denotativeObject class selector: realTestSelector)
		recalculateStringVersionForDenotativeObject;
		yourself.! !


!DenotativeObjectTestCase methodsFor: 'running' stamp: 'HAW 7/29/2017 19:31:00'!
debug

	| debugger |
	
	debugger := nil.

	[ self setUpResources.

	[self runCase] ensure: [self tearDownResources]]
		on: Error
		do: [ :anError |
				self inform: anError printString.
				(debugger notNil and: [ debugger inStep ])
					ifTrue: [ anError pass ]
					ifFalse: [
						| activeProcess toDebugContext  |

						debugger notNil ifTrue: [ debugger triggerEvent: #closeViews ].

						activeProcess := Processor activeProcess.
						debugger := DenotativeObjectDebugger new.
						toDebugContext := thisContext.
						[toDebugContext notNil and: [(toDebugContext receiver isKindOf: DenotativeObject class) not] ] whileTrue: [ toDebugContext := toDebugContext sender ].
						toDebugContext isNil 
							ifTrue: [ anError pass ]
							ifFalse: [
								debugger process: activeProcess context: toDebugContext.
								debugger openFullNoSuspendLabel: anError printString.
								activeProcess suspend ]	
						] ]
! !

!DenotativeObjectTestCase methodsFor: 'running' stamp: 'HAW 7/19/2017 21:51:34'!
debugAsFailureIfCanNot: handler

	self ifCanNotDebugDo: [ ^handler value].

	self runCaseAsFailure! !


!DenotativeObjectTestCase methodsFor: 'accessing' stamp: 'HAW 9/10/2017 19:02:28'!
denotativeObject

	^ denotativeObject.! !

!DenotativeObjectTestCase methodsFor: 'accessing' stamp: 'HAW 9/10/2017 19:02:16'!
methodForTest

	^ denotativeObject class lookupSelector: realTestSelector.! !

!DenotativeObjectTestCase methodsFor: 'accessing' stamp: 'HAW 9/10/2017 19:02:25'!
realTest: aCompiledMethod

	denotativeObject := aCompiledMethod methodClass soleInstance.
	realTestSelector := aCompiledMethod selector.! !

!DenotativeObjectTestCase methodsFor: 'accessing' stamp: 'HAW 7/14/2017 20:18:46'!
realTestSelector

	^realTestSelector ! !


!DenotativeObjectTestCase methodsFor: 'initialization' stamp: 'HAW 9/10/2017 19:02:11'!
initializeFor: aClass test: aMethod

	denotativeObject := aClass.
	testMethod := aMethod.! !


!DenotativeObjectTestCase methodsFor: 'testing' stamp: 'HAW 9/10/2017 19:02:31'!
isSameAs: aTestCase

	^ denotativeObject = aTestCase denotativeObject and: [ realTestSelector = aTestCase realTestSelector ].! !


!DenotativeObjectTestCase methodsFor: 'private' stamp: 'HAW 7/29/2017 10:54:56'!
openDebuggerOnFailingTestMethod

	| processToDebug context compiledMethod debugger |

	compiledMethod := self methodForTest.

	processToDebug := [ [ self performTest ] ensure: [
		self tearDown.
		self tearDownResources.
		debugger sendProceeds. ]] newProcess.
	context := processToDebug suspendedContext.

	debugger := DenotativeObjectDebugger new
		process: processToDebug
		context: context.
	debugger openFullNoSuspendLabel: 'Debug failed test ', self printString.

	[debugger interruptedContext method == compiledMethod] whileFalse: [debugger originalSend].
! !


!DenotativeObjectTestCase methodsFor: 'exceptions' stamp: 'HAW 7/29/2017 19:30:14'!
signalFailure: aString

	failureString _ aString.
	Error signal: aString 
	! !


!DenotativeObjectTestCase methodsFor: 'test execution' stamp: 'HAW 9/10/2017 19:02:00'!
test

	[ denotativeObject perform: realTestSelector ]
		on: MessageNotUnderstood
		do: [ :aMNU |
			(aMNU receiver = denotativeObject and: [ self respondsTo: aMNU message selector ])
				ifTrue: [ aMNU message sendTo: self ]
				ifFalse: [ aMNU pass ]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DenotativeObjectTestCase class' category: #'DenotativeObject-TestSupport'!
DenotativeObjectTestCase class
	instanceVariableNames: ''!

!DenotativeObjectTestCase class methodsFor: 'instance creation' stamp: 'HAW 7/14/2017 08:37:01'!
for: aCompiledMethod

	| test |

	test := super selector: #test.
	test realTest: aCompiledMethod.

	^test! !

!DenotativeObjectTestCase class methodsFor: 'instance creation' stamp: 'HAW 7/14/2017 08:20:40'!
for: aClass test: aMethod

	^self new initializeFor: aClass test: aMethod
! !


!classDefinition: #Assert category: #'DenotativeObject-TestSupport'!
DenotativeObject subclass: #Assert
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Assert class' category: #'DenotativeObject-TestSupport'!
Assert class
	instanceVariableNames: ''!

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 10:11:52'!
comparingStringBetween: actual and: expected

	^ String streamContents: [:stream |
		stream
			nextPutAll: 'Expected ';
			nextPutAll: (expected printStringLimitedTo: 50);
			nextPutAll: ' but was ';
			nextPutAll: (actual printStringLimitedTo: 50);
			nextPutAll: '.'
		]! !

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 09:43:49'!
defaultAssertionFailedDescription
	
	^'Assertion failed'! !

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 10:26:44'!
defaultIdenticalFailureDescription
	
	^'Objects are not identical'! !

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 10:18:43'!
defaultNotEqualsFaillureDescription
	
	^'Expected to be different but they are equal'! !

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 10:31:30'!
defaultNotIdenticalFailureDescription
	
	^'Expected to be not identical but they are identical'! !

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 10:50:21'!
failDescription
	
	^'Failed'! !

!Assert class methodsFor: 'descriptions' stamp: 'HAW 7/30/2017 11:11:36'!
shouldNotSignalFailureDescription
	
	^'Exception was signal when not expected to'! !


!Assert class methodsFor: 'boolean assertions' stamp: 'HAW 7/30/2017 10:49:36'!
fail
	
	self isTrue: false description: self failDescription! !

!Assert class methodsFor: 'boolean assertions' stamp: 'HAW 7/30/2017 09:45:59'!
isFalse: aBooleanOrBlock

	^self isFalse: aBooleanOrBlock description: self defaultAssertionFailedDescription ! !

!Assert class methodsFor: 'boolean assertions' stamp: 'HAW 7/30/2017 09:45:28'!
isFalse: aBooleanOrBlock description: aFailureDescription

	self isTrue: aBooleanOrBlock value not description: aFailureDescription ! !

!Assert class methodsFor: 'boolean assertions' stamp: 'HAW 7/30/2017 09:43:41'!
isTrue: aBooleanOrBlock

	self isTrue: aBooleanOrBlock description: self defaultAssertionFailedDescription
! !

!Assert class methodsFor: 'boolean assertions' stamp: 'HAW 7/30/2017 09:42:57'!
isTrue: aBooleanOrBlock description: aFailureDescription
 
	aBooleanOrBlock value ifFalse: [ self signalFailure: aFailureDescription ]
! !


!Assert class methodsFor: 'expected exception assertions' stamp: 'HAW 7/30/2017 11:16:31'!
should: aBlockClosure signal: anExceptionHandlingCondition withDescription: exceptionDescription

	self should: aBlockClosure signal: anExceptionHandlingCondition withDescription: exceptionDescription asserting: [:anException | ]! !

!Assert class methodsFor: 'expected exception assertions' stamp: 'HAW 7/30/2017 11:03:21'!
should: aBlockClosure signal: anExceptionHandlingCondition withDescription: exceptionDescription asserting: assertionsBlock

	| signaledException |
	
	signaledException := nil.
	aBlockClosure 
		on: anExceptionHandlingCondition - MessageNotUnderstood 
		do: [ :anException | 
			signaledException := anException.
			anException return: nil ].
		
	signaledException isNil 
		ifTrue: [ self fail ]
		ifFalse: [ 
			self that: signaledException messageText isEqualTo: exceptionDescription.
			assertionsBlock value: signaledException ]
		! !

!Assert class methodsFor: 'expected exception assertions' stamp: 'HAW 7/30/2017 11:10:54'!
shouldNot: aBlockClosure signal: anExceptionHandlingCondition

	| handledException |
	
	handledException := false.
	aBlockClosure 
		on: anExceptionHandlingCondition 
		do: [ :anException | handledException := true ].
		
	self isFalse: handledException description: self shouldNotSignalFailureDescription! !


!Assert class methodsFor: 'private - signal failure' stamp: 'HAW 7/30/2017 11:18:57'!
signalFailure: aDescription

	Error signal: aDescription! !


!Assert class methodsFor: 'equality assertions' stamp: 'HAW 7/30/2017 10:39:33'!
that: actual isEqualTo: expected
 
	self that: actual isEqualTo: expected description: (self comparingStringBetween: actual and: expected)! !

!Assert class methodsFor: 'equality assertions' stamp: 'HAW 9/7/2017 15:45:12'!
that: actual isEqualTo: expected description: failureDescription 

	self isTrue: (actual isEqualTo: expected) description: failureDescription ! !

!Assert class methodsFor: 'equality assertions' stamp: 'HAW 7/30/2017 10:21:19'!
that: actual isNotEqualTo: expected
 
	self that: actual isNotEqualTo: expected description: self defaultNotEqualsFaillureDescription ! !

!Assert class methodsFor: 'equality assertions' stamp: 'HAW 9/7/2017 16:48:27'!
that: actual isNotEqualTo: expected description: failureDescription 
 
	self isTrue: (actual isNotEqualTo: expected) description: failureDescription ! !


!Assert class methodsFor: 'identity assertions' stamp: 'HAW 7/30/2017 10:27:44'!
that: actual isIdenticalTo: expected

	self that: actual isIdenticalTo: expected description: self defaultIdenticalFailureDescription 
! !

!Assert class methodsFor: 'identity assertions' stamp: 'HAW 9/7/2017 16:47:54'!
that: actual isIdenticalTo: expected description: failureDescription

	self isTrue: (actual isIdenticalTo: expected) description: failureDescription! !

!Assert class methodsFor: 'identity assertions' stamp: 'HAW 7/30/2017 10:31:04'!
that: actual isNotIdenticalTo: expected
 
	self that: actual isNotIdenticalTo: expected description: self defaultNotIdenticalFailureDescription
! !

!Assert class methodsFor: 'identity assertions' stamp: 'HAW 9/7/2017 16:48:15'!
that: actual isNotIdenticalTo: expected description: failureDescription

	self isTrue: (actual isNotIdenticalTo: expected) description: failureDescription ! !


!classDefinition: #AssertTest category: #'DenotativeObject-TestSupport'!
DenotativeObject subclass: #AssertTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AssertTest class' category: #'DenotativeObject-TestSupport'!
AssertTest class
	instanceVariableNames: ''!

!AssertTest class methodsFor: 'support' stamp: 'HAW 7/30/2017 09:21:26'!
shouldFail: aBlockClosure 
	
	| failed |
	
	failed := false.
	aBlockClosure
		on: Error - MessageNotUnderstood 
		do: [ :anError | failed := true ].
		
	failed ifFalse: [ Error signal: 'Expected to fail but did not fail' ]! !

!AssertTest class methodsFor: 'support' stamp: 'HAW 7/30/2017 09:42:07'!
shouldFail: aBlockClosure withDescription: aFailureDescription 

	| failedAsExpected |
	
	failedAsExpected := false.
	aBlockClosure
		on: Error - MessageNotUnderstood 
		do: [ :anError | failedAsExpected	:= anError messageText = aFailureDescription ].
		
	failedAsExpected ifFalse: [ Error signal: 'Expected to fail but did not fail' ]! !

!AssertTest class methodsFor: 'support' stamp: 'HAW 7/30/2017 09:18:45'!
shouldNotFail: aBlockClosure 
	
	aBlockClosure 
		on: Error - MessageNotUnderstood 
		do: [:anError | anError pass ]
			! !


!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:15:40'!
test01isTruePassWithTrue

	self shouldNotFail: [ Assert isTrue: true ]! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:19:08'!
test02isTrueFailsWithFalse

	self shouldFail: [ Assert isTrue: false ]! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:30:01'!
test03isTrueSupportsBlockAsCollaborator

	self shouldNotFail: [ Assert isTrue: [ true ] ]! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:32:21'!
test04isFalseFailsWithTrue

	self shouldFail: [ Assert isFalse: true ].
	! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:33:04'!
test05isFalsePassWithFalse

	self shouldNotFail: [ Assert isFalse: false ].
	! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:33:33'!
test06isFalseSupportsBlockAsCollaborator

	self shouldNotFail: [ Assert isFalse: [ false ] ].
	! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:38:57'!
test07isTrueCanHaveAFailureDescription

	| failureDescription |
	
	failureDescription := 'fails because I passed false'.
	self shouldFail: [ Assert isTrue: false description: failureDescription ] withDescription: failureDescription 
	
	! !

!AssertTest class methodsFor: 'tests - boolean assertions' stamp: 'HAW 7/30/2017 09:44:48'!
test08isFalseCanHaveAFailureDescription

	| failureDescription |
	
	failureDescription := 'fails because I passed true'.
	self shouldFail: [ Assert isFalse: true description: failureDescription ] withDescription: failureDescription 
	
	! !


!AssertTest class methodsFor: 'tests - equality assertions' stamp: 'HAW 7/30/2017 10:39:06'!
test09AssertEqualsPassWhenCollaboratorsAreEqual

	"I use {1} instead of 1 becuase 1 is identical to 1 but two { 1 } are not identical but equals - Hernan"
	
	self shouldNotFail: [ Assert that: { 1 } isEqualTo: { 1 } ]! !

!AssertTest class methodsFor: 'tests - equality assertions' stamp: 'HAW 7/30/2017 10:39:11'!
test10AssertEqualsFailsWhenCollaboratorsAreNotEqual

	| actual expected |
	
	actual := { 1 }.
	expected := { 2 }.
	self shouldFail: [ Assert that: actual isEqualTo: expected ] withDescription: (Assert comparingStringBetween: actual and: expected).

	! !

!AssertTest class methodsFor: 'tests - equality assertions' stamp: 'HAW 7/30/2017 10:39:26'!
test11AssertEqualsCanHaveAFailureDescription

	| actual expected failureDescription |
	
	actual := { 1 }.
	expected := { 2 }.
	failureDescription := 'not equal'.
	self shouldFail: [ Assert that: actual isEqualTo: expected description: failureDescription ] withDescription: failureDescription 

	! !

!AssertTest class methodsFor: 'tests - equality assertions' stamp: 'HAW 7/30/2017 10:15:58'!
test12AssertNotEqualsPassWhenCollaboratorsAreNotEqual
	
	self shouldNotFail: [ Assert that: { 1 } isNotEqualTo: { 2 } ]! !

!AssertTest class methodsFor: 'tests - equality assertions' stamp: 'HAW 7/30/2017 10:18:17'!
test13AssertNotEqualsFailsWhenCollaboratorsAreEqual
	
	self shouldFail: [ Assert that: { 1 } isNotEqualTo: { 1 } ] withDescription: Assert defaultNotEqualsFaillureDescription! !

!AssertTest class methodsFor: 'tests - equality assertions' stamp: 'HAW 7/30/2017 10:20:14'!
test14AssertNotEqualsCanHaveAFailureDescription

	| failureDescription |
	
	failureDescription := 'they are equal!!'.
	
	self shouldFail: [ Assert that: { 1 } isNotEqualTo: { 1 } description: failureDescription ] withDescription: failureDescription ! !


!AssertTest class methodsFor: 'tests - identity assertions' stamp: 'HAW 7/30/2017 10:24:11'!
test15AssertIdenticalPassWhenCollaboratorsAreIdentical
	
	self shouldNotFail: [ Assert that: self isIdenticalTo: self ]! !

!AssertTest class methodsFor: 'tests - identity assertions' stamp: 'HAW 7/30/2017 10:25:53'!
test16AssertIdenticalFailsWhenCollaboratorsAreNotIdentical
	
	self shouldFail: [ Assert that: 1 isIdenticalTo: 2 ] withDescription: Assert defaultIdenticalFailureDescription! !

!AssertTest class methodsFor: 'tests - identity assertions' stamp: 'HAW 7/30/2017 10:29:38'!
test17AssertIdenticalCanHaveFailureDescription

	| failureDescription |
	
	failureDescription := 'not identical'.
	
	self shouldFail: [ Assert that: 1 isIdenticalTo: 2 description: failureDescription ] withDescription: failureDescription ! !

!AssertTest class methodsFor: 'tests - identity assertions' stamp: 'HAW 7/30/2017 10:30:23'!
test18AssertNotIdenticalPassWhenCollaboratorsAreNotIdentical
	
	self shouldNotFail: [ Assert that: {1} isNotIdenticalTo: {2} ] ! !

!AssertTest class methodsFor: 'tests - identity assertions' stamp: 'HAW 7/30/2017 10:32:48'!
test19AssertNotIdenticalFailsWhenCollaboratorsAreIdentical
	
	self shouldFail: [ Assert that: self isNotIdenticalTo: self ] withDescription: Assert defaultNotIdenticalFailureDescription ! !

!AssertTest class methodsFor: 'tests - identity assertions' stamp: 'HAW 7/30/2017 10:33:33'!
test20AssertNotIdenticalCanHaveFailureDescription

	| failureDescription |
	
	failureDescription := 'Identical!!'.
	
	self shouldFail: [ Assert that: self isNotIdenticalTo: self description: failureDescription ] withDescription: failureDescription ! !


!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 10:40:38'!
test21ShouldSignalPassWhenExpectedExceptionIsSignaledWithRightDescription

	| errorDescription |

	errorDescription := 'nice error'.
	self shouldNotFail: [ Assert should: [ Error signal: errorDescription ] signal: Error withDescription: errorDescription ].! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 10:41:26'!
test22ShouldSignalFailsWhenExpectedExceptionIsSignaledWithDifferentDescription

	self shouldFail: [ Assert should: [ Error signal: 'error description' ] signal: Error withDescription: 'other description' ].! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 10:43:18'!
test23ShouldSignalFailsWhenOtherExceptionIsSignaled

	| errorDescription |

	errorDescription := 'nice error'.
	self shouldFail: [ Assert should: [ Error signal: errorDescription ] signal: ZeroDivide withDescription: errorDescription ].! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 10:44:48'!
test24ShouldSignalFailsWhenNoExceptionIsSignaled

	self shouldFail: [ Assert should: [ ] signal: Error withDescription: 'some description' ].! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 10:53:28'!
test25ShouldSignalSupportsAssertionsOnException

	| errorDescription |

	errorDescription := 'nice error'.
	self shouldNotFail: [ Assert 
		should: [ Error signal: errorDescription ] 
		signal: Error 
		withDescription: errorDescription 
		asserting: [ :anError | Assert isTrue: true ]].! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 10:56:46'!
test26ShouldSignalFailsWhenAditionalAssertionsFail

	| errorDescription failureDescription |

	errorDescription := 'nice error'.
	failureDescription := 'failed'.
	self 
		shouldFail: [ Assert 
			should: [ Error signal: errorDescription ] 
			signal: Error 
			withDescription: errorDescription 
			asserting: [ :anError | Assert isTrue: false description: failureDescription ]]
		withDescription: failureDescription ! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 11:02:36'!
test27ShouldSignalDoesNotHandlesMesssageNotUnderstood

	| mnuNotHandledByShouldSignal |
	
	[ Assert 
			should: [ 1 xxx ] 
			signal: Error 
			withDescription: 'no description' 
			asserting: [ :anError | mnuNotHandledByShouldSignal := false ]]
		on: MessageNotUnderstood 
		do: [ :aMNU | mnuNotHandledByShouldSignal := true ].
		
	Assert isTrue: mnuNotHandledByShouldSignal 
			! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 11:05:19'!
test28ShouldNotSignalPassWhenNoExceptionIsSignal

	self shouldNotFail: [ Assert shouldNot: [ ] signal: Error ]
	! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 11:07:40'!
test29ShouldNotSignalFailsWhenExceptionIsSignal

	self shouldFail: [ Assert shouldNot: [ Notification signal ] signal: Notification ]
	! !

!AssertTest class methodsFor: 'tests - expected exception assertions' stamp: 'HAW 7/30/2017 11:15:37'!
test30ShouldNotSignalPassWhenOtherExceptionIsSignal

	| errorDescription |
	
	errorDescription := 'my error'.
	Assert
		should:[ Assert shouldNot: [ Error signal: errorDescription ] signal: Notification ]
		signal: Error
		withDescription: errorDescription ! !


!classDefinition: #I category: #'DenotativeObject-TestSupport'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'DenotativeObject-TestSupport'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/29/2018 20:23:51'!
* unNumeroDePeano
	^unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/29/2018 19:54:20'!
+ unNumeroDePeano
	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:12:18'!
- unNumeroDePeano
	^self error: (self descripcionDeErrorDeNumerosNegativosNoSoportados)! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:41:01'!
/ unNumeroDePeano
	(unNumeroDePeano = self) ifTrue: [^self] ifFalse: [^self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)]! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:21:27'!
< unNumeroDePeano
	^(self = unNumeroDePeano) not! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:11:54'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:11:47'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/29/2018 19:52:56'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:55:05'!
previous
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:54:55'!
restarA: unNumeroDePeano
	^unNumeroDePeano previous! !


!classDefinition: #II category: #'DenotativeObject-TestSupport'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'DenotativeObject-TestSupport'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:48:56'!
* unNumeroDePeano
	^ self previous * unNumeroDePeano + unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:48:56'!
+ unNumeroDePeano
	^ (self previous + unNumeroDePeano) next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/29/2018 20:26:32'!
- unNumeroDePeano
	^unNumeroDePeano restarA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 15:04:38'!
/ unNumeroDePeano
	(self < unNumeroDePeano) 	ifTrue: [^self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)]
									ifFalse: [(self < (II * unNumeroDePeano)) 	ifTrue: [^I]
																					ifFalse: [^((self - unNumeroDePeano)/unNumeroDePeano) next]]! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:48:56'!
< unNumeroDePeano
	unNumeroDePeano = I
		ifTrue: [ ^ false ]
		ifFalse: [ ^ self previous < unNumeroDePeano previous ].! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:20:21'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:03:45'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:16:49'!
next
	|nextName|
	nextName := (self name), #I.
	(Smalltalk hasClassNamed: nextName) ifTrue: [^Smalltalk classNamed: nextName] ifFalse: [^self cloneNamed: nextName]! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:48:56'!
previous
	^ Smalltalk classNamed: self name allButLast.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:48:56'!
restarA: unNumeroDePeano
	^ (self previous restarA: unNumeroDePeano) previous.! !


!classDefinition: #III category: #'DenotativeObject-TestSupport'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'DenotativeObject-TestSupport'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
* unNumeroDePeano
	^ self previous * unNumeroDePeano + unNumeroDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
+ unNumeroDePeano
	^ (self previous + unNumeroDePeano) next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
- unNumeroDePeano
	^unNumeroDePeano restarA: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 15:04:31'!
/ unNumeroDePeano
	(self < unNumeroDePeano) 	ifTrue: [^self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)]
									ifFalse: [(self < (II * unNumeroDePeano)) 	ifTrue: [^I]
																					ifFalse: [^((self - unNumeroDePeano)/unNumeroDePeano) next]]! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
< unNumeroDePeano
	unNumeroDePeano = I
		ifTrue: [ ^ false ]
		ifFalse: [ ^ self previous < unNumeroDePeano previous ].! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
next
	|nextName|
	nextName := (self name), #I.
	(Smalltalk hasClassNamed: nextName) ifTrue: [^Smalltalk classNamed: nextName] ifFalse: [^self cloneNamed: nextName]! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
previous
	^ Smalltalk classNamed: self name allButLast.! !

!III class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:39'!
restarA: unNumeroDePeano
	^ (self previous restarA: unNumeroDePeano) previous.! !


!classDefinition: #IIII category: #'DenotativeObject-TestSupport'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DenotativeObject-TestSupport'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'DenotativeObject-TestSupport'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
* unNumeroDePeano
	^ self previous * unNumeroDePeano + unNumeroDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
+ unNumeroDePeano
	^ (self previous + unNumeroDePeano) next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
- unNumeroDePeano
	^unNumeroDePeano restarA: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 15:04:20'!
/ unNumeroDePeano
	(self < unNumeroDePeano) 	ifTrue: [^self error: (self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor)]
									ifFalse: [(self < (II * unNumeroDePeano)) 	ifTrue: [^I]
																					ifFalse: [^((self - unNumeroDePeano)/unNumeroDePeano) next]]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
< unNumeroDePeano
	unNumeroDePeano = I
		ifTrue: [ ^ false ]
		ifFalse: [ ^ self previous < unNumeroDePeano previous ].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
next
	|nextName|
	nextName := (self name), #I.
	(Smalltalk hasClassNamed: nextName) ifTrue: [^Smalltalk classNamed: nextName] ifFalse: [^self cloneNamed: nextName]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
previous
	^ Smalltalk classNamed: self name allButLast.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'MI 3/30/2018 14:57:47'!
restarA: unNumeroDePeano
	^ (self previous restarA: unNumeroDePeano) previous.! !
