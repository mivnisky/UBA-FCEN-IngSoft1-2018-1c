!classDefinition: #TicTacToeTests category: #TicTacToe!
TestCase subclass: #TicTacToeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:53:42'!
test01EmptyGameHasNoPlays
	| game |
	game _ TicTacToe new.
	self
		assertXHasPlayed: 0
		timesInGame: game.
	self
		assertOHasPlayed: 0
		timesInGame: game.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:56:18'!
test02PlayerXCanPlayFirst
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		assertXHasPlayed: 1
		timesInGame: game.
	self
		assertXHasPlayedInPosition: 1 @ 1
		inGame: game.
	self
		assertOHasPlayed: 0
		timesInGame: game.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:56:31'!
test03PlayerOCanPlaySecond
	| game |
	game _ TicTacToe new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	self
		assertOHasPlayed: 1
		timesInGame: game.
	self
		assertOHasPlayedInPosition: 1 @ 1
		inGame: game.
	self
		assertXHasPlayed: 1
		timesInGame: game.
	self
		assertXHasPlayedInPosition: 2 @ 2
		inGame: game.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:55:32'!
test04PlayerXCannotPlayTwoTimesInARow
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notXTurnErrorMessage
				equals: anError messageText.
			self
				assertXHasPlayed: 1
				timesInGame: game.
			self
				assertXHasPlayedInPosition: 1 @ 1
				inGame: game.
			self
				assertOHasPlayed: 0
				timesInGame: game ].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:55:55'!
test05PlayerOCannotPlayTwoTimesInARow
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putOAt: 3 @ 3 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notOTurnErrorMessage
				equals: anError messageText.
			self
				assertXHasPlayed: 1
				timesInGame: game.
			self
				assertXHasPlayedInPosition: 1 @ 1
				inGame: game.
			self
				assertOHasPlayed: 1
				timesInGame: game.
			self
				assertOHasPlayedInPosition: 2 @ 2
				inGame: game ].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:57:43'!
test06PlayerXCannotPlayInAPositionAlreadyOccupiedByItself
	| game |
	game _ TicTacToe new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXHasPlayed: 1
				timesInGame: game.
			self
				assertXHasPlayedInPosition: 1 @ 1
				inGame: game.
			self
				assertOHasPlayed: 1
				timesInGame: game.
			self
				assertOHasPlayedInPosition: 2 @ 2
				inGame: game ].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:58:51'!
test07PlayerXCannotPlayInAPositionAlreadyOccupiedByPlayerO

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assertXHasPlayed: 1 timesInGame: game.
		self assertXHasPlayedInPosition: 1@1 inGame: game.
		self assertOHasPlayed: 1 timesInGame: game.
		self assertOHasPlayedInPosition: 2@2 inGame: game.
		].
	! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:59:06'!
test08PlayerOCannotPlayInAPositionAlreadyOccupiedByPlayerX

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self
	should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assertXHasPlayed: 1 timesInGame: game.
		self assertXHasPlayedInPosition: 1@1 inGame: game.
		self assertOHasPlayed: 0 timesInGame: game.
		].
	! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 17:58:27'!
test09PlayerOCannotPlayInAPositionAlreadyOccupiedByItself

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
		self assertXHasPlayed: 2 timesInGame: game.
		self assertXHasPlayedInPosition: 1@1 inGame: game.
		self assertXHasPlayedInPosition: 3@3 inGame: game.
		self assertOHasPlayed: 1 timesInGame: game.
		self assertOHasPlayedInPosition: 2@2 inGame: game.
		].
	! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:00:13'!
test10NobodyWinsBeforeCompletingALine

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	
	self deny: game OHasWon.
	self deny: game XHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:02:44'!
test11XHasWonAfterCompletingFirstRow

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:02:50'!
test12XHasWonAfterCompletingSecondRow

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 2@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:02:58'!
test13XHasWonAfterCompletingThirdRow

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@3.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:03:51'!
test14XHasWonAfterCompletingAColumn

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:07:22'!
test15XHasWonAfterCompletingDecreasingDiagonal

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:07:37'!
test16XHasWonAfterCompletingIncreasingDiagonal

	| game |
	
	game := TicTacToe new.
	
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:08:17'!
test17OCanWin

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

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:08:58'!
test18OCannotPlayWhenGameIsOver

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
			self assertOHasPlayed: 2 timesInGame: game.
			self assertOHasPlayedInPosition: 2@1 inGame: game.
			self assertOHasPlayedInPosition: 3@1 inGame: game.
			].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:09:13'!
test19XCannotPlayWhenGameIsOver

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
			self assertXHasPlayed: 3 timesInGame: game.
			self assertXHasPlayedInPosition: 2@1 inGame: game.
			self assertXHasPlayedInPosition: 2@3 inGame: game.
			self assertXHasPlayedInPosition: 1@3 inGame: game.
			].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:09:52'!
test20GameCanEndInTie

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

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:11:28'!
test21XCanWinInLastTurn

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

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:29:26'!
test22firstCoordinateBelow1RaisesError

	| game |
	
	game _ TicTacToe new.
	
	self should: [ game putXAt: 0 @ 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe invalidPositionErrorMessage equals: anError messageText.
		].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:29:53'!
test23firstCoordinateOver3RaisesError

	| game |
	
	game _ TicTacToe new.
	
	self should: [ game putXAt: 11 @ 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe invalidPositionErrorMessage equals: anError messageText.
		].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:30:19'!
test24secondCoordinateBelow1RaisesError

	| game |
	
	game _ TicTacToe new.
	
	self should: [ game putXAt: 1 @ 0. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe invalidPositionErrorMessage equals: anError messageText.
		].! !

!TicTacToeTests methodsFor: 'tests' stamp: 'MI 5/29/2018 18:30:33'!
test25secondCoordinateOver3RaisesError

	| game |
	
	game _ TicTacToe new.
	
	self should: [ game putXAt: 1 @ 4. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe invalidPositionErrorMessage equals: anError messageText.
		].! !


!TicTacToeTests methodsFor: 'helpers' stamp: 'MI 5/29/2018 17:12:45'!
assertOHasPlayed: aNumberOfPlays timesInGame: aGame

	self assert: aGame numberOfPlaysByO = aNumberOfPlays 
	! !

!TicTacToeTests methodsFor: 'helpers' stamp: 'MI 5/29/2018 17:19:29'!
assertOHasPlayedInPosition: aPosition inGame: aGame

	self assert: (aGame hasOOccupiedPosition: aPosition)
	! !

!TicTacToeTests methodsFor: 'helpers' stamp: 'MI 5/29/2018 17:12:35'!
assertXHasPlayed: aNumberOfPlays timesInGame: aGame

	self assert: aGame numberOfPlaysByX = aNumberOfPlays 
	! !

!TicTacToeTests methodsFor: 'helpers' stamp: 'MI 5/29/2018 17:19:23'!
assertXHasPlayedInPosition: aPosition inGame: aGame

	self assert: (aGame hasXOccupiedPosition: aPosition)
	! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'winner plays'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'game status' stamp: 'MI 5/24/2018 20:32:17'!
OHasWon

	^ winner = #o! !

!TicTacToe methodsFor: 'game status' stamp: 'MI 5/24/2018 20:32:25'!
XHasWon

	^ winner = #x! !

!TicTacToe methodsFor: 'game status' stamp: 'MI 5/29/2018 17:24:39'!
currentTurn

	^ plays size even ifTrue: [ #x ] ifFalse: [ #o ]! !

!TicTacToe methodsFor: 'game status' stamp: 'MI 5/24/2018 21:39:07'!
isOver

	^ self XHasWon or: [ self OHasWon or: [ self isTied ]]! !

!TicTacToe methodsFor: 'game status' stamp: 'MI 5/29/2018 17:05:06'!
isTied

	^ self XHasWon not and: [ plays size = 9 ] .! !


!TicTacToe methodsFor: 'winner check' stamp: 'MI 5/29/2018 17:03:29'!
hasColumnBeenCompletedByPlayer: aPlayerSymbol

	^ (1 to: 3) anySatisfy: [ :column | ((1 to: 3) count: [ :row | (self boardAt: column @ row) = aPlayerSymbol ]) = 3 ].! !

!TicTacToe methodsFor: 'winner check' stamp: 'MI 5/29/2018 18:05:10'!
hasDecreasingDiagonalBeenCompletedByPlayer: aPlayerSymbol
	^ (1 to: 3) allSatisfy: [ :column |
		(self boardAt: column @ column) = aPlayerSymbol ].! !

!TicTacToe methodsFor: 'winner check' stamp: 'MI 5/29/2018 18:05:27'!
hasIncreasingDiagonalBeenCompletedByPlayer: aPlayerSymbol
	^ (1 to: 3) allSatisfy: [ :column |
		(self boardAt: column @ (4 - column)) = aPlayerSymbol ].! !

!TicTacToe methodsFor: 'winner check' stamp: 'MI 5/29/2018 17:04:10'!
hasRowBeenCompletedByPlayer: aPlayerSymbol

	^ (1 to: 3) anySatisfy: [ :row | ((1 to: 3) count: [ :column | (self boardAt: column @ row) = aPlayerSymbol ]) = 3 ].! !

!TicTacToe methodsFor: 'winner check' stamp: 'MI 5/29/2018 18:05:27'!
hasWon: aPlayerSymbol
	^ (self hasRowBeenCompletedByPlayer: aPlayerSymbol) or: [
		(self hasColumnBeenCompletedByPlayer: aPlayerSymbol) or: [
			(self hasDecreasingDiagonalBeenCompletedByPlayer: aPlayerSymbol) or: [ self hasIncreasingDiagonalBeenCompletedByPlayer: aPlayerSymbol ]]].! !


!TicTacToe methodsFor: 'instance initialization' stamp: 'MI 5/29/2018 16:00:02'!
initialize

	plays := Dictionary new.
	turn := #x.! !


!TicTacToe methodsFor: 'private' stamp: 'MI 5/29/2018 17:01:25'!
boardAt: aPosition

	^ plays at: aPosition ifAbsent: [ ]! !


!TicTacToe methodsFor: 'testing' stamp: 'MI 5/29/2018 17:15:30'!
hasOOccupiedPosition: aPosition

	^ self hasPosition: aPosition beenOccupiedBy: #o.! !

!TicTacToe methodsFor: 'testing' stamp: 'MI 5/29/2018 17:02:40'!
hasPosition: aPosition beenOccupiedBy: aPlayerSymbol

	^ (self boardAt: aPosition) = aPlayerSymbol ! !

!TicTacToe methodsFor: 'testing' stamp: 'MI 5/29/2018 17:15:24'!
hasXOccupiedPosition: aPosition

	^ self hasPosition: aPosition beenOccupiedBy: #x.! !

!TicTacToe methodsFor: 'testing' stamp: 'MI 5/29/2018 17:07:24'!
numberOfPlaysBy: aPlayerSymbol

	^ plays keys count: [ :position | (self boardAt: position) = aPlayerSymbol ]! !

!TicTacToe methodsFor: 'testing' stamp: 'MI 5/29/2018 17:07:41'!
numberOfPlaysByO

	^ self numberOfPlaysBy: #o.! !

!TicTacToe methodsFor: 'testing' stamp: 'MI 5/29/2018 17:07:45'!
numberOfPlaysByX

	^ self numberOfPlaysBy: #x.! !


!TicTacToe methodsFor: 'play' stamp: 'MI 5/29/2018 18:26:15'!
ensurePlayer: aPlayerSymbol canPlayAt: aPosition

	self when: [ (self isValidPosition: aPosition) not ] holdsRaiseErrorWith: self class invalidPositionErrorMessage.
	self when: [ self isOver ] holdsRaiseErrorWith: self class cannotPlayWhenGameIsOverErrorMessage.
	self when: [ self currentTurn ~= aPlayerSymbol ] holdsRaiseErrorWith: (self class notPlayerTurnErrorMessage: aPlayerSymbol).
	self when: [ plays includesKey: aPosition ] holdsRaiseErrorWith: self class positionTakenErrorMessage.! !

!TicTacToe methodsFor: 'play' stamp: 'MI 5/29/2018 18:24:52'!
isValidPosition: aPosition
	^ ((1 to: 3) includes: aPosition x) and: [ (1 to: 3) includes: aPosition y ].! !

!TicTacToe methodsFor: 'play' stamp: 'MI 5/29/2018 16:26:55'!
play: aPlayerSymbol At: aPosition

	self ensurePlayer: aPlayerSymbol canPlayAt: aPosition.
	plays at: aPosition put: aPlayerSymbol.
	(self hasWon: aPlayerSymbol) ifTrue: [ winner _ aPlayerSymbol ].! !

!TicTacToe methodsFor: 'play' stamp: 'MI 5/29/2018 17:41:20'!
putOAt: aPosition

	self play: #o At: aPosition.! !

!TicTacToe methodsFor: 'play' stamp: 'MI 5/29/2018 17:41:25'!
putXAt: aPosition

	self play: #x At: aPosition.! !


!TicTacToe methodsFor: 'error' stamp: 'MI 5/29/2018 15:39:53'!
when: aConditionBlock holdsRaiseErrorWith: anErrorMessage

	aConditionBlock value ifTrue: [ self error: anErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'error messages' stamp: 'MI 5/29/2018 18:25:11'!
cannotPlayWhenGameIsOverErrorMessage

	^ 'El juego ya terminó'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'MI 5/29/2018 18:14:20'!
invalidPositionErrorMessage

	^ 'La posición ingresada es inválida!!'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'MI 5/28/2018 16:40:53'!
notOTurnErrorMessage

	^ self notPlayerTurnErrorMessage: #o! !

!TicTacToe class methodsFor: 'error messages' stamp: 'MI 5/28/2018 16:40:12'!
notPlayerTurnErrorMessage: aPlayer

	^ 'No es el turno de ', aPlayer, '!!'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'MI 5/28/2018 16:41:07'!
notXTurnErrorMessage

	^ self notPlayerTurnErrorMessage: #x! !

!TicTacToe class methodsFor: 'error messages' stamp: 'MI 5/24/2018 19:52:53'!
positionTakenErrorMessage

	^ 'Esta posición está ocupada~'! !
