print("Int 最大值", Int.max)
print("Int 最小值", Int.min)
print("Int8 最大值", Int8.max)
print("Int8 最小值", Int8.min)
print("Int16 最大值", Int16.max)
print("Int16 最小值", Int16.min)
print("Int32 最大值", Int32.max)
print("Int32 最小值", Int32.min)

import Foundation

    let decimal1: Decimal = 3.24
    print(decimal1)
    
    let decimal2 = Decimal(3.24)
    print(decimal2)

    // 以上兩種都會有錯誤：轉型態誤差
    // 把二進位轉到十進位的誤差

    let decimal3: Decimal = Decimal(string: "3.24")!
    print(decimal3)
