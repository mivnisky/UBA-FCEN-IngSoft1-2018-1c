!classDefinition: #BookstoreTest category: #TusLibros!
TestCase subclass: #BookstoreTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 17:14:48'!
test01canCreateBookstore

	Bookstore initialize.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 17:20:05'!
test02canAddCartToBookstore

	| bookstore response |
	
	bookstore _ Bookstore initialize.
	response _ bookstore createCartWithClientId: 0101 andPassword: 'pass'.
	
	self assert: response x = 0.
	self assert: response y = 0.
	! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:01:28'!
test03cartsHaveUniqueIDs

	| bookstore idSet |
	
	idSet _ Set new.
	bookstore _ Bookstore initialize.
	(1 to: 10) do: [ :num | idSet add: (bookstore createCartWithClientId: 0101 andPassword: 'pass') y ].
	
	self assert: idSet size = 10.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:01:39'!
test04canListEmptyCart

	| bookstore cartId response |
	
	bookstore _ Bookstore initialize.
	cartId _ (bookstore createCartWithClientId: 0101 andPassword: 'pass') y.
	response _ bookstore listCart: cartId.
	
	self assert: response x = 0.
	self assert: response y isEmpty.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:01:48'!
test05cannotListACartThatDoesntExist

	| bookstore response |
	
	bookstore _ Bookstore initialize.
	response _ bookstore listCart: 3.
	
	self assert: response x = 1.
	self assert: response y = CartsApi cartDoesntExistErrorMessage.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:02:01'!
test06canAddBookToCatalogue

	| bookstore |
	
	bookstore _ Bookstore initialize.
	bookstore registerNewBook: 0201633612.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:03:35'!
test07cannotRegisterInvalidISBN

	| bookstore invalidISBN bookstoreResponse cartResponse cartId |
	
	invalidISBN _ 00001.
	bookstore _ Bookstore initialize.
	bookstoreResponse _ bookstore registerNewBook: invalidISBN.
	cartId _ (bookstore createCartWithClientId: 101 andPassword: 'pass') y.
	cartResponse _ bookstore addToCart: cartId theBook: invalidISBN thisManyCopies: 1.

	self assert: bookstoreResponse x = 1.
	self assert: bookstoreResponse y = BooksApi invalidISBNErrorMessage.
	self assert: cartResponse x = 1.
	self assert: cartResponse y = CartsApi bookNotAvailableErrorMessage.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:03:51'!
test08canAddAvailableBookToCart

	| bookstore cartId response cartList isbn |
	
	isbn _ 0201633612.
	bookstore _ Bookstore initialize.
	bookstore registerNewBook: isbn.
	cartId _ (bookstore createCartWithClientId: 101 andPassword: 'pass') y.
	response _ bookstore addToCart: cartId theBook: isbn thisManyCopies: 6.
	cartList _ bookstore listCart: cartId.
	
	self assert: response x = 0.
	self assert: response y = 'OK'.
	self assert: cartList x = 0.
	self assert: cartList y size = 1.
	self assert: (cartList y at: 1) x = 6.
	self assert: (cartList y at: 1) y = 0201633612.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:04:09'!
test09cannotAddNotAvailableBookToCart

	| bookstore isbn cartId response cartList |
	
	isbn _ 0201633612.
	bookstore _ Bookstore initialize.
	cartId _ (bookstore createCartWithClientId: 101 andPassword: 'pass') y.
	response _ bookstore addToCart: cartId theBook: isbn thisManyCopies: 6.
	cartList _ bookstore listCart: cartId.
	
	self assert: response x = 1.
	self assert: response y = CartsApi bookNotAvailableErrorMessage.
	self assert: cartList x = 0.
	self assert: cartList y isEmpty.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:06:41'!
test10cannotAddInvalidQuantityToCart

	| bookstore isbn cartId response cartList |
	
	isbn _ 0201633612.
	bookstore _ Bookstore initialize.
	bookstore registerNewBook: isbn.
	cartId _ (bookstore createCartWithClientId: 101 andPassword: 'pass') y.
	
	response _ bookstore addToCart: cartId theBook: isbn thisManyCopies: -1.
	
	self assert: response x = 1.
	self assert: response y = CartsApi negativeQuantityErrorMessage.
	
	response _ bookstore addToCart: cartId theBook: isbn thisManyCopies: 0.
	
	self assert: response x = 1.
	self assert: response y = CartsApi negativeQuantityErrorMessage.
	
	cartList _ bookstore listCart: cartId.
	
	self assert: cartList x = 0.
	self assert: cartList y isEmpty.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 23:10:55'!
test11cannotAddBookToACartThatDoesntExist

	| bookstore isbn response |
	
	isbn _ 0201633612.
	bookstore _ Bookstore initialize.
	bookstore registerNewBook: isbn.
	response _ bookstore addToCart: 3 theBook: isbn thisManyCopies: 6.
	
	self assert: response x = 1.
	self assert: response y = CartsApi cartDoesntExistErrorMessage.! !


!classDefinition: #BooksApi category: #TusLibros!
Object subclass: #BooksApi
	instanceVariableNames: 'booksDB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BooksApi methodsFor: 'initialization' stamp: 'MI 6/6/2018 16:25:08'!
initialize

	booksDB _ Set new.! !


!BooksApi methodsFor: 'dbAccess' stamp: 'MI 6/6/2018 17:38:48'!
checkBookAvailability: aBook

	^ booksDB includes: aBook! !

!BooksApi methodsFor: 'dbAccess' stamp: 'MI 6/6/2018 22:24:16'!
registerNewBook: aBookISBN

	(self validateISBN: aBookISBN) ifFalse: [ self error: self class invalidISBNErrorMessage ].
	booksDB add: aBookISBN. 
	^ 0@'OK'! !


!BooksApi methodsFor: 'validation' stamp: 'MI 6/6/2018 22:42:54'!
validateISBN: anISBN
	
	^ (((0 to: 9) inject: 0 into: [ :subtotal :digit | subtotal + (digit + 1 * (anISBN // (10 raisedTo: digit) mod: 10)) ]) mod: 11) = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooksApi class' category: #TusLibros!
BooksApi class
	instanceVariableNames: ''!

!BooksApi class methodsFor: 'instance creation' stamp: 'MI 6/6/2018 16:25:30'!
newApi
	
	^ self new initialize! !


!BooksApi class methodsFor: 'error message' stamp: 'MI 6/6/2018 22:21:27'!
invalidISBNErrorMessage

	^ 'The number provided does not correspond to a valid ISBN'! !


!classDefinition: #Bookstore category: #TusLibros!
Object subclass: #Bookstore
	instanceVariableNames: 'carts catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Bookstore methodsFor: 'initialization' stamp: 'MI 6/6/2018 16:46:49'!
initialize

	carts _ CartsApi newApiWith: self.
	catalogue _ BooksApi newApi.! !


!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 22:54:28'!
addToCart: aCartId theBook: aBook thisManyCopies: aQuantity
	
	^ self handleErrorIfThrowsUponExecutionOf: [ carts addToCart: aCartId theBook: aBook thisManyCopies: aQuantity ]! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 17:38:21'!
checkBookAvailability: aBook

	^ catalogue checkBookAvailability: aBook.! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 18:37:26'!
createCartWithClientId: aClientId andPassword: aPassword
	
	^ carts createCartWithClientId: aClientId andPassword: aPassword.! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 22:54:43'!
listCart: aCartId
	
	^ self handleErrorIfThrowsUponExecutionOf: [ carts listCart: aCartId ]! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 22:54:52'!
registerNewBook: aBookISBN

	^ self handleErrorIfThrowsUponExecutionOf: [ catalogue registerNewBook: aBookISBN ]! !


!Bookstore methodsFor: 'error handling' stamp: 'MI 6/6/2018 22:55:34'!
handleErrorIfThrowsUponExecutionOf: aBlock
	
	^ [ aBlock value ] on: Error do: [ :error | 1@(error messageText) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bookstore class' category: #TusLibros!
Bookstore class
	instanceVariableNames: ''!

!Bookstore class methodsFor: 'instance creation' stamp: 'NDC 6/5/2018 18:28:07'!
initialize
	
     ^self new initialize.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books timestamp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'NDC 6/5/2018 19:14:35'!
initialize
	
	timestamp := Time now.
	books := Dictionary new.! !


!Cart methodsFor: 'accessors' stamp: 'NDC 6/5/2018 19:18:58'!
books
	
	^books! !

!Cart methodsFor: 'accessors' stamp: 'NDC 6/5/2018 19:19:07'!
timestamp
	
	^timestamp! !


!Cart methodsFor: 'serialization' stamp: 'NDC 6/5/2018 19:27:14'!
serialize
	
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'serialization' stamp: 'NDC 6/5/2018 19:53:51'!
deserializeCart: aSerializedCart
	
	^aSerializedCart copy.! !


!Cart class methodsFor: 'initialization' stamp: 'MI 6/6/2018 16:26:28'!
newEmptyCart
	
	^self new initialize.! !


!classDefinition: #CartsApi category: #TusLibros!
Object subclass: #CartsApi
	instanceVariableNames: 'cartsDB bookstore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartsApi methodsFor: 'interface' stamp: 'MI 6/6/2018 22:44:53'!
addToCart: aCartId theBook: aBook thisManyCopies: aQuantity

	| cart oldQuantity |
	
	(aQuantity <= 0) ifTrue: [ self error: self class negativeQuantityErrorMessage ].
	(bookstore checkBookAvailability: aBook) ifFalse: [ self error: self class bookNotAvailableErrorMessage ].
	
	cart _ self fetchCart: aCartId.
	oldQuantity _ cart books at: aBook ifAbsent: 0.
	cart books at: aBook put: oldQuantity + aQuantity.
	self saveCart: cart withId: aCartId.
	^0@'OK'.! !

!CartsApi methodsFor: 'interface' stamp: 'MI 6/6/2018 16:26:55'!
createCartWithClientId: aClientId andPassword: aPassword

    | newId |
	
	newId := cartsDB size.
	
     self saveCart: (Cart newEmptyCart serialize) withId: newId.

     ^0@newId! !

!CartsApi methodsFor: 'interface' stamp: 'MI 6/6/2018 17:43:49'!
listCart: aCartId

    | cart |
	
    cart := self fetchCart: aCartId.

    ^0@(cart books keys collect: [ :book | (cart books at: book)@book ]).! !


!CartsApi methodsFor: 'initialization' stamp: 'MI 6/6/2018 16:49:05'!
initializeWith: aBookstore
	
	cartsDB _ Dictionary new.
	bookstore _ aBookstore.! !


!CartsApi methodsFor: 'dbAccess' stamp: 'MI 6/6/2018 17:52:16'!
fetchCart: aCartId
	
    ^Cart deserializeCart: (cartsDB at: aCartId ifAbsent: [ self error: self class cartDoesntExistErrorMessage ]).! !

!CartsApi methodsFor: 'dbAccess' stamp: 'NDC 6/6/2018 02:40:02'!
saveCart: cart withId: aCartId
	
    cartsDB at: aCartId put: (cart serialize)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartsApi class' category: #TusLibros!
CartsApi class
	instanceVariableNames: ''!

!CartsApi class methodsFor: 'instance creation' stamp: 'MI 6/6/2018 16:47:10'!
newApiWith: aLibrary
	
	^self new initializeWith: aLibrary ! !


!CartsApi class methodsFor: 'error messages' stamp: 'MI 6/6/2018 16:53:09'!
bookNotAvailableErrorMessage

	^ 'This book is not available'! !

!CartsApi class methodsFor: 'error messages' stamp: 'MI 6/6/2018 17:51:07'!
cartDoesntExistErrorMessage

	^ 'This cart does not exist'! !

!CartsApi class methodsFor: 'error messages' stamp: 'MI 6/6/2018 18:33:28'!
negativeQuantityErrorMessage

	^ 'Negative quantity entered'! !

Bookstore initialize!