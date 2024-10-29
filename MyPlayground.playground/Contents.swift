import UIKit

var greeting = "Hello, playground"

123
0.7
"hello"

var firstname = "Tom"
print(firstname)

// switch case
let chr = "o"
switch chr {
case "a":
    print("This is an a")
case "b", "c":
    print("This is a b or c")
default:
    print("I don't know this letter")
}


// loops
var sum = 0
for counter in 1...5 {
    sum += counter
    print("hello \(counter)")
    print("sum is \(sum)")
}

var counter = 5
while counter > 0 {
    print("\(counter) is greater than zero")
    counter -= 1
}

var counter2 = -5
repeat {
    print("Hello from repeat while loop")
    counter2 -= 1
} while counter2 > 0

// functions

func sum(firstNum a: Int,lastNum b: Int) -> Int {
    return a + b
}
print(sum(firstNum: 20, lastNum: 22))

func sum2(_ a: Int,_ b: Int) -> Int {
    return a + b
}
print(sum2(22, 30))

