//
//  deptListModel.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftUI
import Combine

/// deptListModel：單一科系的結構

struct deptListModel: Identifiable {
    // Custom Data: Need to be calculated
    var passChance: Double = 0
    // Custom Data: Fetch from css file
    var id: String { departmentCode }  // 假設學校代碼是唯一的
    var fullName: String { schoolName + departmentName }
    // CSS File
    var schoolCode: String
    var schoolName: String
    var departmentCode: String
    var departmentName: String
    var departmentAbbreviation: String
    var departmentType: String
    var genderRequirement: String
    var practicalExam: String
    var notifyOrAnnounceExam: String
    var documentSubmissionDeadline: String
    var examStartDate: String
    var examEndDate: String
    var examDate1: String
    var examDate2: String
    var examDate3: String
    var announcementDate: String
    var reviewDate: String
    var chineseTest: String
    var englishTest: String
    var mathATest: String
    var mathBTest: String
    var socialTest: String
    var scienceTest: String
    var englishListeningTest: String
    var chineseMultiplier: String
    var englishMultiplier: String
    var mathAMultiplier: String
    var mathBMultiplier: String
    var socialMultiplier: String
    var scienceMultiplier: String
    var customSubjectCombination: String
    var customSubjectCombinationMultiplier: String
    var sameLevelScoreExcessSelectionOrder1: String
    var sameLevelScoreExcessSelectionOrder2: String
    var sameLevelScoreExcessSelectionOrder3: String
    var sameLevelScoreExcessSelectionOrder4: String
    var programmingConceptTest: String
    var programmingConceptTestMultiplier: String
    var programmingPracticalTest: String
    var programmingPracticalTestMultiplier: String
    var chineseScoreCalculation: String
    var englishScoreCalculation: String
    var mathAScoreCalculation: String
    var mathBScoreCalculation: String
    var socialScoreCalculation: String
    var scienceScoreCalculation: String
    var selectionScoreRatio: String
    var designatedItem1: String
    var designatedItem2: String
    var designatedItem3: String
    var designatedItem4: String
    var designatedItem5: String
    var designatedItem6: String
    var designatedItem1Test: String
    var designatedItem2Test: String
    var designatedItem3Test: String
    var designatedItem4Test: String
    var designatedItem5Test: String
    var designatedItem6Test: String
    var designatedItem1ScoreRatio: String
    var designatedItem2ScoreRatio: String
    var designatedItem3ScoreRatio: String
    var designatedItem4ScoreRatio: String
    var designatedItem5ScoreRatio: String
    var designatedItem6ScoreRatio: String
    var tieBreakerOrder1: String
    var tieBreakerOrder2: String
    var tieBreakerOrder3: String
    var tieBreakerOrder4: String
    var examFee: String
    var document1: String
    var document2: String
    var document3: String
    var document4: String
    var document5: String
    var document6: String
    var documentDescription: String
    var designatedItemDescription: String
    var remarks: String
    var enrollmentQuota: String
    var maleEnrollmentQuota: String
    var femaleEnrollmentQuota: String
    var indigenousAdditionalQuota: String
    var outlyingIslandAdditionalQuota: String
    var outlyingIslandAdditionalQuotaDescription: String
    var visionProgramAdditionalQuota: String
    var expectedExamCount: String
    var practicalExamItem1Test: String
    var practicalExamItem2Test: String
    var practicalExamItem3Test: String
    var practicalExamItem4Test: String
    var practicalExamItem5Test: String
    var practicalExamItem1Multiplier: String
    var practicalExamItem2Multiplier: String
    var practicalExamItem3Multiplier: String
    var practicalExamItem4Multiplier: String
    var practicalExamItem5Multiplier: String
    var practicalExamItem1ScoreCalculation: String
    var practicalExamItem2ScoreCalculation: String
    var practicalExamItem3ScoreCalculation: String
    var practicalExamItem4ScoreCalculation: String
    var practicalExamItem5ScoreCalculation: String
    var practicalExamScoreRatio: String
    var testResult: String
}

/// 本 Class 用於載入所有科系以及讀取使用者分數

class DeptDataModel: ObservableObject {
    
    @Published var departments: [deptListModel] = []
    
    init() {
        self.departments = loadCSVData()
    }

    /// 載入使用者成績資料並計算通過率
    
    func loadGradeData(gradeCH: Int = 0, gradeEN: Int = 0, gradeMA: Int = 0, gradeMB: Int = 0, gradeSC: Int = 0, gradeSO: Int = 0, gradeEL: Int = 0, gradePC: Int = 0, gradePP: Int = 0, gradeSK1: Int = 0, gradeSK2: Int = 0, gradeSK3: Int = 0, gradeSK4: Int = 0, gradeSK5: Int = 0, gradeSKT: Int = 0, testResult: String = "--") {
        
        let data = gradeData(
            gradeCH: gradeCH,
            gradeEN: gradeEN,
            gradeMA: gradeMA,
            gradeMB: gradeMB,
            gradeSC: gradeSC,
            gradeSO: gradeSO,
            gradeEL: gradeEL,
            gradePC: gradePC,
            gradePP: gradePP,
            gradeSK1: gradeSK1,
            gradeSK2: gradeSK2,
            gradeSK3: gradeSK3,
            gradeSK4: gradeSK4,
            gradeSK5: gradeSK5,
            gradeSKT: gradeSKT
        )

        
        for i in departments.indices {
            departments[i].passChance = deptListFunc.calPassChance(testResult: departments[i].testResult, data: data)
        }
    }
    
}
