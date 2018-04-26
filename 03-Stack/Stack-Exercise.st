!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'MI 4/25/2018 19:52:31'!
isEmpty
	
	^ topElement isEmptyElement! !

!OOStack methodsFor: 'testing' stamp: 'NDC 4/26/2018 00:28:15'!
size

	^ size! !


!OOStack methodsFor: 'initialization' stamp: 'MI 4/25/2018 20:12:27'!
initialize

	topElement := OOStackEmptyElement new.
	size := 0.
	^ self! !


!OOStack methodsFor: 'adding' stamp: 'NDC 4/26/2018 00:24:56'!
push: aValue
	topElement _ OOStackElementContainingAValue
		withValue: aValue
		andPrevious: topElement.
	size _ size + 1.! !


!OOStack methodsFor: 'removing' stamp: 'NDC 4/26/2018 00:23:25'!
pop
	
	| topValue |
	topValue := self top value.
	
	topElement := topElement previous.
	size := size - 1.
	
	^ topValue! !


!OOStack methodsFor: 'accessing' stamp: 'MI 4/25/2018 20:02:05'!
top

	^ topElement value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'instance creation' stamp: 'MI 4/21/2018 01:09:00'!
new

	^ super new! !


!classDefinition: #OOStackElementContainingAValue category: #'Stack-Exercise'!
Object subclass: #OOStackElementContainingAValue
	instanceVariableNames: 'previous value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementContainingAValue methodsFor: 'accessing' stamp: 'MI 4/25/2018 20:00:02'!
previous

	^ previous ! !

!OOStackElementContainingAValue methodsFor: 'accessing' stamp: 'MI 4/25/2018 20:02:51'!
value

	^ value! !


!OOStackElementContainingAValue methodsFor: 'testing' stamp: 'MI 4/25/2018 19:53:39'!
isEmptyElement

	^ false! !


!OOStackElementContainingAValue methodsFor: 'initialization' stamp: 'MI 4/25/2018 20:09:25'!
withValue: aValue andPrevious: aStackElement

	value := aValue.
	previous := aStackElement.
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementContainingAValue class' category: #'Stack-Exercise'!
OOStackElementContainingAValue class
	instanceVariableNames: ''!

!OOStackElementContainingAValue class methodsFor: 'instance creation' stamp: 'MI 4/25/2018 20:08:15'!
withValue: aValue andPrevious: aStackElement

	^ self new withValue: aValue andPrevious: aStackElement! !


!classDefinition: #OOStackEmptyElement category: #'Stack-Exercise'!
Object subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'testing' stamp: 'MI 4/25/2018 19:53:09'!
isEmptyElement

	^ true! !


!OOStackEmptyElement methodsFor: 'accessing' stamp: 'MI 4/25/2018 20:04:24'!
value
	
	^ self error: OOStack stackEmptyErrorDescription ! !
