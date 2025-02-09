//
//  AllListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//


import SwiftUI

struct AllListView: View {
    
    @EnvironmentObject var data: Data
    
    @Binding var selectedTab: Int
    
    @State var searchText: String = ""
    
    let deptList = loadCSVData()
    
    var filteredDeptList: [deptListModel] {
        if searchText.isEmpty {
            return deptList
        } else {
            return deptList.filter { dept in
                dept.fullName.contains(searchText) || dept.id.contains(searchText) || dept.departmentAbbreviation.contains(searchText)
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack{
                    Text("所有校系資訊")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack{
                    Image(systemName: "list.dash")
                        .opacity(0.5)
                    Text("校系資料" + " (共" + deptList.count.description + "個校系)")
                        .opacity(0.5)
                    
                    Spacer()
                }
                .padding(.bottom,10)
                
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.systemGray))
                    TextField("搜尋學校或科系", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(10)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                
                ScrollView {
                    LazyVStack {
                        ForEach(filteredDeptList) { dept in
                            NavigationLink(destination: DeptDetailView(department: dept)){
                                DeptRowView(department: dept)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
            }
            .padding()
            
        }
    }
}

struct DeptRowView: View {
    var department: deptListModel
    
    var body: some View {
        VStack {
            HStack{
                VStack{
                    HStack{
                        Text(department.fullName)
                        Spacer()
                    }
                    HStack{
                        Text(department.id + "·" + department.enrollmentQuota)
                        Spacer()
                    }
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(Color(.systemGray))
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.systemGray))
                    .padding(.trailing, 5)
            }
        }
        .padding(10)
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
    }
}

struct DeptDetailView: View {
    
    @EnvironmentObject var data: Data
    
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    
    var department: deptListModel
    
    var body: some View {
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
                    
                    HStack{
                        Text("外加名額")
                        Spacer()
                        
                        var totalAdditionalQuota: Int {
                                (Int(department.indigenousAdditionalQuota) ?? 0) +
                                (Int(department.outlyingIslandAdditionalQuota) ?? 0) +
                                (Int(department.visionProgramAdditionalQuota) ?? 0)
                            }
                        Text("共")
                        Text("\(totalAdditionalQuota)")
                            .bold()
                        Text("人")
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
                        Image(systemName: "checkmark.circle")
                        Text("第一階段檢定")
                        Spacer()
                        if deptListFunc.checkTestPassed(CH: department.chineseTest, EN: department.englishTest, MA: department.mathATest, MB: department.mathBTest, SC: department.scienceTest, SO: department.socialTest, EL: department.englishListeningTest, data: data) {
                            HStack{
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(Color.green)
                                Text("檢定通過")
                                    .padding(.leading, -5)
                            }
                            .onTapGesture {
                                
                                sheetExplansion = "您登錄的成績滿足該科系所需之所有檢定。檢定通過就可以選擇該系為志願，但仍需經過後續倍數篩選，才能確定錄取第二階段。"
                                isShowSheet = true
                            }
                        }
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
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
                                Spacer()
                            }
                            GridRow{
                                Text("檢定")
                                    .bold()
                                if (department.chineseTest != "--") { Text(department.chineseTest)
                                        .foregroundColor(deptListFunc.checkTestPassed(CH: department.chineseTest, data: data) ? nil : Color.red)
                                }
                                if (department.englishTest != "--") { Text(department.englishTest)
                                        .foregroundColor(deptListFunc.checkTestPassed(EN: department.englishTest, data: data) ? nil : Color.red)
                                }
                                if (department.mathATest != "--") { Text(department.mathATest)
                                        .foregroundColor(deptListFunc.checkTestPassed(MA: department.mathATest, data: data) ? nil : Color.red)
                                }
                                if (department.mathBTest != "--") { Text(department.mathBTest)
                                        .foregroundColor(deptListFunc.checkTestPassed(MB: department.mathBTest, data: data) ? nil : Color.red)
                                }
                                if (department.scienceTest != "--") { Text(department.scienceTest)
                                        .foregroundColor(deptListFunc.checkTestPassed(SC: department.scienceTest, data: data) ? nil : Color.red)
                                }
                                if (department.socialTest != "--") {
                                    Text(department.socialTest)
                                        .foregroundColor(deptListFunc.checkTestPassed(SO: department.socialTest, data: data) ? nil : Color.red)
                                }
                                if (department.englishListeningTest != "--") { Text(department.englishListeningTest)
                                        .foregroundColor(deptListFunc.checkTestPassed(EL: department.englishListeningTest, data: data) ? nil : Color.red)
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
                    
                    let multiplierSubject: [String] = deptListFunc.sortSubjectsNames(CH: department.chineseMultiplier, EN: department.englishMultiplier, MA: department.mathAMultiplier, MB: department.mathBMultiplier, SC: department.scienceMultiplier, SO: department.socialMultiplier, multiple: department.customSubjectCombinationMultiplier)
                    
                    let multiplierScore: [Double] = deptListFunc.sortSubjectsScores(CH: department.chineseMultiplier, EN: department.englishMultiplier, MA: department.mathAMultiplier, MB: department.mathBMultiplier, SC: department.scienceMultiplier, SO: department.socialMultiplier, multiple: department.customSubjectCombinationMultiplier)
                    
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
                        Image(systemName: "doc.text")
                        Text("備註")
                        Spacer()
                    }
                    .bold()
                    .padding(.bottom, 10)
                    
                    HStack{
                        Spacer()
                        Text("指定項目內容：審查資料")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.bottom, 5)
                    
                    Text(department.documentDescription.isEmpty ? "無" : department.documentDescription)
                    
                    HStack{
                        Spacer()
                        Text("指定項目內容：甄試說明")
                        Spacer()
                    }
                    .font(.headline)
                    .padding(.vertical, 5)
                    
                    Text(department.designatedItemDescription)
                    
                    HStack{
                        Spacer()
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

#Preview {
    AllListView(selectedTab: .constant(3))
        .environmentObject(Data())
}
#Preview {
    DeptDetailView(department: deptListModel(
        schoolCode: "1234",
        schoolName: "測試大學",
        departmentCode: "5678",
        departmentName: "測試學系",
        departmentAbbreviation: "測試系",
        departmentType: "一般",
        genderRequirement: "不限",
        practicalExam: "無",
        notifyOrAnnounceExam: "公告",
        documentSubmissionDeadline: "2025-03-01",
        examStartDate: "2025-05-10",
        examEndDate: "2025-05-12",
        examDate1: "2025-05-10",
        examDate2: "",
        examDate3: "",
        announcementDate: "2025-06-01",
        reviewDate: "2025-06-02",
        chineseTest: "均標",
        englishTest: "--",
        mathATest: "--",
        mathBTest: "--",
        socialTest: "--",
        scienceTest: "--",
        englishListeningTest: "--",
        chineseMultiplier: "1.5",
        englishMultiplier: "1.5",
        mathAMultiplier: "2.0",
        mathBMultiplier: "--",
        socialMultiplier: "1.0",
        scienceMultiplier: "1.0",
        customSubjectCombination: "數A+英",
        customSubjectCombinationMultiplier: "3.0",
        sameLevelScoreExcessSelectionOrder1: "國文",
        sameLevelScoreExcessSelectionOrder2: "英文",
        sameLevelScoreExcessSelectionOrder3: "數學A",
        sameLevelScoreExcessSelectionOrder4: "",
        programmingConceptTest: "是",
        programmingConceptTestMultiplier: "1.0",
        programmingPracticalTest: "是",
        programmingPracticalTestMultiplier: "1.5",
        chineseScoreCalculation: "採計",
        englishScoreCalculation: "採計",
        mathAScoreCalculation: "採計",
        mathBScoreCalculation: "不採計",
        socialScoreCalculation: "採計",
        scienceScoreCalculation: "不採計",
        selectionScoreRatio: "50%",
        designatedItem1: "學測成績",
        designatedItem2: "備審資料",
        designatedItem3: "面試",
        designatedItem4: "",
        designatedItem5: "",
        designatedItem6: "",
        designatedItem1Test: "是",
        designatedItem2Test: "是",
        designatedItem3Test: "是",
        designatedItem4Test: "",
        designatedItem5Test: "",
        designatedItem6Test: "",
        designatedItem1ScoreRatio: "40%",
        designatedItem2ScoreRatio: "30%",
        designatedItem3ScoreRatio: "30%",
        designatedItem4ScoreRatio: "",
        designatedItem5ScoreRatio: "",
        designatedItem6ScoreRatio: "",
        tieBreakerOrder1: "國文",
        tieBreakerOrder2: "英文",
        tieBreakerOrder3: "數學A",
        tieBreakerOrder4: "",
        examFee: "1500",
        document1: "身分證明",
        document2: "高中成績單",
        document3: "自傳",
        document4: "",
        document5: "",
        document6: "",
        documentDescription: "需繳交完整審查資料",
        designatedItemDescription: "面試時需攜帶備審資料",
        remarks: "無特別備註",
        enrollmentQuota: "50",
        maleEnrollmentQuota: "25",
        femaleEnrollmentQuota: "25",
        indigenousAdditionalQuota: "2",
        outlyingIslandAdditionalQuota: "1",
        outlyingIslandAdditionalQuotaDescription: "1名限金門縣",
        visionProgramAdditionalQuota: "2",
        expectedExamCount: "150",
        practicalExamItem1Test: "無",
        practicalExamItem2Test: "無",
        practicalExamItem3Test: "無",
        practicalExamItem4Test: "無",
        practicalExamItem5Test: "無",
        practicalExamItem1Multiplier: "0.0",
        practicalExamItem2Multiplier: "0.0",
        practicalExamItem3Multiplier: "0.0",
        practicalExamItem4Multiplier: "0.0",
        practicalExamItem5Multiplier: "0.0",
        practicalExamItem1ScoreCalculation: "不採計",
        practicalExamItem2ScoreCalculation: "不採計",
        practicalExamItem3ScoreCalculation: "不採計",
        practicalExamItem4ScoreCalculation: "不採計",
        practicalExamItem5ScoreCalculation: "不採計",
        practicalExamScoreRatio: "0%"
    ))
    .environmentObject(Data())
}
