//: [Previous](@previous)
/*:
 # Property Wrappers SE-0258
 Property wrappers are happy little side effects you can apply to anything that counts as a property.
 You can use property wrappers similar to decorators in languages like python.
 The most obvious feature of property wrappers is that they reduce boilerplate.
 
 There are countless applications of this new language feature and quite a few examles just in the official Swift Evolition proposal.
 When you have time I highliy suggest you skim through the Swift evoltion proposal ![here](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md)
 
 Lets take a look at how we can make one of the simpliest property wrappers possible and build off of that example.
 
 
 
 
 
 # What do I need to make a property wrapper?
 Two things:
 
 - write `@propertyWrapper` above an `enum`, `class` or struct that you wish to purpose as a property wrapper.
 
 -  provide a computed property named `wrappedValue`
 
 inside of `wrappedValue` is where the true work of the property wrapper happens.
 This is where you can execute code that performs side effects and or possibly modify the proerty upon calling `get` or `set`
 of the property.
 */


/*:
 Lets dive right into making one of the simpliest property wrappers there could ever be, a proerty wrapper that handles absolute values.
 Absolute values are never negative, they usually specify magnitude of something like a Vector so lets leverage property wrappers to
 ensure our magnitute is always positive.
 */

@propertyWrapper
struct AbsoluteValue {
    private var _value: Int
    
    init(initialValue: Int) {
        self._value = initialValue
    }
    
    var wrappedValue: Int {
        get { _value }
        set {
            _value = newValue < 0 ? newValue * -1 : newValue
        }
    }
}

struct Vector {
    var angle: Double = 0.0
    @AbsoluteValue var magnitude: Int = 1
}

var foo = Vector(angle: 45.0)

foo.magnitude = 100
foo.magnitude

foo.magnitude = -99
foo.magnitude


/*:
 As expected our property wrapper kicks in to ensure the magnitude is positive before assignment.
 We wrap the property with this behaviour and it has a direct effect on the property value, but property wrappers
 could also have behaviour that does not effect the property it is wrapping directly like logging behaviour.
 */

/*: # Generic property wrappers and logging example
 */

@propertyWrapper
class Logger<Value> {
    private var value: Value
    
    init(initialValue: Value) {
        self.value = initialValue
    }
    
    var wrappedValue: Value {
        get {
            print("Log: Value retrieved!")
            return value
        }
        set {
            value = newValue
            print("Log: Value set!")
        }
    }
}

struct Foo {
    @Logger var name: String = "Joe"
}

var bar = Foo()


/*:
 The log below should display:
     Log: Value retrieved!
     Log: Value set!
 */

bar.name
bar.name = "Steve"



//: [Next](@next)
