import Darwin

var x = 10

print("This is the worst \(x) interpolation")

true || false

let pi = "\u{03c0}"

1...10
1..<10


func greatest(a:Int, b:Int) -> Int {
    return [a,b].maxElement()!
}

greatest(4,b: 2)

var arr:[Int] = [1,2,3]

var y = ["a","b","c"]

y.isEmpty

var t = [Int]()

t.isEmpty

for i in y {
    print(i)
}

var cells = [Int](count: 4, repeatedValue: 4)

var dict:[String:Int] = [:]
dict["a"] = 1

dict.keys.first

var coords = (12.12, 31.43, 54.22)

var (a,b, _) = coords

typealias Response = (status:Int, body:String)

func pingSite(url:String) -> Response{
    return (404, "No Content")
}

var result:Response = pingSite("hehe")

print(result)

var numbers = [9,8,7,6,5]

for (idx,value) in numbers.enumerate(){
    print("the element \(value) is present at \(idx)")
}

let response:Response = (404, "OK")

switch response {
case (200..<300, _):
    print("Success codes")
case (400..<500, _):
    print("Application Error")
case(500..<600, _):
    print("Server Error")
default:
    print("dunno what is happening")
}

//Optionals
var maybe:String? = "hello"
var optionalNil:String? = nil
//var notValid:String = nil

if let x = maybe {
    print(x)
}

var testMap = [1:true,2:false]

if let x = testMap[1] {
    var result = x ? "truthy" : "falsy" // optional means not nil and not essentially true
    print(result)
}

if let x = testMap[3] {
    print("key 3 present")
} else {
    print("key 3 not present")
}

// Functions

func addNumbers(firstNum x:Int, secondNum y:Int) -> Int{
    return x + y;
}

func mulNumbers(x:Float, y:Float) -> Float {
    return x * y;
}

addNumbers(firstNum: 4, secondNum: 5)
mulNumbers(1.3, y: 3.4)

func sayHelloToAll(names:String...){
    let all = names.joinWithSeparator(" and ")
    print("Hello \(all)")
}

sayHelloToAll("Eena", "Meena", "Deeka")

func randomNumber(seed:Int) -> Int? {
    return seed % 2 == 0 ? nil : Int(arc4random_uniform(6) + 1)
}

randomNumber(3)
randomNumber(8)

// funtion as param to function

func toLower(str:String) -> String {
    return str.lowercaseString
}

func toUpper(str:String) -> String {
    return str.uppercaseString
}

typealias OneArgStringFunc = (String) -> String

func transformString(str:String, f:OneArgStringFunc) -> String {
    return  f(str)
}

transformString("Humpty Dumpty", f: toUpper)
transformString("Humpty Dumpty", f: toLower)

["star", "wars", "force"].map(toUpper)

func makeCustomGreeter(greeting:String) -> OneArgStringFunc {
    func greeter(str:String) -> String {
        return "\(greeting) \(str)"
    }
    return greeter
}

let italianGreeting = makeCustomGreeter("Ciao")
italianGreeting("Maya")

let frenchGreeting = makeCustomGreeter("Bonjour")
frenchGreeting("Maya")

// Closures

[1,2,3,4,5,6].map({ (n:Int) -> Int in return n * 2 })
[1,2,3,4,5,6].map({ n in n * 2 })

//Trailing Closure

let res = [1,2,3,4,5,6].map() { (n:Int) -> Int in
    let multiplier = Int(arc4random_uniform(6) + 1)
    return n * multiplier
}

res

//Prev func as closure
func makeClosureGreeter(greeting:String) -> OneArgStringFunc {
    return { (str:String) -> String in
        return "\(greeting) \(str)"
    }
}

let tamilGreeting = makeClosureGreeter("Vanakkam")
tamilGreeting("Trisha")

//Classes

class Rectangle {
    var area:Double = 1.0 {
        willSet {
            print("Area: \(area). About to change!")
        }
        didSet {
            print("New Area: \(area)")
        }
    }
    
    func calculateArea(length:Double, breadth:Double) {
        area = length * breadth
    }
}

let rect = Rectangle()
rect.calculateArea(1.4, breadth: 4.2)

// Subscripts

class Switch {
    var states = ["On", "Off", "Busted"]
    subscript(index:Int)  -> String {
        get {
            return states[index]
        }
        set(value) {
            states[index] = value
        }
    }
}

let sw = Switch()
sw[0]
sw[2] = "Stepper"
sw[2]
sw.states

// Constructors & Destructors
class Cylinder {
    var radius = 0.0;
    var height = 0.0;
    init(){}
    init(radius: Double, height: Double){
        self.radius = radius
        self.height = height
    }
    var area:Double {
        return 3.14 * radius * radius * height
    }
    deinit {
        print("Tata Babye Cylinder[\(radius):\(height)]")
    }
}

Cylinder(radius: 2.4, height: 1.5).area
var emptyCylinder:Cylinder? = Cylinder()
emptyCylinder!.area
emptyCylinder = nil

// Inheritance with convenience initiator
class Actor {
    var name:String?
    var greets:String?
    init(name:String, greets: String){
        self.name = name;
        self.greets = greets
    }
    convenience init(name:String){
        self.init(name:name,greets:"Duh!")
    }
    func says() -> String{
        return "\(name!): \(greets!) !Wait Where is my Oscar"
    }
}

class MethodActor : Actor {
    override init(name:String, greets: String){
        super.init(name:name, greets: greets)
    }
    override func says() -> String {
        return "\(name!): \(greets!)! I am the Taxi Driver"
    }
}

let bob = Actor(name: "Bob")
let rob = MethodActor(name: "Robert")
bob.says()
rob.says()

var actors:[Actor] = [bob, rob]

// Enumerators

enum Scale {
    case Fahrenheit
    case Celsius
}

class Thermometer {
    var unit:Scale
    var value:Float;
    
    init(unit:Scale, measurement:Float){
        self.unit = unit
        self.value = measurement
    }
    
    convenience init(measurement:Float){
        self.init(unit:.Fahrenheit, measurement: measurement)
    }
    
    var description:String {
        return "The temperature is \(value) \(unit)"
    }
}

print(Thermometer(measurement: 94.2).description)


//Protocols

protocol Employable {
    var name:String { get } //property requirements
    var degree:String { get }
    init(name:String, degree:String) //init requirements
    func canDoRemote() -> Bool //method requirements
}

class Consultant: Employable {
    var name:String
    var degree:String
    
    required init(name:String, degree:String){
        self.name  = name
        self.degree = degree
    }
    
    func canDoRemote() -> Bool {
        return false
    }
}

var employee = Consultant(name: "John Wick", degree: "Boogeyman")
employee.canDoRemote()
employee.degree

class Company {
    var employees:Employable?
}

//Extensions

extension String {
    var first:Character { return self.characters.first! }
    var last:Character { return self.characters.last! }
}

"applause".first
"applause".last






