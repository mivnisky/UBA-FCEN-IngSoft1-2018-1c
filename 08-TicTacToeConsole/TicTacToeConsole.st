!classDefinition: #TicTacToeLogTest category: #TicTacToeConsole!
TestCase subclass: #TicTacToeLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:35:00'!
test01LogStartsEmpty

	| game log |
	
	game := TicTacToe new.
	
	log := TicTacToeLog with: game.
	
	self assert: log lines isEmpty! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:40:44'!
test02LogLogsXPlay

	| game log lines |
	
	game := TicTacToe new.
	
	log := TicTacToeLog with: game.
	
	game markWithXAt: 2@2.
	
	lines := log lines.
	
	self assert: lines size = 2.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:40:56'!
test03LogLogsOPlay

	| game log lines |
	
	game := TicTacToe new.
	
	log := TicTacToeLog with: game.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	
	lines := log lines.
	
	self assert: lines size = 4.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:41:15'!
test04LogLogsXWin

	| game log lines |
	
	game := TicTacToe new.
	
	log := TicTacToeLog with: game.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 2@1.
	game markWithOAt: 3@3.
	game markWithXAt: 2@3.
	
	lines := log lines.
	
	self assert: lines size = 10.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.
	self assert: (lines at: 5) = 'X marcó en 2@1'.
	self assert: (lines at: 6) = 'Estado: Jugando O'.
	self assert: (lines at: 7) = 'O marcó en 3@3'.
	self assert: (lines at: 8) = 'Estado: Jugando X'.
	self assert: (lines at: 9) = 'X marcó en 2@3'.
	self assert: (lines at: 10) = 'Juego terminado - Ganó X!!'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:41:27'!
test05LogLogsOWin

	| game log lines |
	
	game := TicTacToe new.
	
	log := TicTacToeLog with: game.
	
	game markWithXAt: 3@2.
	game markWithOAt: 1@1.
	game markWithXAt: 2@1.
	game markWithOAt: 3@3.
	game markWithXAt: 2@3.
	game markWithOAt: 2@2.
	
	lines := log lines.
	
	self assert: lines size = 12.
	self assert: (lines at: 1) = 'X marcó en 3@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.
	self assert: (lines at: 5) = 'X marcó en 2@1'.
	self assert: (lines at: 6) = 'Estado: Jugando O'.
	self assert: (lines at: 7) = 'O marcó en 3@3'.
	self assert: (lines at: 8) = 'Estado: Jugando X'.
	self assert: (lines at: 9) = 'X marcó en 2@3'.
	self assert: (lines at: 10) = 'Estado: Jugando O'.
	self assert: (lines at: 11) = 'O marcó en 2@2'.
	self assert: (lines at: 12) = 'Juego terminado - Ganó O!!'.! !

!TicTacToeLogTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:41:38'!
test06LogLogsGameTie

	| game log lines |
	
	game := TicTacToe new.
	
	log := TicTacToeLog with: game.
	
	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.
	
	lines := log lines.
	
	self assert: lines size = 18.
	self assert: (lines at: 1) = 'X marcó en 2@2'.
	self assert: (lines at: 2) = 'Estado: Jugando O'.
	self assert: (lines at: 3) = 'O marcó en 1@1'.
	self assert: (lines at: 4) = 'Estado: Jugando X'.
	self assert: (lines at: 5) = 'X marcó en 1@3'.
	self assert: (lines at: 6) = 'Estado: Jugando O'.
	self assert: (lines at: 7) = 'O marcó en 3@1'.
	self assert: (lines at: 8) = 'Estado: Jugando X'.
	self assert: (lines at: 9) = 'X marcó en 2@1'.
	self assert: (lines at: 10) = 'Estado: Jugando O'.
	self assert: (lines at: 11) = 'O marcó en 2@3'.
	self assert: (lines at: 12) = 'Estado: Jugando X'.
	self assert: (lines at: 13) = 'X marcó en 1@2'.
	self assert: (lines at: 14) = 'Estado: Jugando O'.
	self assert: (lines at: 15) = 'O marcó en 3@2'.
	self assert: (lines at: 16) = 'Estado: Jugando X'.
	self assert: (lines at: 17) = 'X marcó en 3@3'.
	self assert: (lines at: 18) = 'Juego terminado - Empate!!'.! !


!classDefinition: #TicTacToeTest category: #TicTacToeConsole!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToeViewTest category: #TicTacToeConsole!
TestCase subclass: #TicTacToeViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeViewTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:44:20'!
test01ViewDisplaysEmptyGameWhenItStarts

	| game view lines |
	
	game := TicTacToe new.
	
	view := TicTacToeView with: game.
	
	lines := view lines.
	self assert: lines size = 6.
	self assert: (lines at: 1) = ' | | '.
	self assert: (lines at: 2) = '-----'.
	self assert: (lines at: 3) = ' | | '.
	self assert: (lines at: 4) = '-----'.
	self assert: (lines at: 5) = ' | | '.
	self assert: (lines at: 6) = 'Playing X'.! !

!TicTacToeViewTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:44:40'!
test02ViewDisplaysXPlayAndOPlayingStatus

	| game view lines |
	
	game := TicTacToe new.	
	view := TicTacToeView with: game.
	
	game markWithXAt: 2@2.
	
	lines := view lines.
	self assert: lines size = 6.
	self assert: (lines at: 1) = ' | | '.
	self assert: (lines at: 2) = '-----'.
	self assert: (lines at: 3) = ' |X| '.
	self assert: (lines at: 4) = '-----'.
	self assert: (lines at: 5) = ' | | '.
	self assert: (lines at: 6) = 'Playing O'.! !

!TicTacToeViewTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:44:56'!
test03ViewDisplaysOPlayAndXPlayingStatus

	| game view lines |
	
	game := TicTacToe new.	
	view := TicTacToeView with: game.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	
	lines := view lines.
	self assert: lines size = 6.
	self assert: (lines at: 1) = 'O| | '.
	self assert: (lines at: 2) = '-----'.
	self assert: (lines at: 3) = ' |X| '.
	self assert: (lines at: 4) = '-----'.
	self assert: (lines at: 5) = ' | | '.
	self assert: (lines at: 6) = 'Playing X'.! !

!TicTacToeViewTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:45:10'!
test04ViewDisplaysXWin

	| game view lines |
	
	game := TicTacToe new.	
	view := TicTacToeView with: game.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 2@1.
	game markWithOAt: 3@3.
	game markWithXAt: 2@3.
	
	lines := view lines.
	self assert: lines size = 6.
	self assert: (lines at: 1) = 'O|X| '.
	self assert: (lines at: 2) = '-----'.
	self assert: (lines at: 3) = ' |X| '.
	self assert: (lines at: 4) = '-----'.
	self assert: (lines at: 5) = ' |X|O'.
	self assert: (lines at: 6) = 'X Won!!'.! !

!TicTacToeViewTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:45:19'!
test05ViewDisplaysOWin

	| game view lines |
	
	game := TicTacToe new.	
	view := TicTacToeView with: game.
	
	game markWithXAt: 3@2.
	game markWithOAt: 1@1.
	game markWithXAt: 2@1.
	game markWithOAt: 3@3.
	game markWithXAt: 2@3.
	game markWithOAt: 2@2.

	lines := view lines.
	self assert: lines size = 6.
	self assert: (lines at: 1) = 'O|X| '.
	self assert: (lines at: 2) = '-----'.
	self assert: (lines at: 3) = ' |O|X'.
	self assert: (lines at: 4) = '-----'.
	self assert: (lines at: 5) = ' |X|O'.
	self assert: (lines at: 6) = 'O Won!!'.! !

!TicTacToeViewTest methodsFor: 'testing' stamp: 'MI 6/1/2018 15:45:35'!
test06ViewDisplaysGameTied

	| game view lines |
	
	game := TicTacToe new.	
	view := TicTacToeView with: game.
	
	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	lines := view lines.
	self assert: lines size = 6.
	self assert: (lines at: 1) = 'O|X|O'.
	self assert: (lines at: 2) = '-----'.
	self assert: (lines at: 3) = 'X|X|O'.
	self assert: (lines at: 4) = '-----'.
	self assert: (lines at: 5) = 'X|O|X'.
	self assert: (lines at: 6) = 'Game Tied!!'.! !


!classDefinition: #TicTacToe category: #TicTacToeConsole!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToe methodsFor: 'initialization' stamp: 'MI 5/31/2018 19:53:50'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	observers := OrderedCollection new.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'MI 5/31/2018 20:43:34'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithOAt: aPosition.! !

!TicTacToe methodsFor: 'marking board' stamp: 'MI 5/31/2018 20:43:39'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithXAt: aPosition.! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'MI 5/31/2018 20:47:50'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self.
	self notifySuscribersWithNewPosition: aPosition! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'JG 5/12/2018 12:34:04'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:44:57'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'observers' stamp: 'MI 5/31/2018 18:50:57'!
attach: anObserver

	observers add: anObserver! !

!TicTacToe methodsFor: 'observers' stamp: 'MI 5/31/2018 20:49:22'!
notifySuscribersWithNewPosition: aPosition

	observers do: [ :observer | (state messageToBroadcast) sendTo: observer with: aPosition ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToeConsole!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeObserver category: #TicTacToeConsole!
Object subclass: #TicTacToeObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeObserver methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:52:42'!
pushGameTied: aPosition

	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:52:09'!
pushOWon: aPosition

	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:52:38'!
pushPlayingO: aPosition

	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:52:36'!
pushPlayingX: aPosition

	self subclassResponsibility ! !

!TicTacToeObserver methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:52:16'!
pushXWon: aPosition

	self subclassResponsibility ! !


!TicTacToeObserver methodsFor: 'instance initialization' stamp: 'MI 6/1/2018 15:53:36'!
initializeWith: aTicTacToeGame

	self subclassResponsibility ! !


!TicTacToeObserver methodsFor: 'display' stamp: 'MI 6/1/2018 15:58:46'!
lines
	
	self subclassResponsibility ! !


!classDefinition: #TicTacToeLog category: #TicTacToeConsole!
TicTacToeObserver subclass: #TicTacToeLog
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeLog methodsFor: 'instance initialization' stamp: 'MI 6/1/2018 15:53:54'!
initializeWith: aTicTacToeGame

	aTicTacToeGame attach: self.
	lines := OrderedCollection new.! !


!TicTacToeLog methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:51:10'!
pushGameTied: aPosition

	self logPosition: aPosition forPlayer: 'X'.
	lines add: 'Juego terminado - Empate!!'.! !

!TicTacToeLog methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:51:15'!
pushOWon: aPosition

	self logPosition: aPosition forPlayer: 'O'.
	lines add: 'Juego terminado - Ganó O!!'.! !

!TicTacToeLog methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:51:23'!
pushPlayingO: aPosition
	
	self logPosition: aPosition forPlayer: 'X'.
	lines add: 'Estado: Jugando O'.! !

!TicTacToeLog methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:51:29'!
pushPlayingX: aPosition
	
	self logPosition: aPosition forPlayer: 'O'.
	lines add: 'Estado: Jugando X'.! !

!TicTacToeLog methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:51:35'!
pushXWon: aPosition

	self logPosition: aPosition forPlayer: 'X'.
	lines add: 'Juego terminado - Ganó X!!'.! !


!TicTacToeLog methodsFor: 'logging - private' stamp: 'MI 6/1/2018 15:51:01'!
logPosition: aPosition forPlayer: aPlayer
	
	lines add: aPlayer, ' marcó en ', aPosition printString.! !


!TicTacToeLog methodsFor: 'display' stamp: 'MI 5/31/2018 18:41:42'!
lines

	^ lines! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeLog class' category: #TicTacToeConsole!
TicTacToeLog class
	instanceVariableNames: ''!

!TicTacToeLog class methodsFor: 'instance creation' stamp: 'MI 5/31/2018 18:39:43'!
with: aTicTacToeGame
	
	^ super new initializeWith: aTicTacToeGame! !


!classDefinition: #TicTacToeView category: #TicTacToeConsole!
TicTacToeObserver subclass: #TicTacToeView
	instanceVariableNames: 'rows status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeView methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:07:55'!
pushGameTied: aPosition
	
	self putCharacter: $X atPosition: aPosition.
	status := 'Game Tied!!'.! !

!TicTacToeView methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:07:48'!
pushOWon: aPosition 
	
	self putCharacter: $O atPosition: aPosition.
	status := 'O Won!!'.! !

!TicTacToeView methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:07:38'!
pushPlayingO: aPosition

	self putCharacter: $X atPosition: aPosition.
	status := 'Playing O'.
	

	! !

!TicTacToeView methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:07:25'!
pushPlayingX: aPosition

	self putCharacter: $O atPosition: aPosition.
	status := 'Playing X'.
	

	! !

!TicTacToeView methodsFor: 'notifications' stamp: 'MI 6/1/2018 15:07:16'!
pushXWon: aPosition

	self putCharacter: $X atPosition: aPosition.
	status := 'X Won!!'.! !


!TicTacToeView methodsFor: 'instance initialization' stamp: 'MI 6/1/2018 14:46:40'!
initializeWith: aTicTacToeGame

	aTicTacToeGame attach: self.
	rows := Array with: ' | | ' copy with: ' | | ' copy with: ' | | ' copy.
	status := 'Playing X'.! !


!TicTacToeView methodsFor: 'display' stamp: 'MI 6/1/2018 14:18:20'!
lines

	| lines | 
	
	lines := OrderedCollection new.
	lines add: (rows at: 1).
	lines add: '-----'.
	lines add: (rows at: 2).
	lines add: '-----'.
	lines add: (rows at: 3).
	lines add: status.
	
	^ lines! !


!TicTacToeView methodsFor: 'view - private' stamp: 'MI 6/1/2018 15:06:39'!
putCharacter: aCharacter atPosition: aPosition

	(rows at: aPosition y) at: 2 * aPosition x - 1 put: aCharacter.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeView class' category: #TicTacToeConsole!
TicTacToeView class
	instanceVariableNames: ''!

!TicTacToeView class methodsFor: 'as yet unclassified' stamp: 'MI 6/1/2018 14:16:02'!
with: aTicTacToeGame
	
	^ self new initializeWith: aTicTacToeGame! !


!classDefinition: #TicTacToeState category: #TicTacToeConsole!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToeConsole!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToeConsole!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToeConsole!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!GameTied methodsFor: 'as yet unclassified' stamp: 'MI 5/31/2018 21:08:53'!
messageToBroadcast
	
	^ #pushGameTied:! !


!classDefinition: #PlayerOWon category: #TicTacToeConsole!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!PlayerOWon methodsFor: 'as yet unclassified' stamp: 'MI 5/31/2018 21:03:56'!
messageToBroadcast

	^ #pushOWon:! !


!classDefinition: #PlayerXWon category: #TicTacToeConsole!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!PlayerXWon methodsFor: 'as yet unclassified' stamp: 'MI 5/31/2018 21:00:18'!
messageToBroadcast
	
	^ #pushXWon:! !


!classDefinition: #PlayingState category: #TicTacToeConsole!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToeConsole!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!PlayingO methodsFor: 'as yet unclassified' stamp: 'MI 5/31/2018 20:42:59'!
messageToBroadcast

	^ #pushPlayingO:! !


!classDefinition: #PlayingX category: #TicTacToeConsole!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeConsole'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!PlayingX methodsFor: 'as yet unclassified' stamp: 'MI 5/31/2018 20:42:15'!
messageToBroadcast

	^ #pushPlayingX:! !
