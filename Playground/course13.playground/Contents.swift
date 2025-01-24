for number in 0...5 {
    print(number)
}

let 輪班人員 = ["小花","小菜","小米"]
let 每日流程 = ["打掃","整理檔案","出餐"]

for 人 in 輪班人員{
    for 工作 in 每日流程{
        print("\(人) 現在要做 \(工作)")
    }
}

let 失火了: Bool = false

輪班: for 人 in 輪班人員{
    流程: for 工作 in 每日流程{
        print("\(人) 現在要做 \(工作)")
        if (失火了) { break 輪班 }
    }
}

let numbers: Array<Int> = [5,4,3,2,1]

for index in numbers.indices {
    if 3 == numbers[index] {
        print("3 在 number[\(index)]")
    }
}
