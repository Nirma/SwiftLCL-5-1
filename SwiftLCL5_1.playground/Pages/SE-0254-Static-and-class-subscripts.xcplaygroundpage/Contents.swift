//: [Previous](@previous)

/*:
 # Static and class subscripts SE-0254
 
 This proposal extends the usage of subscripts with subscripting into static or class types.
 The way you do it does not change from before, just as before you could define a type with subscripting capabilities like so:
 */

struct EmployeeTable {
    struct Employee {
        let name: String
        let division: String
    }
    private let employees = [
        Employee(name: "Bob Lazar", division: "S4"),
        Employee(name: "Steve Smith", division: "Groom Lake"),
        Employee(name: "Mike Thigpen", division: "Los Alamos")
    ]
    
    subscript(_ name: String) -> Employee? {
        return employees.filter { $0.name.lowercased() == name.lowercased() }.first
    }
}

let et = EmployeeTable()
let bob = et["bob lazar"]
bob?.division // will return S4


/*:
 Now that static subscripts are allowed the code above could be run without the extra step of creating an object
 because the subscript could be called on the type directly!
 */

struct EmployeeTable2 {
    struct Employee {
        let name: String
        let division: String
    }
    static private let employees = [
        Employee(name: "Bob Lazar", division: "S4"),
        Employee(name: "Steve Smith", division: "Groom Lake"),
        Employee(name: "Mike Thigpen", division: "Los Alamos")
    ]
    
    public static subscript(_ name: String) -> Employee? {
        get {
            return employees.filter { $0.name.lowercased() == name.lowercased() }.first
        }
    }
}

EmployeeTable2["bob lazar"]?.division
//: [Next](@next)
