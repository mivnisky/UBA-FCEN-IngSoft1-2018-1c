!classDefinition: #Cart category: #Library!
Object subclass: #Cart
	instanceVariableNames: 'books timestamp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

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

!classDefinition: 'Cart class' category: #Library!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'serialization' stamp: 'NDC 6/5/2018 19:53:51'!
deserializeCart: aSerializedCart
	
	^aSerializedCart copy.! !


!Cart class methodsFor: 'initialization' stamp: 'NDC 6/5/2018 19:28:41'!
newEmprtyCart
	
	^self new initialize.! !


!classDefinition: #CartsApi category: #Library!
Object subclass: #CartsApi
	instanceVariableNames: 'cartsDB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!CartsApi methodsFor: 'interface' stamp: 'NDC 6/6/2018 02:38:20'!
addToCart: aCartId theBook: aBookIsbn thisManyCopies: aQuantity

    | cart oldQuantity |
	
    cart := self fetchCart: aCartId.
    oldQuantity := cart books at: aBookIsbn ifAbsent: 0.
    cart books at: aBookIsbn put: oldQuantity + aQuantity.
    self saveCart: cart withId: aCartId.
    ^0@'OK'.! !

!CartsApi methodsFor: 'interface' stamp: 'NDC 6/6/2018 02:50:52'!
createCartWithClientId: aClientId andPassword: aPassword

    | newId |
	
	newId := cartsDB size.
	
     self saveCart: (Cart newEmprtyCart serialize) withId: newId.

     ^0@newId! !

!CartsApi methodsFor: 'interface' stamp: 'NDC 6/5/2018 20:06:06'!
listCart: aCartId

    | cart |
	
    cart := self fetchCart: aCartId.
    ^0@(cart books printString).! !


!CartsApi methodsFor: 'initialization' stamp: 'NDC 6/6/2018 02:40:52'!
initialize
	
    cartsDB := Dictionary new.! !


!CartsApi methodsFor: 'dbAccess' stamp: 'NDC 6/6/2018 02:40:23'!
fetchCart: aCartId
	
    ^Cart deserializeCart: (cartsDB at: aCartId).! !

!CartsApi methodsFor: 'dbAccess' stamp: 'NDC 6/6/2018 02:40:02'!
saveCart: cart withId: aCartId
	
    cartsDB at: aCartId put: (cart serialize)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartsApi class' category: #Library!
CartsApi class
	instanceVariableNames: ''!

!CartsApi class methodsFor: 'initialization' stamp: 'NDC 6/6/2018 02:35:49'!
initializeNewApi
	
	^self new initialize.! !


!classDefinition: #Library category: #Library!
Object subclass: #Library
	instanceVariableNames: 'carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Library'!

!Library methodsFor: 'initialization' stamp: 'NDC 6/6/2018 02:35:21'!
initialize
	carts _ CartsApi initializeNewApi.! !


!Library methodsFor: 'interface' stamp: 'NDC 6/5/2018 18:18:03'!
addToCart: aCartId theBook: aBookIsbn thisManyCopies: aQuantity
	
	^carts addToCart: aCartId theBook: aBookIsbn thisManyCopies: aQuantity.! !

!Library methodsFor: 'interface' stamp: 'NDC 6/5/2018 18:14:41'!
createCartWithClientId: aClientId andPassword: aPassword
	
	^carts createCartWithClientId: aClientId andPassword: aPassword.! !

!Library methodsFor: 'interface' stamp: 'NDC 6/5/2018 18:19:26'!
listCart: aCartId
	
	^carts listCart: aCartId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Library class' category: #Library!
Library class
	instanceVariableNames: ''!

!Library class methodsFor: 'initialization' stamp: 'NDC 6/5/2018 18:28:07'!
initialize
	
     ^self new initialize.! !

Library initialize!