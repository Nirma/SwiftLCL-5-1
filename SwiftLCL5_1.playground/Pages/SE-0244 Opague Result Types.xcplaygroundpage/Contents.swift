
/*:
 
 # Opaque Result Types
 
 ![SE-0244](https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md) describes the conecpt
 of using "Opaque" reuslt types.
 This in layman's terms means "returning a protocol" instead of returning a concrete type.
 As long as the object being returned by the function conforms to the `protocol` specified then everything
 checks out and the code should compile and run as expected.
 
 An example of such can be found below:
 */

protocol TalkingHead {
    func say() -> String
}

struct Bratty: TalkingHead {
    func say() -> String {
        return "This is so dangerous!"
    }
}

struct Catty: TalkingHead {
    func say() -> String {
        return "I know right!"
    }
}


func gimmeATalkingHead() -> some TalkingHead {
    return Bratty()
}

gimmeATalkingHead().say()

