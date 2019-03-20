//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Value type example (Enumerations, structures or tuples -   Array, String and Dictionary)
struct S { var data: Int = -1 }
var a = S()
var b = a						// a is copied to b
a.data = 42						// Changes a, not b
print("\(a.data), \(b.data)")	// prints "42, -1"

// Reference type example (Class)
class C { var data: Int = -1 }
var x = C()
var y = x						// x is copied to y
x.data = 42						// changes the instance referred to by x (and y)
print("\(x.data), \(y.data)")	// prints "42, 42"

// Constants and Variables
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

// This is a comment.
/* This is also a comment
 but is written over multiple lines. */

// Integers
print(UInt8.max)
print(UInt16.max)
print(Int.max) //Depends if the device is the 32 or 64 bits

// Boolean
let start = true // true or false

// Typealias
//Define an alternative name for an existing type. You define type aliases with the typealiaskeyword.
typealias AudioSample = UInt16

//Tuples
//Group multiple values into a single compound value. The values within a tuple can be of any type and don’t have to be of the same type as each other.

let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"

//Ignore parts of the tuple with an underscore (_) when you decompose the tuple:
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"

//access the individual element values in a tuple using index numbers starting at zero:

print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"

// You can name the individual elements in a tuple when the tuple is defined:

let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"

/*

 Tuples are particularly useful as the return values of functions. A function that tries to retrieve a web page might return the (Int, String) tuple type to describe the success or failure of the page retrieval. By returning a tuple with two distinct values, each of a different type, the function provides more useful information about its outcome than if it could only return a single value of a single type.
 
*/

// Optionals

/*
 
 You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.
 
*/

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"

var surveyAnswer: String?
// surveyAnswer is automatically set to nil

// If Statements and Forced Unwrapping
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

// Optional Binding
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}
// Prints ""123" has an integer value of 123"

/*
 You can include as many optional bindings and Boolean conditions in a single if statement as you need to, separated by commas. If any of the values in the optional bindings are nil or any Boolean condition evaluates to false, the whole if statement’s condition is considered to be false. The following if statements are equivalent:
*/

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"

// Implicitly Unwrapped Optionals.
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark

/*
 NOTE
 
 Don’t use an implicitly unwrapped optional when there’s a possibility of a variable becoming nil at a later point. Always use a normal optional type if you need to check for a nil value during the lifetime of a variable.
 
*/

// Error Handling
/*
 Error Handling (During execution). Error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.
 
 When a function encounters an error condition, it throws an error That function’s caller can then catch the error and respond appropriately.
*/

func canThrowAnError() throws {
    // this function may or may not throw an error
}

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

//Here’s an example of how error handling can be used to respond to different error conditions:

enum SandwichError {
    case outOfCleanDishes
    case missingIngredients([String])
}

func makeASandwich() throws {
    // ...
}

func eatASandwich() {
    
}

func washDishes() {
    
}

func buyGroceries(ingredients: [String]) {
    
}


do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients: ingredients)
}


// Assertions and Preconditions
/*
Assertions and preconditions are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code.
*/

// Debugging with Assertions

let age = -3
assert(age <= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 is not >= 0.


// operator
let apples = 3
let oranges = 5

print(apples > 3 ? "E" : "B")

if apples > 1 && oranges > 2 {
    
}


// Retain Cycles, Weak and Unowned in Swift
print("-------------------------------")
print("Retain Cycles, Weak and Unowned in Swift")
print("-------------------------------")
class TestClass {

    var testClass: TestClass? = nil

    init() {
        print("init")
    }

    deinit {
        print("deinit")
    }

}

var testClass: TestClass? = TestClass()
testClass = nil


print("-------------------------------")
print("Retain Cycles")
print("-------------------------------")

var testClass1: TestClass? = TestClass()
var testClass2: TestClass? = TestClass()

testClass1?.testClass = testClass2
testClass2?.testClass = testClass1

testClass1 = nil
testClass2 = nil


print("-------------------------------")
print("Weak and Unowned in Swift")
print("-------------------------------")

class TestClassWeak {

    weak var testClass: TestClassWeak? = nil //Now this is a weak reference!

    init() {
        print("init")

    }

    deinit {
        print("deinit")
    }

}

var testClass3: TestClassWeak? = TestClassWeak()
var testClass4: TestClassWeak? = TestClassWeak()

testClass3?.testClass = testClass4
testClass4?.testClass = testClass3

testClass3 = nil
testClass4 = nil

print("-------------------------------")
print("Common scenarios for retain cycles: delegates")
print("-------------------------------")

class ParentViewController: UIViewController, ChildViewControllerProtocol {

    let childViewController = ChildViewController()

    func prepareChildViewController() {

        childViewController.delegate = self
    }

}

protocol ChildViewControllerProtocol: class {

    //important functions...

}

class ChildViewController: UIViewController {

    var delegate: ChildViewControllerProtocol? // weak var delegate: ChildViewControllerProtocol?

}

print("-------------------------------")
print("Common scenarios for retain cycles: closures")
print("-------------------------------")

class TestClassBlock {

    var aBlock: (() -> ())? = nil

    let aConstant = 5


    init() {
        print("init")
        aBlock = {
            print(self.aConstant)
        }
    }

    deinit {
        print("deinit")
    }


}

var testClassBlock: TestClassBlock? = TestClassBlock()
testClassBlock = nil


print("-------------------------------")
print("Closures with weak")
print("-------------------------------")

class TestClassWeakBlock {

    var aBlock: (() -> ())? = nil

    let aConstant = 5


    init() {
        print("init")
        aBlock = { [weak self] in
            print(self?.aConstant as Any)
        }
    }

    deinit {
        print("deinit")
    }


}

var testClassWeakBlock: TestClassWeakBlock? = TestClassWeakBlock()
testClassWeakBlock = nil

print("-------------------------------")
print("Closures sdk apple")
print("-------------------------------")
class TestClassAnimate {

    let aConstant = 5

    init() {
        print("init")
    }

    deinit {
        print("deinit")
    }

    func doSomething() {
        UIView.animate(withDuration: 5) {

            let aConstant = self.aConstant

            //fancy animation...
        }
    }


}

var testClassAnimate: TestClassAnimate? = TestClassAnimate()
testClassAnimate?.doSomething()
testClassAnimate = nil

print("-------------------------------")
print("Closures with unowned")
print("-------------------------------")

class TestClassUnowned {

    var aBlock: (() -> ())? = nil

    let aConstant = 5


    init() {
        print("init")
        aBlock = { [unowned self] in
            print(self.aConstant)
        }
    }

    deinit {
        print("deinit")
    }


}

var testClassUnowned: TestClassUnowned? = TestClassUnowned()
testClassUnowned = nil

// https://stackoverflow.com/questions/24468336/how-to-correctly-handle-weak-self-in-swift-blocks-with-arguments
