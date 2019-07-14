
/*:
 
 # [Opaque Result Types SE-0244](https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md)
 
  describes the conecpt
 of using "Opaque" reuslt types.
 This in layman's terms means "returning a type confroming to a protocol" instead of returning a concrete type.
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

func gimmieAnotherOne() -> some TalkingHead {
    return Catty()
}

gimmeATalkingHead().say()


/*:
 A good reason for why this would be useful would be abstracting away non critical details in API design.
 If the author of a library wants to change a fundamental underlaying type or implementation detail of the underlaying type
 They can do so without any negative side effects of breaking changes, as long as the protocol that the type conforms to does not change.
 Thus the API designer can hide implementation details and reveal just enough detail necessary for the user to beable to leverage the library.
 */

//: [Next](@next)
