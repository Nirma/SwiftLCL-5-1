//: [Previous](@previous)

/*:
 # They finally fixed `enums` wrapped in optionals!
 This isn't a big change, but it is very welcomed because it will remove the need to write redundant code like this:
 
 */

enum SentryMode {
    case armed
    case unarmed
    case shouldBeUnarmedButNotReallySure
}

var mode: SentryMode? = .shouldBeUnarmedButNotReallySure

if let mode = mode {
    switch mode {
    case .armed:
        print("Open the door slowly")
    case .unarmed:
        print("should be safe")
    case .shouldBeUnarmedButNotReallySure:
        print("Not... a good idea but it could work out just fine.")
    }
} else {
    print("no data")
}

/*:
 Now it is implied that when a `switch` is used on an enum thats wrapped in an optional, its not the `.some` or `.none` you are after
 but the value wrapped inside that is of importance.
 Because the `enum` is an optional the possibility of the value being `.none` is still present, therefore for the switch to be exhaustive the case for `.none`
 must still be present.
 
 From here on out you can juse call the `switch` statement on the optional enum variable directly! (Don't forget to add the `case` for .none )
 */

switch mode {
case .armed:
    print("Open the door slowly")
case .unarmed:
    print("should be safe")
case .shouldBeUnarmedButNotReallySure:
    print("Not... a good idea but it could work out just fine.")
case .none:
    print("no data")
}
