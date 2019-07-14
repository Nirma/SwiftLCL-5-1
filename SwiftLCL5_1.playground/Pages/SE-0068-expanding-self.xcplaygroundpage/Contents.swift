//: [Previous](@previous)

/*:
 # `Self` & You
`Self` can now be used to refer to the dynamic type when used inside of `class`, `enum` and `struct`s.
 This will come in very handy when using generics since instead of typing `Type<T>` everytime one wishes to reference the
 dynamic type of self they can just type `Self` (with a big S )
 */

struct Foo<T> {
    
    //: This is the same as the copy below, except more straightforward using only the keyword `Self`
    func copy() -> Self {
        return self
    }
    
    //: This is the same as the above except we have to repeat ourselves by specifying the generic parameter again
    func _copy() -> Foo<T> {
        return self
    }
}

//: [Next](@next)
