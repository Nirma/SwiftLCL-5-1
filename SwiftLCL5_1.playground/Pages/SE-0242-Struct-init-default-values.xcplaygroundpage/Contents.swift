//: [Previous](@previous)

/*:
 # Synthesize default values for the memberwise initializer
 Default struct constructors now observe default values!
 */
    struct Theme {
        var invertedColorScheme: Bool = false
        var fontName: String = "Times New Roman"
    }

    let themeA = Theme()
    let themeB = Theme(fontName: "special font")
    let themeC = Theme(invertedColorScheme: true, fontName: "special font")

/*:
 As you can see providing a default value makes that memeber optional in the constructor.
 In the example uptop no initial values, just one initial value or passing an initial value for all parameters is accepted.
 If a value is absent, the default value defined for it is used.
 */

//: [Next](@next)
