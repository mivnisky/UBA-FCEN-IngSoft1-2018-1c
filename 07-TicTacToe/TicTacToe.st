!classDefinition: #TicTacToeTests category: #TicTacToe!
TestCase subclass: #TicTacToeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:34:34'!
test01

	| game |
	
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:40:59'!
test02

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:54:05'!
test03

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 1@1).
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 2@2).
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:33:06'!
test04

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
		].
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:03:18'!
test05

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:52:26'!
test06

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putXAt: 1@1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:57:06'!
test07

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:07:40'!
test08

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self
	should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.
		].
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:06:59'!
test09

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	
	self
	should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 3@3).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).
		].
	! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:23:32'!
test10

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
	self deny: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:34:41'!
test11

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:35:29'!
test12

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 2@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:35:43'!
test13

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@3.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:01:17'!
test14

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:02:01'!
test15

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:02:27'!
test16

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:20:29'!
test17

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@1.
	game putOAt: 1@3.
	
	self assert: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:28:48'!
test18

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@1.
	game putXAt: 1@3.
	
	self 
		should: [ game putOAt: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe cannotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 2 equals: game Os size.
			self assert: (game Os includes: 2@1).
			self assert: (game Os includes: 3@1).
			].! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:34:31'!
test19

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 3@3.
	
	self 
		should: [ game putXAt: 3@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TicTacToe cannotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assert: 3 equals: game Xs size.
			self assert: (game Xs includes: 2@1).
			self assert: (game Xs includes: 2@3).
			self assert: (game Xs includes: 1@3).
			].! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:40:31'!
test20

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@1.
	game putOAt: 2@2.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game XHasWon.
	self deny: game OHasWon.
	self assert: game isTied.! !

!TicTacToeTests methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:41:29'!
test21

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@1.
	game putOAt: 2@2.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 2@3.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	self assert: game isOver.
	self assert: game XHasWon.
	self deny: game OHasWon.
	self deny: game isTied.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'turn winner plays'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:32:17'!
OHasWon

	^ winner = #o! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:06:23'!
Os

	^ plays at: #o! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 20:32:25'!
XHasWon

	^ winner = #x! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:06:31'!
Xs

	^ plays at: #x! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 16:54:33'!
hasCompleteColumn: aSetOfPositions

	^ (1 to: 3) anySatisfy: [ :y | (aSetOfPositions count: [ :position | position y = y ]) = 3 ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:17:28'!
hasCompleteNorthDiagonal: aSetOfPositions

	^ (1 to: 3) allSatisfy: [ :x | aSetOfPositions includes: x @ x ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:17:41'!
hasCompleteRow: aSetOfPositions

	^ (1 to: 3) anySatisfy: [ :x | (aSetOfPositions count: [ :position | position x = x ]) = 3 ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:17:49'!
hasCompleteSouthDiagonal: aSetOfPositions

	^ (1 to: 3) allSatisfy: [ :x | aSetOfPositions includes: x @ (4 - x) ].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:18:33'!
hasWon: aSetOfPositions

	^ (self hasCompleteRow: aSetOfPositions)
		or: [(self hasCompleteColumn: aSetOfPositions)
		or: [(self hasCompleteNorthDiagonal: aSetOfPositions)
		or: [(self hasCompleteSouthDiagonal: aSetOfPositions)]]].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:39:07'!
isOver

	^ self XHasWon or: [ self OHasWon or: [ self isTied ]]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:07:13'!
isTied

	^ self XHasWon not and: [ self Xs size = 5 ] .! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:10:53'!
otherPlayer: aPlayerSymbol

	aPlayerSymbol = #x ifTrue: [ ^ #o ] ifFalse: [ ^ #x ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:09:59'!
play: aPlayerSymbol At: aPosition

	self isOver ifTrue: [ self error: self class cannotPlayWhenGameIsOverErrorMessage ].
	turn = aPlayerSymbol ifFalse: [ self error: (self class notPlayerTurnErrorMessage: aPlayerSymbol) ].
	((self Os includes: aPosition) or: [ self Xs includes: aPosition ]) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(plays at: aPlayerSymbol) add: aPosition.
	(self hasWon: (plays at: aPlayerSymbol)) ifTrue: [ winner _ aPlayerSymbol ].
	turn _ self otherPlayer: aPlayerSymbol.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:12:53'!
positionsOf: aPlayer
	
	^ plays at: aPlayer ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:12:00'!
putOAt: aPosition

	self play: #o At: aPosition ! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 17:12:21'!
putXAt: aPosition

	self play: #x At: aPosition ! !


!TicTacToe methodsFor: 'instance initialization' stamp: 'MI 5/28/2018 17:05:55'!
initialize

	plays := Dictionary new.
	plays at: #x put: Set new.
	plays at: #o put: Set new.
	turn := #x.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 21:24:25'!
cannotPlayWhenGameIsOverErrorMessage

	^ 'El juego ya terminó'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 16:40:53'!
notOTurnErrorMessage

	^ self notPlayerTurnErrorMessage: #o! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 16:40:12'!
notPlayerTurnErrorMessage: aPlayer

	^ 'No es el turno de ', aPlayer, '!!'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'MI 5/28/2018 16:41:07'!
notXTurnErrorMessage

	^ self notPlayerTurnErrorMessage: #x! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'MI 5/24/2018 19:52:53'!
positionTakenErrorMessage

	^ 'Esta posición está ocupada~'! !
