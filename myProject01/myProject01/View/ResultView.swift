//
//  ResultView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftUI

struct DeptGroup: Identifiable {
    let id = UUID()
    let title: String
    let departments: [deptListModel]
}

struct ResultView : View {
    
    @EnvironmentObject var data: Data
    
    @Binding var selectedTab: Int
    
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    
    let deptList: [deptListModel] = loadCSVData()
    
    var filiteredDept: [deptListModel] {
        deptList.filter { dept in
            deptListFunc.checkTestPassed(
                CH: dept.chineseTest,
                EN: dept.englishTest,
                MA: dept.mathATest,
                MB: dept.mathBTest,
                SC: dept.scienceTest,
                SO: dept.socialTest,
                EL: dept.englishListeningTest,
                data: data,
                PC: dept.programmingConceptTest,
                PP: dept.programmingPracticalTest
            )
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                HStack{
                    Text("分析結果")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom)
                
                HStack{
                    Image(systemName: "list.bullet.clipboard")
                        .opacity(0.5)
                    Text("您的成績")
                        .opacity(0.5)
                    Spacer()
                }
                .padding(.bottom,10)
                
                HStack{
                    
                    Grid {
                        GridRow {
                            Text("理組總級")
                                .onTapGesture {
                                    sheetExplansion = "國文（\(data.gradeCH)）+ 英文（\(data.gradeEN)）+ 數Ａ（\(data.gradeMA)）+ 自然（\(data.gradeSC)）＝理組總級（\(data.gradeTotal1)），通常用於自然組科系。"
                                    isShowSheet = true
                                }
                            Text("文Ａ總級")
                                .onTapGesture {
                                    sheetExplansion = "國文（\(data.gradeCH)）+ 英文（\(data.gradeEN)）+ 數Ａ（\(data.gradeMA)）+ 社會（\(data.gradeSO)）＝文Ａ總級（\(data.gradeTotal2)），通常用於商、管、財、經等科系。"
                                    isShowSheet = true
                                }
                            Text("文Ｂ總級")
                                .onTapGesture {
                                    sheetExplansion = "國文（\(data.gradeCH)）+ 英文（\(data.gradeEN)）+ 數Ｂ（\(data.gradeMA)）+ 社會（\(data.gradeSO)）＝文Ｂ總級（\(data.gradeTotal3)），通常用於法律、語言、教育等科系。"
                                    isShowSheet = true
                                }
                        }
                        GridRow {
                            Text("\(data.gradeTotal1)")
                                .bold()
                            Text("\(data.gradeTotal2)")
                                .bold()
                            Text("\(data.gradeTotal3)")
                                .bold()
                        }
                    }
                    .frame(minWidth: UIScreen.main.bounds.width * 0.65)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        Grid {
                            GridRow{
                                Text("國文")
                                Text("英文")
                                Text("數Ａ")
                                Text("數Ｂ")
                                Text("自然")
                                Text("社會")
                                Text("英聽")
                            }
                            GridRow{
                                Text("\(data.gradeCH)")
                                Text("\(data.gradeEN)")
                                Text("\(data.gradeMA)")
                                Text("\(data.gradeMB)")
                                Text("\(data.gradeSC)")
                                Text("\(data.gradeSO)")
                                Text("\(transformELintToString(data.gradeEL))")
                            }
                            .bold()
                        }
                    }
                    
                }
                .padding(10)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                .padding(.bottom,10)
                
                HStack{
                    Image(systemName: "checkmark.seal.fill")
                        .opacity(0.5)
                    Text("通過檢定的科系")
                        .opacity(0.5)
                    
                    Spacer()
                }
                .padding(.bottom,10)
                
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(filiteredDept) { dept in
                            NavigationLink(destination: DeptDetailView(department: dept, displayMore: true)) {
                                DeptRowView(department: dept)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                    }
                    
                }
                
            }
            .padding()
            .sheet(isPresented: $isShowSheet){
                SheetExplansionView(explansion: $sheetExplansion)
            }
            
        }
        
    }
    
    private func transformELintToString(_ input: Int) -> String {
        switch input{
            case 0:
                return "F"
            case 1:
                return "A"
            case 2:
                return "B"
            case 3:
                return "C"
            default:
                return "N/A"
        }
    }
    
    
}

#Preview {
    ResultView(selectedTab: .constant(1))
        .environmentObject(Data())
}
