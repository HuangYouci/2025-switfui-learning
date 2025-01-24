let 警察電話 = "110"
let 消防隊電話 = "119"
let 家暴電話 = "113"

var 電話簿: Array<String> = []

電話簿.append(警察電話)
print(電話簿)

電話簿.append(消防隊電話)
print(電話簿)

電話簿.insert(家暴電話, at: 0)
print(電話簿)

print(電話簿.joined(separator: ", "))
