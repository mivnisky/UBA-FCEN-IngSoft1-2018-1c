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

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 17:21:43'!
test03canListEmptyCart

	| bookstore cartId response |
	
	bookstore _ Bookstore initialize.
	cartId _ (bookstore createCartWithClientId: 0101 andPassword: 'pass') y.
	response _ bookstore listCart: cartId.
	
	self assert: response x = 0.
	self assert: response y isEmpty.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 17:50:26'!
test04cannotListACartThatDoesntExist

	| bookstore response |
	
	bookstore _ Bookstore initialize.
	response _ bookstore listCart: 3.
	
	self assert: response x = 1.
	self assert: response y = CartsApi cartDoesntExistErrorMessage.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 17:48:23'!
test05canAddBookToCatalogue

	| bookstore book |
	
	book _ Book with: '0-201-63361-2'.
	bookstore _ Bookstore initialize.
	bookstore addBook: book.! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 17:48:33'!
test06canAddAvailableBookToCart

	| bookstore book cartId response cartList |
	
	book _ Book with: '0-201-63361-2'.	
	bookstore _ Bookstore initialize.
	bookstore addBook: book.
	cartId _ (bookstore createCartWithClientId: 0101 andPassword: 'pass') y.
	response _ bookstore addToCart: cartId theBook: book thisManyCopies: 6.
	cartList _ bookstore listCart: cartId.
	
	self assert: response x = 0.
	self assert: response y = 'OK'.
	self assert: cartList x = 0.
	self assert: cartList y size = 1.
	self assert: (cartList y at: 1) x = 6.
	self assert: (cartList y at: 1) y isbn = '0-201-63361-2'.
	! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 18:29:43'!
test07cannotAddNotAvailableBookToCart

	| bookstore book cartId response cartList |
	
	book _ Book with: '0-201-63361-2'.	
	bookstore _ Bookstore initialize.
	cartId _ (bookstore createCartWithClientId: 0101 andPassword: 'pass') y.
	response _ bookstore addToCart: cartId theBook: book thisManyCopies: 6.
	cartList _ bookstore listCart: cartId.
	
	self assert: response x = 1.
	self assert: response y = CartsApi bookNotAvailableErrorMessage.
	self assert: cartList x = 0.
	self assert: cartList y isEmpty.	! !

!BookstoreTest methodsFor: 'testing' stamp: 'MI 6/6/2018 18:32:48'!
test08cannotAddNegativeQuantityToCart

	| bookstore book cartId response cartList |
	
	book _ Book with: '0-201-63361-2'.	
	bookstore _ Bookstore initialize.
	bookstore addBook: book.
	cartId _ (bookstore createCartWithClientId: 0101 andPassword: 'pass') y.
	response _ bookstore addToCart: cartId theBook: book thisManyCopies: -1.
	cartList _ bookstore listCart: cartId.
	
	self assert: response x = 1.
	self assert: response y = CartsApi negativeQuantityErrorMessage.
	self assert: cartList x = 0.
	self assert: cartList y isEmpty.	! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'MI 6/6/2018 15:41:00'!
with: aBookISBN

	isbn := aBookISBN.! !


!Book methodsFor: 'as yet unclassified' stamp: 'MI 6/6/2018 17:45:11'!
isbn

	^ isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #TusLibros!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'MI 6/6/2018 15:40:08'!
with: aBookISBN

	^ self new with: aBookISBN! !


!classDefinition: #BooksApi category: #TusLibros!
Object subclass: #BooksApi
	instanceVariableNames: 'booksDB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BooksApi methodsFor: 'initialization' stamp: 'MI 6/6/2018 16:25:08'!
initialize

	booksDB _ Set new.! !


!BooksApi methodsFor: 'dbAccess' stamp: 'MI 6/6/2018 16:06:11'!
addBook: aBook

	booksDB add: aBook! !

!BooksApi methodsFor: 'dbAccess' stamp: 'MI 6/6/2018 17:38:48'!
checkBookAvailability: aBook

	^ booksDB includes: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooksApi class' category: #TusLibros!
BooksApi class
	instanceVariableNames: ''!

!BooksApi class methodsFor: 'instance creation' stamp: 'MI 6/6/2018 16:25:30'!
newApi
	
	^ self new initialize! !


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


!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 16:51:17'!
addBook: aBook

	catalogue addBook: aBook! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 18:26:59'!
addToCart: aCartId theBook: aBook thisManyCopies: aQuantity
	
	^ [ carts addToCart: aCartId theBook: aBook thisManyCopies: aQuantity ] on: Error do: [ :error | 1@(error messageText) ] ! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 17:38:21'!
checkBookAvailability: aBook

	^ catalogue checkBookAvailability: aBook.! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 18:37:26'!
createCartWithClientId: aClientId andPassword: aPassword
	
	^ carts createCartWithClientId: aClientId andPassword: aPassword.! !

!Bookstore methodsFor: 'interface' stamp: 'MI 6/6/2018 18:27:07'!
listCart: aCartId
	
	^ [ carts listCart: aCartId ] on: Error do: [ :error | 1@(error messageText)]! !

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

!CartsApi methodsFor: 'interface' stamp: 'MI 6/6/2018 18:35:37'!
addToCart: aCartId theBook: aBook thisManyCopies: aQuantity

	| cart oldQuantity |
	
	(aQuantity <= 1) ifTrue: [ self error: self class negativeQuantityErrorMessage ].
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