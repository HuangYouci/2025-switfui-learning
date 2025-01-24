let yes = true
let no: Bool = false

Double(10).isEqual(to: 1.1)

let price: Double = 1.1
price.isEqual(to: 1.1)
price.isLess(than: 1.1)
price.isLessThanOrEqualTo(1.1)

let string = "123"
string.isEmpty
string.hasPrefix("1234")
string.hasSuffix("23")
string.contains("12")

let payment = 300.0
let shouldPayShippingFee = payment.isLess(than: 499)

print(shouldPayShippingFee ? "自己付運費" : "免運")
print(shouldPayShippingFee ? "含運總共 \(payment + 60) 元" : "免運 \(payment) 元")

