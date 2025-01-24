var setA: Set<String> = ["蘋果", "香蕉", "鳳梨"]
var setB: Set<String> = ["蘋果", "橘子", "柳丁"]

print("setA: \(setA)")
print("setB: \(setB)")
print("setA + setB: \(setA.union(setB))")
print("setA & setB: \(setA.intersection(setB))")
print("setA || setB: \(setA.symmetricDifference(setB))")
print("setA - setB: \(setA.subtracting(setB))")
