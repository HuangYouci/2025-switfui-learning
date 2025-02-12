//
//  ResultView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftUI


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
                    Text("分析結果")
                        .opacity(0.5)
                    
                    Spacer()
                }
                .padding(.bottom,10)
                
                
                NavigationLink(destination: Result5SView(filiteredDept: filiteredDept)){
                    VStack{
                        HStack{
                            VStack{
                                HStack{
                                    Text("保底志願 ★★★★★")
                                    Spacer()
                                }
                                HStack{
                                    Text("系統計算非常可能錄取的科系列表")
                                    Spacer()
                                }
                                .foregroundColor(Color(.systemGray))
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.systemGray))
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(10)
                    .background(Color.orange.opacity(0.1))
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: Result4SView(filiteredDept: filiteredDept)){
                    VStack{
                        HStack{
                            VStack{
                                HStack{
                                    Text("安全志願 ★★★★")
                                    Spacer()
                                }
                                HStack{
                                    Text("系統計算有較高機率錄取的科系列表")
                                    Spacer()
                                }
                                .foregroundColor(Color(.systemGray))
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.systemGray))
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(10)
                    .background(Color.purple.opacity(0.1))
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: Result3SView(filiteredDept: filiteredDept)){
                    VStack{
                        HStack{
                            VStack{
                                HStack{
                                    Text("一般志願 ★★★")
                                    Spacer()
                                }
                                HStack{
                                    Text("系統計算有一般機率錄取的科系列表")
                                    Spacer()
                                }
                                .foregroundColor(Color(.systemGray))
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.systemGray))
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(10)
                    .background(Color.blue.opacity(0.1))
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: Result2SView(filiteredDept: filiteredDept)){
                    VStack{
                        HStack{
                            VStack{
                                HStack{
                                    Text("進攻志願 ★★")
                                    Spacer()
                                }
                                HStack{
                                    Text("系統計算有小機率錄取的科系列表")
                                    Spacer()
                                }
                                .foregroundColor(Color(.systemGray))
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.systemGray))
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(10)
                    .background(Color.green.opacity(0.1))
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: Result1SView(filiteredDept: filiteredDept)){
                    VStack{
                        HStack{
                            VStack{
                                HStack{
                                    Text("夢幻志願 ★")
                                    Spacer()
                                }
                                HStack{
                                    Text("系統計算有極低可能錄取的科系列表")
                                    Spacer()
                                }
                                .foregroundColor(Color(.systemGray))
                            }
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.systemGray))
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(10)
                    .background(Color.pink.opacity(0.1))
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
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
