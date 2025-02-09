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

    
}
