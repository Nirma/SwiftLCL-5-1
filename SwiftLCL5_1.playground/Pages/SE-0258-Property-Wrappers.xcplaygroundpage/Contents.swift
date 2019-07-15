//: [Previous](@previous)
/*:
 # Property Wrappers SE-0258

 Property wrappers are happy little side effects you can apply to anything that counts as a property.
 If you have done any SwiftUI you have most likely already have seen propert wrappers in the form of `@State`, `@Bindable` and `@Environment`.
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
 
 There is one other thing but it is optional, we will talk about it last.
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
 ```shell
     Log: Value retrieved!
     Log: Value set!
 ```
 */

bar.name
bar.name = "Steve"

/*:
 # Projected Values
 Projected values are optional but they can come in handy when you want to expose more of the API to the user.
 Projected values can be assessed by placing a `$` in front of the variable and it allows you to return something else other than what you return with `wrappedValue`
 Take for example our `AbsoluteValue` example expanded out:
 */

@propertyWrapper
struct AbsoluteValuePlus {
    private var _value: Int
    private(set) var didCorrectLastValue = false
    
    init(initialValue: Int) {
        self._value = initialValue
    }
    
    var wrappedValue: Int {
        get { _value }
        set {
            if newValue < 0 {
                didCorrectLastValue = true
                _value = newValue * -1
            } else {
                didCorrectLastValue = false
                _value = newValue
            }
        }
    }
    
    var projectedValue: Self {
        self
    }
}

struct SomeOtherVector {
    var angle: Double = 0.0
    @AbsoluteValuePlus var magnitude: Int = 1
    
    func didCorrectLastValue() -> Bool {
        $magnitude.didCorrectLastValue
    }
}

var zap = SomeOtherVector(angle: 45.0)
zap.magnitude = 5
zap.didCorrectLastValue()
zap.magnitude = -50
zap.didCorrectLastValue()

/*: You can see here that we are using the projectedValue to accessinternal stateof the property wrapper.
 Pretty handy right?
 */

/*:
 # One more trick
 You can pass in values to property wrappers.
 Here is an expanded example of how to specify the name of the log to write data to.
 
 */

@propertyWrapper
class LoggerPlus<Value> {
    private var value: Value
    private let logName: String
    
    init(initialValue: Value, logName: String) {
        self.logName = logName
        self.value = initialValue
    }
    
    var wrappedValue: Value {
        get {
            print("\(logName) Log: Value retrieved!")
            return value
        }
        set {
            value = newValue
            print("\(logName) Log: Value set!")
        }
    }
}

struct FooPlus {
    @LoggerPlus(logName: "NickLog")
    var name: String = "Joe"
}

var foo2 = FooPlus()

foo2.name = "Bob"




//: [Next](@next)
