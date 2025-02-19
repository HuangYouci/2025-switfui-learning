//
//  deptListCSV.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftCSV
import Foundation

/// 讀取科系 CSV 資料

func loadCSVData() -> [deptListModel] {
    guard let url = Bundle.main.url(forResource: "deptList", withExtension: "csv") else {
        fatalError("CSV file not found")
    }
    
    do {
        let csv = try NamedCSV(url: url)
        var deptList: [deptListModel] = []
        
        // Loop through each row and map to `SchoolData` model
        for row in csv.rows {
            let dept = deptListModel(
                schoolCode: row["schoolCode"] ?? "",
                schoolName: row["schoolName"] ?? "",
                departmentCode: row["departmentCode"] ?? "",
                departmentName: row["departmentName"] ?? "",
                departmentAbbreviation: row["departmentAbbreviation"] ?? "",
                departmentType: row["departmentType"] ?? "",
                genderRequirement: row["genderRequirement"] ?? "",
                practicalExam: row["practicalExam"] ?? "",
                notifyOrAnnounceExam: row["notifyOrAnnounceExam"] ?? "",
                documentSubmissionDeadline: row["documentSubmissionDeadline"] ?? "",
                examStartDate: row["examStartDate"] ?? "",
                examEndDate: row["examEndDate"] ?? "",
                examDate1: row["examDate1"] ?? "",
                examDate2: row["examDate2"] ?? "",
                examDate3: row["examDate3"] ?? "",
                announcementDate: row["announcementDate"] ?? "",
                reviewDate: row["reviewDate"] ?? "",
                chineseTest: row["chineseTest"] ?? "",
                englishTest: row["englishTest"] ?? "",
                mathATest: row["mathATest"] ?? "",
                mathBTest: row["mathBTest"] ?? "",
                socialTest: row["socialTest"] ?? "",
                scienceTest: row["scienceTest"] ?? "",
                englishListeningTest: row["englishListeningTest"] ?? "",
                chineseMultiplier: row["chineseMultiplier"] ?? "",
                englishMultiplier: row["englishMultiplier"] ?? "",
                mathAMultiplier: row["mathAMultiplier"] ?? "",
                mathBMultiplier: row["mathBMultiplier"] ?? "",
                socialMultiplier: row["socialMultiplier"] ?? "",
                scienceMultiplier: row["scienceMultiplier"] ?? "",
                customSubjectCombination: row["customSubjectCombination"] ?? "",
                customSubjectCombinationMultiplier: row["customSubjectCombinationMultiplier"] ?? "",
                sameLevelScoreExcessSelectionOrder1: row["sameLevelScoreExcessSelectionOrder1"] ?? "",
                sameLevelScoreExcessSelectionOrder2: row["sameLevelScoreExcessSelectionOrder2"] ?? "",
                sameLevelScoreExcessSelectionOrder3: row["sameLevelScoreExcessSelectionOrder3"] ?? "",
                sameLevelScoreExcessSelectionOrder4: row["sameLevelScoreExcessSelectionOrder4"] ?? "",
                programmingConceptTest: row["programmingConceptTest"] ?? "",
                programmingConceptTestMultiplier: row["programmingConceptTestMultiplier"] ?? "",
                programmingPracticalTest: row["programmingPracticalTest"] ?? "",
                programmingPracticalTestMultiplier: row["programmingPracticalTestMultiplier"] ?? "",
                chineseScoreCalculation: row["chineseScoreCalculation"] ?? "",
                englishScoreCalculation: row["englishScoreCalculation"] ?? "",
                mathAScoreCalculation: row["mathAScoreCalculation"] ?? "",
                mathBScoreCalculation: row["mathBScoreCalculation"] ?? "",
                socialScoreCalculation: row["socialScoreCalculation"] ?? "",
                scienceScoreCalculation: row["scienceScoreCalculation"] ?? "",
                selectionScoreRatio: row["selectionScoreRatio"] ?? "",
                designatedItem1: row["designatedItem1"] ?? "",
                designatedItem2: row["designatedItem2"] ?? "",
                designatedItem3: row["designatedItem3"] ?? "",
                designatedItem4: row["designatedItem4"] ?? "",
                designatedItem5: row["designatedItem5"] ?? "",
                designatedItem6: row["designatedItem6"] ?? "",
                designatedItem1Test: row["designatedItem1Test"] ?? "",
                designatedItem2Test: row["designatedItem2Test"] ?? "",
                designatedItem3Test: row["designatedItem3Test"] ?? "",
                designatedItem4Test: row["designatedItem4Test"] ?? "",
                designatedItem5Test: row["designatedItem5Test"] ?? "",
                designatedItem6Test: row["designatedItem6Test"] ?? "",
                designatedItem1ScoreRatio: row["designatedItem1ScoreRatio"] ?? "",
                designatedItem2ScoreRatio: row["designatedItem2ScoreRatio"] ?? "",
                designatedItem3ScoreRatio: row["designatedItem3ScoreRatio"] ?? "",
                designatedItem4ScoreRatio: row["designatedItem4ScoreRatio"] ?? "",
                designatedItem5ScoreRatio: row["designatedItem5ScoreRatio"] ?? "",
                designatedItem6ScoreRatio: row["designatedItem6ScoreRatio"] ?? "",
                tieBreakerOrder1: row["tieBreakerOrder1"] ?? "",
                tieBreakerOrder2: row["tieBreakerOrder2"] ?? "",
                tieBreakerOrder3: row["tieBreakerOrder3"] ?? "",
                tieBreakerOrder4: row["tieBreakerOrder4"] ?? "",
                examFee: row["examFee"] ?? "",
                document1: row["document1"] ?? "",
                document2: row["document2"] ?? "",
                document3: row["document3"] ?? "",
                document4: row["document4"] ?? "",
                document5: row["document5"] ?? "",
                document6: row["document6"] ?? "",
                documentDescription: row["documentDescription"] ?? "",
                designatedItemDescription: row["designatedItemDescription"] ?? "",
                remarks: row["remarks"] ?? "",
                enrollmentQuota: row["enrollmentQuota"] ?? "",
                maleEnrollmentQuota: row["maleEnrollmentQuota"] ?? "",
                femaleEnrollmentQuota: row["femaleEnrollmentQuota"] ?? "",
                indigenousAdditionalQuota: row["indigenousAdditionalQuota"] ?? "",
                outlyingIslandAdditionalQuota: row["outlyingIslandAdditionalQuota"] ?? "",
                outlyingIslandAdditionalQuotaDescription: row["outlyingIslandAdditionalQuotaDescription"] ?? "",
                visionProgramAdditionalQuota: row["visionProgramAdditionalQuota"] ?? "",
                expectedExamCount: row["expectedExamCount"] ?? "",
                practicalExamItem1Test: row["practicalExamItem1Test"] ?? "",
                practicalExamItem2Test: row["practicalExamItem2Test"] ?? "",
                practicalExamItem3Test: row["practicalExamItem3Test"] ?? "",
                practicalExamItem4Test: row["practicalExamItem4Test"] ?? "",
                practicalExamItem5Test: row["practicalExamItem5Test"] ?? "",
                practicalExamItem1Multiplier: row["practicalExamItem1Multiplier"] ?? "",
                practicalExamItem2Multiplier: row["practicalExamItem2Multiplier"] ?? "",
                practicalExamItem3Multiplier: row["practicalExamItem3Multiplier"] ?? "",
                practicalExamItem4Multiplier: row["practicalExamItem4Multiplier"] ?? "",
                practicalExamItem5Multiplier: row["practicalExamItem5Multiplier"] ?? "",
                practicalExamItem1ScoreCalculation: row["practicalExamItem1ScoreCalculation"] ?? "",
                practicalExamItem2ScoreCalculation: row["practicalExamItem2ScoreCalculation"] ?? "",
                practicalExamItem3ScoreCalculation: row["practicalExamItem3ScoreCalculation"] ?? "",
                practicalExamItem4ScoreCalculation: row["practicalExamItem4ScoreCalculation"] ?? "",
                practicalExamItem5ScoreCalculation: row["practicalExamItem5ScoreCalculation"] ?? "",
                practicalExamScoreRatio: row["practicalExamScoreRatio"] ?? "",
                testResult: row["testResult"] ?? ""
            )
            deptList.append(dept)
        }
        return deptList
    } catch {
        print("Error reading CSV: \(error)")
        return []
    }
}
