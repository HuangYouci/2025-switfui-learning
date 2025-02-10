//
//  deptListFunc.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/9.
//

import Foundation

class deptListFunc {
    
    var data: Data
    
    init(data: Data) {
        self.data = data
    }

    /// 確認檢定有無通過？輸入科目的篩選標準以及用戶資料「data」
    
    static func checkTestPassed(CH: String = "--", EN: String = "--", MA: String = "--", MB: String = "--", SC: String = "--", SO: String = "--", EL: String = "--", data: Data, PC: String = "--", PP: String = "--") -> Bool {
    // 設定對應級分的變數
    var CHLevel = 0
    var ENLevel = 0
    var MALevel = 0
    var MBLevel = 0
    var SCLevel = 0
    var SOLevel = 0
    var ELLevel = 0
    var PCLevel = 0
    var PPLevel = 0
    
    // 根據傳入的標準設定每科的級分
    switch CH {
    case "頂標":
        CHLevel = LevelConstants.CHLevel1
    case "前標":
        CHLevel = LevelConstants.CHLevel2
    case "均標":
        CHLevel = LevelConstants.CHLevel3
    case "後標":
        CHLevel = LevelConstants.CHLevel4
    case "底標":
        CHLevel = LevelConstants.CHLevel5
    default:
        CHLevel = 0 // 代表不篩選
    }
    
    switch EN {
    case "頂標":
        ENLevel = LevelConstants.ENLevel1
    case "前標":
        ENLevel = LevelConstants.ENLevel2
    case "均標":
        ENLevel = LevelConstants.ENLevel3
    case "後標":
        ENLevel = LevelConstants.ENLevel4
    case "底標":
        ENLevel = LevelConstants.ENLevel5
    default:
        ENLevel = 0 // 代表不篩選
    }
    
    switch MA {
    case "頂標":
        MALevel = LevelConstants.MALevel1
    case "前標":
        MALevel = LevelConstants.MALevel2
    case "均標":
        MALevel = LevelConstants.MALevel3
    case "後標":
        MALevel = LevelConstants.MALevel4
    case "底標":
        MALevel = LevelConstants.MALevel5
    default:
        MALevel = 0 // 代表不篩選
    }
    
    switch MB {
    case "頂標":
        MBLevel = LevelConstants.MBLevel1
    case "前標":
        MBLevel = LevelConstants.MBLevel2
    case "均標":
        MBLevel = LevelConstants.MBLevel3
    case "後標":
        MBLevel = LevelConstants.MBLevel4
    case "底標":
        MBLevel = LevelConstants.MBLevel5
    default:
        MBLevel = 0 // 代表不篩選
    }
    
    switch SC {
    case "頂標":
        SCLevel = LevelConstants.SCLevel1
    case "前標":
        SCLevel = LevelConstants.SCLevel2
    case "均標":
        SCLevel = LevelConstants.SCLevel3
    case "後標":
        SCLevel = LevelConstants.SCLevel4
    case "底標":
        SCLevel = LevelConstants.SCLevel5
    default:
        SCLevel = 0 // 代表不篩選
    }
    
    switch SO {
    case "頂標":
        SOLevel = LevelConstants.SOLevel1
    case "前標":
        SOLevel = LevelConstants.SOLevel2
    case "均標":
        SOLevel = LevelConstants.SOLevel3
    case "後標":
        SOLevel = LevelConstants.SOLevel4
    case "底標":
        SOLevel = LevelConstants.SOLevel5
    default:
        SOLevel = 0 // 代表不篩選
    }
    
    switch EL {
    case "A級":
        ELLevel = 1
    case "B級":
        ELLevel = 2
    case "C級":
        ELLevel = 3
    default:
        ELLevel = 4 // 代表不篩選
    }
        
    switch PC {
    case "5級":
        PCLevel = 5
    case "4級":
        PCLevel = 4
    case "3級":
        PCLevel = 3
    case "2級":
        PCLevel = 2
    case "1級":
        PCLevel = 2
    default:
        PCLevel = 0
    }
        
    switch PP {
    case "5級":
        PPLevel = 5
    case "4級":
        PPLevel = 4
    case "3級":
        PPLevel = 3
    case "2級":
        PPLevel = 2
    case "1級":
        PPLevel = 2
    default:
        PPLevel = 0
    }
    
    // 判斷是否通過篩選標準
    return (data.gradeCH >= CHLevel && data.gradeEN >= ENLevel &&
            data.gradeMA >= MALevel && data.gradeMB >= MBLevel &&
            data.gradeSC >= SCLevel && data.gradeSO >= SOLevel &&
            data.gradeEL <= ELLevel && data.gradePC >= PCLevel &&
            data.gradePP >= PPLevel)
}

    /// 篩選倍率
    
    static func sortSubjectsNames(CH: String, EN: String, MA: String, MB: String, SC: String, SO: String, multiple: String, PC: String, PP: String) -> [String] {
        let subjectNames: [String: String] = [
            "CH": "國文", "EN": "英文", "MA": "數Ａ", "MB": "數Ｂ",
            "SC": "自然", "SO": "社會", "multiple": "組合科目", "PC": "程式設計觀念", "PP": "程式設計實作"
        ]
        
        let scores: [String: Double] = [
            "CH": Double(CH) ?? (CH == "--" ? 0 : 0),
            "EN": Double(EN) ?? (EN == "--" ? 0 : 0),
            "MA": Double(MA) ?? (MA == "--" ? 0 : 0),
            "MB": Double(MB) ?? (MB == "--" ? 0 : 0),
            "SC": Double(SC) ?? (SC == "--" ? 0 : 0),
            "SO": Double(SO) ?? (SO == "--" ? 0 : 0),
            "multiple": Double(multiple) ?? (multiple == "--" ? 0 : 0),
            "PC": Double(PC) ?? (PC.isEmpty ? 0 : 0),
            "PP": Double(PP) ?? (PP.isEmpty ? 0 : 0)
        ]
        
        let sortedScores = scores.filter { $0.value > 0 }.sorted { $0.value > $1.value }
        
        var result: [String] = []
        var lastScore: Double? = nil
        var group: [String] = []
        
        for (subject, score) in sortedScores {
            if let last = lastScore, last == score {
                group.append(subjectNames[subject] ?? subject)
            } else {
                if !group.isEmpty {
                    result.append(group.joined(separator: "、"))
                }
                group = [subjectNames[subject] ?? subject]
            }
            lastScore = score
        }
        
        if !group.isEmpty {
            result.append(group.joined(separator: "、"))
        }
        
        return result
    }
    
    static func sortSubjectsScores(
        CH: String, EN: String, MA: String, MB: String, SC: String, SO: String,
        multiple: String, PC: String, PP: String
    ) -> [Double] {
        
        // 先逐步轉換字串為 Double，確保每一步都明確
        let convertedScores: [Double] = [
            Double(CH) ?? 0.0,
            Double(EN) ?? 0.0,
            Double(MA) ?? 0.0,
            Double(MB) ?? 0.0,
            Double(SC) ?? 0.0,
            Double(SO) ?? 0.0,
            Double(multiple) ?? 0.0,
            Double(PC) ?? 0.0,
            Double(PP) ?? 0.0
        ]
        
        // 過濾掉 0，轉換成 Set 來去除重複，最後進行排序
        let filteredScores = convertedScores.filter { $0 > 0 }
        let uniqueSortedScores = Array(Set(filteredScores)).sorted(by: >)
        
        return uniqueSortedScores
    }
    
    /// 下面先放棄XD
    
    
//    static func getTestResultInfo(testResult: String = "--", outputType: Int = 0) -> [String] {
//        // 初始化各科的 need 值
//        var needCH = 0
//        var needEN = 0
//        var needMA = 0
//        var needMB = 0
//        var needSC = 0
//        var needSO = 0
//        var needMultiple = 0
//        var needMultipleCount = 0
//        var needExceed = false  // 超篩旗標
//
//        // 如果 testResult 為 "--" 或 "有"，先設定超篩旗標
//        if testResult == "--" {
//            needExceed = false
//        } else if testResult == "有" {
//            needExceed = true
//        }
//
//        // 拆解 testResult 字串（假設各部分以「、」分隔）
//        let components = testResult.split(separator: "、")
//        for component in components {
//            let parts = component.split(separator: "=")
//            if parts.count == 2 {
//                // 取得科目部分與分數
//                let subjectStr = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                let score = Int(parts[1].trimmingCharacters(in: .whitespaces)) ?? 0
//                
//                if subjectStr.contains("+") {
//                    // 若科目字串包含 "+" 表示為組合科目
//                    let subjects = subjectStr.split(separator: "+")
//                    needMultiple = score
//                    needMultipleCount = subjects.count
//                } else {
//                    // 單一科目，依據科目代碼指定對應的 need 值
//                    switch subjectStr {
//                    case "國":
//                        needCH = score
//                    case "英":
//                        needEN = score
//                    case "數A":
//                        needMA = score
//                    case "數B":
//                        needMB = score
//                    case "自":
//                        needSC = score   // 此處解析 "自" 對應「自然」
//                    case "社":
//                        needSO = score
//                    default:
//                        break
//                    }
//                }
//            }
//        }
//        
//        // 根據 outputType 決定回傳內容
//        if outputType == 0 {
//            // 回傳科目名稱，如果該科目 need 為 0 則回傳 "無"
//            let arr: [String] = [
//                (needCH != 0 ? "國文" : "無"),
//                (needEN != 0 ? "英文" : "無"),
//                (needMA != 0 ? "數A" : "無"),
//                (needMB != 0 ? "數B" : "無"),
//                (needSC != 0 ? "自然" : "無"),
//                (needSO != 0 ? "社會" : "無"),
//                (needMultiple != 0 ? "自設科目組合" : "無"),
//                (needExceed ? "超篩" : "無")
//            ]
//            return arr
//        } else if outputType == 1 {
//            // 回傳各科的 need 級分，如果該科目 need 為 0 則回傳 "無"
//            let arr: [String] = [
//                (needCH != 0 ? "\(needCH)" : "無"),
//                (needEN != 0 ? "\(needEN)" : "無"),
//                (needMA != 0 ? "\(needMA)" : "無"),
//                (needMB != 0 ? "\(needMB)" : "無"),
//                (needSC != 0 ? "\(needSC)" : "無"),
//                (needSO != 0 ? "\(needSO)" : "無"),
//                (needMultiple != 0 ? "\(needMultiple)" : "無"),
//                (needExceed ? "有" : "無")
//            ]
//            return arr
//        } else {
//            // 若 outputType 非 0 或 1，回傳空陣列
//            return []
//        }
//    }


//    static func calcPassChance(testResult: String = "--", data: Data, timesCH: String = "0", timesEN: String = "0", timesMA: String = "0", timesMB: String = "0", timesSC: String = "0", timesSO: String = "0", timesMultiple: String = "0") -> [Double] {
//        
//        var result: [Double] = [0,0,0,0,0,0,0,0,0]
//        
//        // MARK: 拆解字串為分數
//        
//        // 目標科目級分 (需要的級分)
//        var needCH = 0
//        var needEN = 0
//        var needMA = 0
//        var needMB = 0
//        var needSC = 0
//        var needSO = 0
//        var needExceed = false
//        var needMultipleCount = 0
//        var needMultiple = 0
//        
//        // 使用者科目級分 (實際成績)
//        let userCH = data.gradeCH
//        let userEN = data.gradeEN
//        let userMA = data.gradeMA
//        let userMB = data.gradeMB
//        let userSC = data.gradeSC
//        let userSO = data.gradeSO
//        var userMultiple = 0
//        
//        // 轉換 times 變數為 Double，若無法轉換設為 0
//        let deptTimesCH = Double(timesCH) ?? 0
//        let deptTimesEN = Double(timesEN) ?? 0
//        let deptTimesMA = Double(timesMA) ?? 0
//        let deptTimesMB = Double(timesMB) ?? 0
//        let deptTimesSC = Double(timesSC) ?? 0
//        let deptTimesSO = Double(timesSO) ?? 0
//        let deptTimesMultiple = Double(timesMultiple) ?? 0
//        
//        // 如果 testResult 是 "--" 或者 "有"，只設定 needExceed
//        if testResult == "--" {
//            needExceed = false
//        } else if testResult == "有" {
//            needExceed = true
//        }
//        
//        // 分割 testResult 字串
//        let components = testResult.split(separator: "、")
//        
//        // 解析每個子字串
//        for component in components {
//            let parts = component.split(separator: "=")
//            
//            if parts.count == 2 {
//                let subject = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                let score = Int(parts[1].trimmingCharacters(in: .whitespaces)) ?? 0
//                
//                // 科目組合
//                if subject.contains("+") {
//                    let subjects = subject.split(separator: "+")
//                    needMultiple = score // 記錄這個組合的總分
//                    needMultipleCount = subjects.count // 記錄科目數量
//                    
//                    // 計算使用者的科目總分 (即 userMultiple)
//                    userMultiple = 0
//                    for sub in subjects {
//                        switch sub {
//                        case "國":
//                            userMultiple += userCH
//                        case "英":
//                            userMultiple += userEN
//                        case "數A":
//                            userMultiple += userMA
//                        case "數B":
//                            userMultiple += userMB
//                        case "自":
//                            userMultiple += userSC
//                        case "社":
//                            userMultiple += userSO
//                        default:
//                            break
//                        }
//                    }
//                } else {
//                    // 單一科目的情況
//                    switch subject {
//                    case "國":
//                        needCH = score
//                    case "英":
//                        needEN = score
//                    case "數A":
//                        needMA = score
//                    case "數B":
//                        needMB = score
//                    case "自":
//                        needSC = score
//                    case "社":
//                        needSO = score
//                    default:
//                        break
//                    }
//                }
//            }
//        }
//        
//        // 檢查是否有 exceed
//        if testResult.contains("有") {
//            needExceed = true
//        } else if testResult.contains("--") {
//            needExceed = false
//        }
//        
//        // MARK: 回傳基本資料：各科差的級分
//        /// 回傳的資料是一個 Double Array
//        /// [機率], [差國], [差英], [差數Ａ], [差數Ｂ], [差自然], [差社會]. [差總和], [超篩?] 共 9 項
//
//        result[1] = Double(needCH - userCH)   // 差國文
//        result[2] = Double(needEN - userEN)   // 差英文
//        result[3] = Double(needMA - userMA)   // 差數A
//        result[4] = Double(needMB - userMB)   // 差數B
//        result[5] = Double(needSC - userSC)   // 差自然
//        result[6] = Double(needSO - userSO)   // 差社會
//        result[7] = Double(needMultiple - userMultiple) // 差組合
//        result[8] = needExceed ? 1.0 : 0.0 // 超篩
//        
//        // MARK: 計算落點分析
//        /// 邏輯
//        /// **第一步**
//        /// 比較科目（CH, EN, MA, MB, SC, SO），把所有 need 不為 0 的科目 need 級分加入變數 p1n、user 級分加入 p1u
//        /// 現在有 p1n 和 p1u 兩組數值，將 (p1u - p1n) / p1n（p1u和p1n差距比例）存入 var Chance: Double 基礎機率
//        /// 把此時 Chance 的絕對值加入 let p2: Double 中
//        ///
//        /// **第二步**
//        /// 比較科目（CH, EN, MA, MB, SC, SO），該科目 need 不為 0
//        /// 2-1 如果 user 級分高於 need
//        /// [級分] 5級 90%、4級80%、3級60%、2級40%、1級20%、剛好10%（以上）
//        /// [倍數] 高於20倍 +50% 15倍+30% 10倍+15% 8倍+10% 7倍+8% 6倍+5% 5倍+3% 4倍0% 3倍以下-10%
//        /// 例如 高於4級5倍：+80%+3% = +83%，將 Chance 加上 p2 的 83%
//        /// 2-2 如果 user 級分低於 need
//        /// [級分] 5級 -120%、4級 -100%、3級 -80%、2級 -50%、1級 -25%、剛好 -10%（以下）
//        /// [倍數]高於20倍 +20% 15倍+10% 10倍+5% 8倍0% 7倍-5% 6倍-10% 5倍-20% 4倍-30% 3倍以下-50%
//        /// 例如：低於1級20倍：-25%+20% = -5%，將 Chance 加上 p2 的 -5%
//        /// 2-3 如果遇到 Multiple
//        /// Multiple 計算時要乘上 MultipleCount，2：0.8、3：0.5、4：0.3
//        /// 例如：高於 MultipleCount = 4 的 Multiple 6 級、4倍 = (90%+0%)乘以0.3 = 27% 將 Chance 加上 p2 的 27%
//        
//        // ------------- 函數部分 -------------
//        
//        /// 取得單科級分調整 + 倍數調整（依 diff 及 multiplier）
//        func adjustmentForSubject(need: Int, user: Int, multiplier: Double) -> Double {
//            // 若需求為 0，表示該科目不參與計算，直接回傳 0
//            if need == 0 { return 0 }
//            
//            let diff = user - need
//            var gradeAdj: Double = 0
//            var multAdj: Double = 0
//            
//            if diff >= 0 {
//                // 使用者成績高於或等於需求
//                switch diff {
//                case 5...: gradeAdj = 0.90
//                case 4:    gradeAdj = 0.80
//                case 3:    gradeAdj = 0.60
//                case 2:    gradeAdj = 0.40
//                case 1:    gradeAdj = 0.20
//                case 0:    gradeAdj = 0.10
//                default:   gradeAdj = 0.10
//                }
//                // 倍數調整（當 user >= need）
//                if multiplier > 20 {
//                    multAdj = 0.50
//                } else if multiplier > 15 {
//                    multAdj = 0.30
//                } else if multiplier > 10 {
//                    multAdj = 0.15
//                } else if multiplier > 8 {
//                    multAdj = 0.10
//                } else if multiplier > 7 {
//                    multAdj = 0.08
//                } else if multiplier > 6 {
//                    multAdj = 0.05
//                } else if multiplier > 5 {
//                    multAdj = 0.03
//                } else if multiplier > 4 {
//                    multAdj = 0.00
//                } else if multiplier > 3 {
//                    multAdj = -0.10
//                } else {
//                    multAdj = -0.10
//                }
//            } else {
//                // 使用者成績低於需求
//                let diffLow = -diff
//                switch diffLow {
//                case 5...: gradeAdj = -1.20
//                case 4:    gradeAdj = -1.00
//                case 3:    gradeAdj = -0.80
//                case 2:    gradeAdj = -0.50
//                case 1:    gradeAdj = -0.25
//                case 0:    gradeAdj = -0.10
//                default:   gradeAdj = -0.10
//                }
//                // 倍數調整（當 user < need）
//                if multiplier > 20 {
//                    multAdj = 0.20
//                } else if multiplier > 15 {
//                    multAdj = 0.10
//                } else if multiplier > 10 {
//                    multAdj = 0.05
//                } else if multiplier > 8 {
//                    multAdj = 0.00
//                } else if multiplier > 7 {
//                    multAdj = -0.05
//                } else if multiplier > 6 {
//                    multAdj = -0.10
//                } else if multiplier > 5 {
//                    multAdj = -0.20
//                } else if multiplier > 4 {
//                    multAdj = -0.30
//                } else {
//                    multAdj = -0.50
//                }
//            }
//            return gradeAdj + multAdj
//        }
//
//        /// 根據 MultipleCount 取得 Multiple 的權重
//        func getMultipleFactor(multipleCount: Int) -> Double {
//            switch multipleCount {
//            case 2: return 0.8
//            case 3: return 0.5
//            case 4: return 0.3
//            default: return 1.0
//            }
//        }
//
//        
//        // ------------- 第一部份 -------------
//            // 對所有 need 不為 0 的科目累加
//            var p1n = 0
//            var p1u = 0
//            if needCH != 0 { p1n += needCH; p1u += userCH }
//            if needEN != 0 { p1n += needEN; p1u += userEN }
//            if needMA != 0 { p1n += needMA; p1u += userMA }
//            if needMB != 0 { p1n += needMB; p1u += userMB }
//            if needSC != 0 { p1n += needSC; p1u += userSC }
//            if needSO != 0 { p1n += needSO; p1u += userSO }
//            
//            // 基礎機率
//            let baseChance = Double(p1u - p1n) / Double(p1n == 0 ? 1 : p1n)
//            let p2 = abs(baseChance)
//            var chance = baseChance   // 初始 chance
//            
//            // ------------- 第二部份 -------------
//            // 假設每科皆有傳入相應的 multiplier
//            
//            // 對每一科加上調整 (調整值乘以 p2)
//            chance += adjustmentForSubject(need: needCH, user: userCH, multiplier: deptTimesCH) * p2
//            chance += adjustmentForSubject(need: needEN, user: userEN, multiplier: deptTimesEN) * p2
//            chance += adjustmentForSubject(need: needMA, user: userMA, multiplier: deptTimesMA) * p2
//            chance += adjustmentForSubject(need: needMB, user: userMB, multiplier: deptTimesMB) * p2
//            chance += adjustmentForSubject(need: needSC, user: userSC, multiplier: deptTimesSC) * p2
//            chance += adjustmentForSubject(need: needSO, user: userSO, multiplier: deptTimesSO) * p2
//            
//            // 如果有 Multiple，則另外處理：調整值再乘上 MultipleCount 的權重
//            if needMultiple > 0 {
//                let multAdj = adjustmentForSubject(need: needMultiple, user: userMultiple, multiplier: deptTimesMultiple)
//                let factor = getMultipleFactor(multipleCount: needMultipleCount)
//                chance += multAdj * factor * p2
//            }
//
//        result[0] = chance
//        
//        chance += 0.5
//        
//        if chance > 1 {
//            chance = 1
//        }
//        
//        if chance < 0 {
//            chance = 0.01
//        }
//        
//        chance *= 100
//        
//        result[0] = chance
//        
//        // MARK: 回傳
//        
//        return result
//    }
    
}
