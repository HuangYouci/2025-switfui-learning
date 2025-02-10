import Foundation

func calcPassChance(testResult: String = "--", data: UserData, timesCH: String = "0", timesEN: String = "0", timesMA: String = "0", timesMB: String = "0", timesSC: String = "0", timesSO: String = "0", timesMultiple: String = "0") -> [Double] {
    
    var result: [Double] = [0,0,0,0,0,0,0,0,0]
    
    // MARK: 拆解字串為分數
    
    // 目標科目級分 (需要的級分)
    var needCH = 0
    var needEN = 0
    var needMA = 0
    var needMB = 0
    var needSC = 0
    var needSO = 0
    var needExceed = false
    var needMultipleCount = 0
    var needMultiple = 0
    
    // 使用者科目級分 (實際成績)
    let userCH = data.gradeCH
    let userEN = data.gradeEN
    let userMA = data.gradeMA
    let userMB = data.gradeMB
    let userSC = data.gradeSC
    let userSO = data.gradeSO
    var userMultiple = 0
    
    // 轉換 times 變數為 Double，若無法轉換設為 0
    let deptTimesCH = Double(timesCH) ?? 0
    let deptTimesEN = Double(timesEN) ?? 0
    let deptTimesMA = Double(timesMA) ?? 0
    let deptTimesMB = Double(timesMB) ?? 0
    let deptTimesSC = Double(timesSC) ?? 0
    let deptTimesSO = Double(timesSO) ?? 0
    let deptTimesMultiple = Double(timesMultiple) ?? 0
    
    // 如果 testResult 是 "--" 或者 "有"，只設定 needExceed
    if testResult == "--" {
        needExceed = false
    } else if testResult == "有" {
        needExceed = true
    }
    
    // 分割 testResult 字串
    let components = testResult.split(separator: "、")
    
    // 解析每個子字串
    for component in components {
        let parts = component.split(separator: "=")
        
        if parts.count == 2 {
            let subject = String(parts[0]).trimmingCharacters(in: .whitespaces)
            let score = Int(parts[1].trimmingCharacters(in: .whitespaces)) ?? 0
            
            // 科目組合
            if subject.contains("+") {
                let subjects = subject.split(separator: "+")
                needMultiple = score // 記錄這個組合的總分
                needMultipleCount = subjects.count // 記錄科目數量
                
                // 計算使用者的科目總分 (即 userMultiple)
                userMultiple = 0
                for sub in subjects {
                    switch sub {
                    case "國":
                        userMultiple += userCH
                    case "英":
                        userMultiple += userEN
                    case "數A":
                        userMultiple += userMA
                    case "數B":
                        userMultiple += userMB
                    case "自":
                        userMultiple += userSC
                    case "社":
                        userMultiple += userSO
                    default:
                        break
                    }
                }
            } else {
                // 單一科目的情況
                switch subject {
                case "國":
                    needCH = score
                case "英":
                    needEN = score
                case "數A":
                    needMA = score
                case "數B":
                    needMB = score
                case "自":
                    needSC = score
                case "社":
                    needSO = score
                default:
                    break
                }
            }
        }
    }
    
    // 檢查是否有 exceed
    if testResult.contains("有") {
        needExceed = true
    } else if testResult.contains("--") {
        needExceed = false
    }
    
    // MARK: 回傳基本資料：各科差的級分
    /// 回傳的資料是一個 Double Array
    /// [機率], [差國], [差英], [差數Ａ], [差數Ｂ], [差自然], [差社會]. [差總和], [超篩?] 共 9 項

    result[1] = Double(needCH - userCH)   // 差國文
    result[2] = Double(needEN - userEN)   // 差英文
    result[3] = Double(needMA - userMA)   // 差數A
    result[4] = Double(needMB - userMB)   // 差數B
    result[5] = Double(needSC - userSC)   // 差自然
    result[6] = Double(needSO - userSO)   // 差社會
    result[7] = Double(needMultiple - userMultiple) // 差組合
    result[8] = needExceed ? 1.0 : 0.0 // 超篩
    
    // MARK: 計算落點分析
    /// 邏輯
    /// 如果 user 級分高於 need
    /// [級分] 5級 90%、4級80%、3級60%、2級40%、1級20%、剛好10%
    /// [倍數] 高於20倍 +50% 15倍+30% 10倍+15% 8倍+10% 7倍+8% 6倍+5% 5倍+3% 4倍0% 3倍以下-10%
    /// 如果 user 級分低於 need
    /// [級分] 5級 -120%、4級 -100%、3級 -80%、2級 -50%、1級 -25%、剛好 -10%
    /// [倍數]高於20倍 +20% 15倍+10% 10倍+5% 8倍0% 7倍-5% 6倍-10% 5倍-20% 4倍-30% 3倍以下-50%
    /// 計算所有 need 不為 0 的科目（CH, EN, MA, MB, SC, SO）
    /// Multiple 計算時要乘上 MultipleCount，2：80%、3：50%、4：30%
    
    var chance: Double = 0

    // 1. 計算級分差距的影響
    let scoreDiffs = [
        ("CH", needCH, userCH),
        ("EN", needEN, userEN),
        ("MA", needMA, userMA),
        ("MB", needMB, userMB),
        ("SC", needSC, userSC),
        ("SO", needSO, userSO)
    ]

    for (subject, need, user) in scoreDiffs {
        if need != 0 {
            if user > need {
                // user 高於 need
                switch need - user {
                case 5...:
                    chance += 0.90
                case 4:
                    chance += 0.80
                case 3:
                    chance += 0.60
                case 2:
                    chance += 0.40
                case 1:
                    chance += 0.20
                default:
                    chance += 0.10
                }
            } else {
                // user 低於 need
                switch need - user {
                case 5...:
                    chance += -1.20
                case 4:
                    chance += -1.00
                case 3:
                    chance += -0.80
                case 2:
                    chance += -0.50
                case 1:
                    chance += -0.25
                default:
                    chance += -0.10
                }
            }
        }
    }

    // 2. 計算倍數的影響
    let multipleDiffs = [
        (needMultiple, userMultiple, needMultipleCount)
    ]

    for (needMultiple, userMultiple, needMultipleCount) in multipleDiffs {
        if needMultiple != 0 {
            let multiplier = needMultipleCount == 2 ? 0.80 : needMultipleCount == 3 ? 0.50 : needMultipleCount == 4 ? 0.30 : 1.0

            if userMultiple > needMultiple {
                // user 的倍數高於 need
                switch needMultiple - userMultiple {
                case 20...:
                    chance += 0.50 * multiplier
                case 15:
                    chance += 0.30 * multiplier
                case 10:
                    chance += 0.15 * multiplier
                case 8:
                    chance += 0.10 * multiplier
                case 7:
                    chance += 0.08 * multiplier
                case 6:
                    chance += 0.05 * multiplier
                case 5:
                    chance += 0.03 * multiplier
                case 4:
                    chance += 0.00 * multiplier
                default:
                    chance += -0.10 * multiplier
                }
            } else {
                // user 的倍數低於 need
                switch needMultiple - userMultiple {
                case 20...:
                    chance += 0.20 * multiplier
                case 15:
                    chance += 0.10 * multiplier
                case 10:
                    chance += 0.05 * multiplier
                case 8:
                    chance += 0.00 * multiplier
                case 7:
                    chance += -0.05 * multiplier
                case 6:
                    chance += -0.10 * multiplier
                case 5:
                    chance += -0.20 * multiplier
                case 4:
                    chance += -0.30 * multiplier
                default:
                    chance += -0.50 * multiplier
                }
            }
        }
    }

    result[0] = chance
    
    
    // MARK: 回傳
    
    return result
}

struct UserData {
    var gradeCH: Int
    var gradeEN: Int
    var gradeMA: Int
    var gradeMB: Int
    var gradeSC: Int
    var gradeSO: Int
}

let testResult = "國=10、英=12、數A=8、數B=7、社=9、有"
let userData = UserData(gradeCH: 8, gradeEN: 9, gradeMA: 7, gradeMB: 6, gradeSC: 5, gradeSO: 8)

let timesCH = "0.9"
let timesEN = "1.2"
let timesMA = "0.8"
let timesMB = "1.0"
let timesSC = "0.7"
let timesSO = "1.5"
let timesMultiple = "0.5"

let result = calcPassChance(testResult: testResult, data: userData, timesCH: timesCH, timesEN: timesEN, timesMA: timesMA, timesMB: timesMB, timesSC: timesSC, timesSO: timesSO, timesMultiple: timesMultiple)

print(result)
