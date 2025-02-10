//
//  DeptDetailView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DeptDetailView: View {
    
    @EnvironmentObject var data: Data
    
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    
    var department: deptListModel
    
    var body: some View {
        
        var totalAdditionalQuota: Int {
                (Int(department.indigenousAdditionalQuota) ?? 0) +
                (Int(department.outlyingIslandAdditionalQuota) ?? 0) +
                (Int(department.visionProgramAdditionalQuota) ?? 0)
            }
        
        VStack {
            HStack{
                
                VStack(alignment: .leading){
                    Text(department.schoolName)
                        .font(.subheadline)
                    Text(department.departmentName)
                        .font(.title2)
                        .bold()
                }
                
                Spacer()
                
                if department.departmentType != "一般" {
                    Text(department.departmentType)
                        .foregroundColor(Color.white)
                        .padding(5)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                
                Text(department.id)
                    .font(.system(.body, design: .monospaced))
                    .padding(5)
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
            }
            .padding()
            
            Divider()
            
            ScrollView {
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "info.circle")
                        Text("招生名額")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    HStack{
                        Text("甄試人數")
                        Spacer()
                        Text("共")
                        Text(department.expectedExamCount)
                            .bold()
                        Text("人")
                    }
                    
                    HStack{
                        Text("錄取人數")
                        Spacer()
                        if (department.genderRequirement == "女" || department.genderRequirement == "男") {
                            Text("限\(department.genderRequirement)性")
                        }
                        
                        Text("共")
                        Text(department.enrollmentQuota)
                            .bold()
                        Text("人")
                        
                    }
                    
                    if ( Int(department.maleEnrollmentQuota) ?? 0 > 0 ) {
                        HStack{
                            Text("男性錄取名額")
                                .padding(.leading)
                            Spacer()
                            Text(department.maleEnrollmentQuota)
                                .bold()
                            Text("人")
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    
                    if ( Int(department.femaleEnrollmentQuota) ?? 0 > 0 ) {
                        HStack{
                            Text("女性錄取名額")
                                .padding(.leading)
                            Spacer()
                            Text(department.femaleEnrollmentQuota)
                                .bold()
                            Text("人")
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    
                    if totalAdditionalQuota > 0 {
                        HStack{
                            Text("外加名額")
                            Spacer()
                            Text("共")
                            Text("\(totalAdditionalQuota)")
                                .bold()
                            Text("人")
                        }
                    }
                    
                    if ( Int(department.indigenousAdditionalQuota) ?? 0 > 0 ) {
                        HStack{
                            Text("原住民")
                                .padding(.leading)
                            Spacer()
                            Text(department.indigenousAdditionalQuota)
                                .bold()
                            Text("人")
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    
                    if ( Int(department.outlyingIslandAdditionalQuota) ?? 0 > 0 ) {
                        HStack{
                            Text("離島")
                                .padding(.leading)
                            ScrollView(.horizontal){
                                Text(department.outlyingIslandAdditionalQuotaDescription)
                            }
                            .ignoresSafeArea()
                            Spacer()
                            Text(department.outlyingIslandAdditionalQuota)
                                .bold()
                            Text("人")
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    
                    if ( Int(department.visionProgramAdditionalQuota) ?? 0 > 0 ) {
                        HStack{
                            Text("願景")
                                .padding(.leading)
                            Spacer()
                            Text(department.visionProgramAdditionalQuota)
                                .bold()
                            Text("人")
                        }
                        .foregroundColor(Color(.darkGray))
                    }
                    
                }
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(5)
                
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "doc.text.magnifyingglass")
                        Text("第一階段檢定")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    .onTapGesture {
                        sheetExplansion = "只要通過該系所有第一階段檢定之標的，即可選填該系為志願。填入志願序後，仍需進行第一階段篩選倍率比較。本處會顯示所有檢定項目，包含學測科目、術科科目及程設科目。若檢定沒有科目項目，代表本系未設任何檢定標準。"
                        isShowSheet = true
                    }
                    
                    HStack{
                        Grid{
                            GridRow{
                                Text("科目")
                                    .bold()
                                if (department.chineseTest != "--") { Text("國文")
                                }
                                if (department.englishTest != "--") { Text("英文")
                                }
                                if (department.mathATest != "--") { Text("數Ａ")
                                }
                                if (department.mathBTest != "--") { Text("數Ｂ")
                                }
                                if (department.scienceTest != "--") { Text("自然")
                                }
                                if (department.socialTest != "--") { Text("社會")
                                }
                                if (department.englishListeningTest != "--") { Text("英聽")
                                }
                                if (!department.programmingConceptTest.isEmpty) { Text("程設觀念")
                                }
                                if (!department.programmingPracticalTest.isEmpty) { Text("程設實作")
                                }
                                if (!department.practicalExamItem1Test.isEmpty) {
                                    switch department.departmentType {
                                    case "美術":
                                        Text("素描")
                                    case "體育":
                                        Text("體育")
                                    case "音樂":
                                        Text("主修")
                                    default:
                                        Text("術科項目1")
                                    }
                                }
                                if (!department.practicalExamItem2Test.isEmpty) {
                                    switch department.departmentType {
                                    case "美術":
                                        Text("彩繪技法")
                                    case "音樂":
                                        Text("副修")
                                    default:
                                        Text("術科項目2")
                                    }
                                }
                                if (!department.practicalExamItem3Test.isEmpty) {
                                    switch department.departmentType {
                                    case "美術":
                                        Text("創意表現")
                                    case "音樂":
                                        Text("樂理")
                                    default:
                                        Text("術科項目3")
                                    }
                                }
                                if (!department.practicalExamItem4Test.isEmpty) {
                                    switch department.departmentType {
                                    case "美術":
                                        Text("水墨書畫")
                                    case "音樂":
                                        Text("視唱")
                                    default:
                                        Text("術科項目4")
                                    }
                                }
                                if (!department.practicalExamItem5Test.isEmpty) {
                                    switch department.departmentType {
                                    case "美術":
                                        Text("美術鑒賞")
                                    case "音樂":
                                        Text("聽寫")
                                    default:
                                        Text("術科項目5")
                                    }
                                }
                                Spacer()
                            }
                            GridRow{
                                Text("檢定")
                                    .bold()
                                if (department.chineseTest != "--") { Text(department.chineseTest)
                                }
                                if (department.englishTest != "--") { Text(department.englishTest)
                                }
                                if (department.mathATest != "--") { Text(department.mathATest)
                                }
                                if (department.mathBTest != "--") { Text(department.mathBTest)
                                }
                                if (department.scienceTest != "--") { Text(department.scienceTest)
                                }
                                if (department.socialTest != "--") {
                                    Text(department.socialTest)
                                }
                                if (department.englishListeningTest != "--") { Text(department.englishListeningTest)
                                }
                                if ( !department.programmingConceptTest.isEmpty) { Text(department.programmingConceptTest)
                                }
                                if ( !department.programmingPracticalTest.isEmpty ) { Text(department.programmingPracticalTest)
                                }
                                if ( !department.practicalExamItem1Test.isEmpty ) { Text(department.practicalExamItem1Test)
                                }
                                if ( !department.practicalExamItem2Test.isEmpty ) { Text(department.practicalExamItem2Test)
                                }
                                if ( !department.practicalExamItem3Test.isEmpty ) { Text(department.practicalExamItem3Test)
                                }
                                if ( !department.practicalExamItem4Test.isEmpty ) { Text(department.practicalExamItem4Test)
                                }
                                if ( !department.practicalExamItem5Test.isEmpty ) { Text(department.practicalExamItem5Test)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                }
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(5)
                
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "line.3.horizontal.decrease")
                        Text("第一階段篩選")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    let multiplierSubject: [String] = deptListFunc.sortSubjectsNames(CH: department.chineseMultiplier, EN: department.englishMultiplier, MA: department.mathAMultiplier, MB: department.mathBMultiplier, SC: department.scienceMultiplier, SO: department.socialMultiplier, multiple: department.customSubjectCombinationMultiplier, PC: department.programmingConceptTestMultiplier, PP: department.programmingPracticalTestMultiplier)
                    
                    let multiplierScore: [Double] = deptListFunc.sortSubjectsScores(CH: department.chineseMultiplier, EN: department.englishMultiplier, MA: department.mathAMultiplier, MB: department.mathBMultiplier, SC: department.scienceMultiplier, SO: department.socialMultiplier, multiple: department.customSubjectCombinationMultiplier, PC: department.programmingConceptTestMultiplier, PP: department.programmingPracticalTestMultiplier)
                    
                    HStack{
                        Text("科目")
                            .bold()
                        Spacer()
                        Text("倍率")
                            .bold()
                    }
                    .padding(.bottom, 5)
                    
                    ForEach(0..<multiplierSubject.count, id: \.self){ index in
                        HStack{
                            Text(multiplierSubject[index] == "組合科目" ? department.customSubjectCombination : multiplierSubject[index])
                            Spacer()
                            Text("\(String(format: "%.1f", multiplierScore[index]))")
                        }
                    }
                    
                    HStack{
                        Text("超額篩選")
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    
                    if (!department.sameLevelScoreExcessSelectionOrder1.isEmpty) {
                        HStack{
                            Text("1")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            ScrollView(.horizontal){
                                Text(department.sameLevelScoreExcessSelectionOrder1)
                            }
                            Spacer()
                        }
                    }
                    
                    if (!department.sameLevelScoreExcessSelectionOrder2.isEmpty) {
                        HStack{
                            Text("2")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            ScrollView(.horizontal){
                                Text(department.sameLevelScoreExcessSelectionOrder2)
                            }
                            Spacer()
                        }
                    }
                    
                    if (!department.sameLevelScoreExcessSelectionOrder3.isEmpty) {
                        HStack{
                            Text("3")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            ScrollView(.horizontal){
                                Text(department.sameLevelScoreExcessSelectionOrder3)
                            }
                            Spacer()
                        }
                    }
                    
                    if (!department.sameLevelScoreExcessSelectionOrder4.isEmpty) {
                        HStack{
                            Text("4")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            ScrollView(.horizontal){
                                Text(department.sameLevelScoreExcessSelectionOrder4)
                            }
                            Spacer()
                        }
                    }
                    
                }
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(5)
                
                VStack(spacing: 0){
                    
                    HStack{
                        Image(systemName: "list.bullet.circle")
                        Text("第一階段結果")
                        Spacer()
                        Text("113年")
                            .foregroundColor(Color(.systemGray2))
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    VStack{
                        
                        let testResultName = deptListFunc.parseTestResult(department.testResult, outputType: 0)
                        
                        let testResultNumber = deptListFunc.parseTestResult(department.testResult, outputType: 1)
                        
                        HStack{
                            Text("科目 (組合)")
                            Spacer()
                            Text("級分")
                        }
                        .bold()
                        
                        ForEach(Array(zip(testResultName, testResultNumber)), id: \.0) { name, number in
                            HStack {
                                Text(name)
                                Spacer()
                                Text(number)
                            }
                        }
                        
                    }
                    .padding(.bottom, 10)
                    
                    Text("請注意可能的篩選變更（本系統未進行檢查）")
                        .foregroundColor(Color(.systemGray2))
                        .font(.caption)
                    
                }
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(5)
                
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("第二階段甄選")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    if (!department.practicalExamScoreRatio.isEmpty){
                        HStack{
                            Text("術科成績採計")
                                .bold()
                            Spacer()
                            Text("\(department.practicalExamScoreRatio)%")
                                .bold()
                        }
                        .padding(.bottom, 5)
                    }
                    
                    HStack{
                        Text("學測成績採計")
                            .bold()
                        Spacer()
                        Text("\(department.selectionScoreRatio)%")
                            .bold()
                    }
                    .padding(.bottom, 5)
                    
                    
                    if (department.selectionScoreRatio != "0") {
                        
                        let multiplierSubject: [String] = deptListFunc.sortSubjectsNames(CH: department.chineseScoreCalculation, EN: department.englishScoreCalculation, MA: department.mathAScoreCalculation, MB: department.mathBScoreCalculation, SC: department.scienceScoreCalculation, SO: department.socialScoreCalculation, multiple: "--", PC: "--", PP: "--")
                    
                        
                        let multiplierScore: [Double] = deptListFunc.sortSubjectsScores(CH: department.chineseScoreCalculation, EN: department.englishScoreCalculation, MA: department.mathAScoreCalculation, MB: department.mathBScoreCalculation, SC: department.scienceScoreCalculation, SO: department.socialScoreCalculation, multiple: "--", PC: "--", PP: "--")
                        
                        ForEach(0..<multiplierSubject.count, id: \.self){ index in
                            HStack{
                                Text(multiplierSubject[index] == "組合科目" ? department.customSubjectCombination : multiplierSubject[index])
                                    .padding(.leading)
                                Spacer()
                                Text("\(String(format: "*%.2f", multiplierScore[index]))")
                            }
                        }
                        
                    }
                    
                    if (Int(department.designatedItem1ScoreRatio) ?? 0) > 0 {
                        HStack{
                            Text(department.designatedItem1)
                                .bold()
                            Spacer()
                            Text( department.designatedItem1Test == "0"  ? "" : "(\(department.designatedItem1Test)↑)")
                                .foregroundColor(Color(.systemGray2))
                            Text("\(department.designatedItem1ScoreRatio)%")
                                .bold()
                        }
                        .padding(.vertical, 5)
                    }
                    
                    if (Int(department.designatedItem2ScoreRatio) ?? 0) > 0 {
                        HStack{
                            Text(department.designatedItem2)
                                .bold()
                            Spacer()
                            Text( department.designatedItem2Test == "0"  ? "" : "(\(department.designatedItem2Test)↑)")
                                .foregroundColor(Color(.systemGray2))
                            Text("\(department.designatedItem2ScoreRatio)%")
                                .bold()
                        }
                        .padding(.bottom, 5)
                    }
                    
                    if (Int(department.designatedItem3ScoreRatio) ?? 0) > 0 {
                        HStack{
                            Text(department.designatedItem3)
                                .bold()
                            Spacer()
                            Text( department.designatedItem3Test == "0"  ? "" : "(\(department.designatedItem3Test)↑)")
                                .foregroundColor(Color(.systemGray2))
                            Text("\(department.designatedItem3ScoreRatio)%")
                                .bold()
                        }
                        .padding(.bottom, 5)
                    }
                    
                    if (Int(department.designatedItem4ScoreRatio) ?? 0) > 0 {
                        HStack{
                            Text(department.designatedItem4)
                                .bold()
                            Spacer()
                            Text( department.designatedItem4Test == "0"  ? "" : "(\(department.designatedItem4Test)↑)")
                                .foregroundColor(Color(.systemGray2))
                            Text("\(department.designatedItem4ScoreRatio)%")
                                .bold()
                        }
                        .padding(.bottom, 5)
                    }
                    
                    if (Int(department.designatedItem5ScoreRatio) ?? 0) > 0 {
                        HStack{
                            Text(department.designatedItem5)
                                .bold()
                            Spacer()
                            Text( department.designatedItem5Test == "0"  ? "" : "(\(department.designatedItem5Test)↑)")
                                .foregroundColor(Color(.systemGray2))
                            Text("\(department.designatedItem5ScoreRatio)%")
                                .bold()
                        }
                        .padding(.bottom, 5)
                    }
                    
                    if (Int(department.designatedItem6ScoreRatio) ?? 0) > 0 {
                        HStack{
                            Text(department.designatedItem6)
                                .bold()
                            Spacer()
                            Text( department.designatedItem6Test == "0"  ? "" : "(\(department.designatedItem6Test)↑)")
                                .foregroundColor(Color(.systemGray2))
                            Text("\(department.designatedItem6ScoreRatio)%")
                                .bold()
                        }
                        .padding(.bottom, 5)
                    }
                    
                }
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(5)
                    
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "doc.text")
                        Text("備註")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    HStack{
                        Text("甄試費用")
                        Spacer()
                        Text(department.examFee)
                        Text("元")
                            .foregroundColor(Color(.systemGray2))
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    
                    HStack{
                        Text("公告甄試通知")
                        Spacer()
                        Text(department.notifyOrAnnounceExam)
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    
                    HStack{
                        Text("甄試日期")
                        Spacer()
                        Text( !department.examDate1.isEmpty ? department.examDate1 : "點擊查看")
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    .onTapGesture {
                        sheetExplansion = "甄試日期 1：\(department.examDate1)\n甄試日期 2：\(department.examDate2)\n甄試日期 3：\(department.examDate3)\n甄試日期：\(department.examStartDate) ~ \(department.examEndDate)"
                        isShowSheet = true
                    }
                    
                    HStack{
                        Text("榜示日期")
                        Spacer()
                        Text(department.announcementDate)
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    
                    HStack{
                        Text("審查資料收件截止")
                        Spacer()
                        Text(department.documentSubmissionDeadline)
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    
                    HStack{
                        Text("審查資料項目")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.vertical, 5)
                    
                    if (!department.document1.isEmpty) {
                        HStack{
                            Text("1")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.document1)
                            Spacer()
                        }
                    }
                    
                    if (!department.document2.isEmpty) {
                        HStack{
                            Text("2")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.document2)
                            Spacer()
                        }
                    }
                    
                    if (!department.document3.isEmpty) {
                        HStack{
                            Text("3")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.document3)
                            Spacer()
                        }
                    }
                    
                    if (!department.document4.isEmpty) {
                        HStack{
                            Text("4")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.document4)
                            Spacer()
                        }
                    }
                    
                    if (!department.document5.isEmpty) {
                        HStack{
                            Text("5")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.document5)
                            Spacer()
                        }
                    }
                    
                    if (!department.document6.isEmpty) {
                        HStack{
                            Text("6")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.document6)
                            Spacer()
                        }
                    }
                    
                    HStack{
                        Text("第二階段同分參酌")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.vertical, 5)
                    
                    if (!department.tieBreakerOrder1.isEmpty) {
                        HStack{
                            Text("1")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.tieBreakerOrder1)
                            Spacer()
                        }
                    }
                    
                    if (!department.tieBreakerOrder2.isEmpty) {
                        HStack{
                            Text("2")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.tieBreakerOrder2)
                            Spacer()
                        }
                    }
                    
                    if (!department.tieBreakerOrder3.isEmpty) {
                        HStack{
                            Text("3")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.tieBreakerOrder3)
                            Spacer()
                        }
                    }
                    
                    if (!department.tieBreakerOrder4.isEmpty) {
                        HStack{
                            Text("4")
                                .font(.system(.body, design: .monospaced))
                                .bold()
                            Text(department.tieBreakerOrder4)
                            Spacer()
                        }
                    }
                    
                    HStack{
                        Text("審查資料說明")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.vertical, 5)
                    
                    Text(department.documentDescription.isEmpty ? "無" : department.documentDescription)
                    
                    HStack{
                        Text("甄試說明")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.vertical, 5)
                    
                    Text(department.designatedItemDescription)
                    
                    HStack{
                        Text("其他備註")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.vertical, 5)
                    
                    Text(department.remarks)
                    
                }
                .padding()
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(5)
                
            }
        }
        .padding()
        .sheet(isPresented: $isShowSheet){
            SheetExplansionView(explansion: $sheetExplansion)
        }
    }
    
    
}

