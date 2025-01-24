let dictionary: Dictionary<String, Int> = [:]
let dictionary2 = [String: Int]()

var fruit = ["Apple": 3, "Banana": 10]

fruit["Apple"] = 6
fruit["Grape"] = 15

fruit.updateValue(12, forKey: "Apple")
fruit["Apple", default: 0] += 12

print(fruit)

fruit["Grape"] = nil
print(fruit)

fruit.removeValue(forKey: "Banana")
print(fruit)
