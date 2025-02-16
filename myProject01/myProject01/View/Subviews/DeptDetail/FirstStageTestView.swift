//
//  FirstStageTestView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct FirstStageTestView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    // --------------- //
    
    var department: deptListModel
    var data: gradeData
    let displayMore: Bool
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Image(systemName: "doc.text.magnifyingglass")
                Text("第一階段檢定")
                Spacer()
                
                if displayMore && deptListFunc.checkTestPassed(CH: department.chineseTest, EN: department.englishTest, MA: department.mathATest, MB: department.mathBTest, SC: department.scienceTest, SO: department.socialTest, EL: department.englishListeningTest, data: data, PC: department.programmingConceptTest, PP: department.programmingPracticalTest) {
                    Image(systemName: "checkmark.seal.fill")
                        .bold()
                        .foregroundColor(Color.green)
                        .padding(.trailing, -5)
                    Text("檢定通過")
                        .bold()
                }
                
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
                    if displayMore {
                        GridRow {
                            Text("你的")
                                .bold()
                            if (department.chineseTest != "--") { Text(deptListFunc.getFiveStandard(for: "CH", grade: data.gradeCH))
                                    .foregroundColor(deptListFunc.checkTestPassed(CH: department.chineseTest, data: data) ? Color.green : Color.red)
                            }
                            if (department.englishTest != "--") {
                                Text(deptListFunc.getFiveStandard(for: "EN", grade: data.gradeEN))
                                    .foregroundColor(deptListFunc.checkTestPassed(EN: department.englishTest, data: data) ? Color.green : Color.red)
                            }
                            if (department.mathATest != "--") {
                                Text(deptListFunc.getFiveStandard(for: "MA", grade: data.gradeMA))
                                    .foregroundColor(deptListFunc.checkTestPassed(MA: department.mathATest, data: data) ? Color.green : Color.red)
                            }
                            if (department.mathBTest != "--") {
                                Text(deptListFunc.getFiveStandard(for: "MB", grade: data.gradeMB))
                                    .foregroundColor(deptListFunc.checkTestPassed(MB: department.mathBTest, data: data) ? Color.green : Color.red)
                            }
                            if (department.scienceTest != "--") {
                                Text(deptListFunc.getFiveStandard(for: "SC", grade: data.gradeSC))
                                    .foregroundColor(deptListFunc.checkTestPassed(SC: department.scienceTest, data: data) ? Color.green : Color.red)
                            }
                            if (department.socialTest != "--") {
                                Text(deptListFunc.getFiveStandard(for: "SO", grade: data.gradeSO))
                                    .foregroundColor(deptListFunc.checkTestPassed(SO: department.socialTest, data: data) ? Color.green : Color.red)
                            }
                            if (department.englishListeningTest != "--") {     Text(data.gradeEL == 3 ? "C 級" : (data.gradeEL == 2 ? "B 級" : (data.gradeEL == 1 ? "A 級" : "F 級")))
                                    .foregroundColor(deptListFunc.checkTestPassed(EL: department.englishTest, data: data) ? Color.green : Color.red)
                            }
                            if ( !department.programmingConceptTest.isEmpty) { Text("\(data.gradePC) 級")
                                    .foregroundColor(deptListFunc.checkTestPassed(data: data, PC: department.programmingConceptTest) ? Color.green : Color.red)
                            }
                            if ( !department.programmingPracticalTest.isEmpty ) { Text("\(data.gradePP) 級")
                                    .foregroundColor(deptListFunc.checkTestPassed(data: data, PP: department.programmingPracticalTest) ? Color.green : Color.red)
                            }
                            if ( !department.practicalExamItem1Test.isEmpty ) { Text(String(data.gradeSK1))
                            }
                            if ( !department.practicalExamItem2Test.isEmpty ) { Text(String(data.gradeSK2))
                            }
                            if ( !department.practicalExamItem3Test.isEmpty ) { Text(String(data.gradeSK3))
                            }
                            if ( !department.practicalExamItem4Test.isEmpty ) { Text(String(data.gradeSK4))
                            }
                            if ( !department.practicalExamItem5Test.isEmpty ) { Text(String(data.gradeSK5))
                            }
                            Spacer()
                        }
                    }
                }
            }
            
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
        .sheet(isPresented: $isShowSheet){
            SheetExplansionView(explansion: $sheetExplansion)
        }
        
    }
    
}
