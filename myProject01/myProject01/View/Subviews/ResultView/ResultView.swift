//
//  ResultView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftUI


struct ResultView : View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    // --------------- //
    
    var data: gradeData
    
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
                            Text("程設觀念")
                            Text("程設實作")
                        }
                        GridRow{
                            Text("\(data.gradeCH)")
                            Text("\(data.gradeEN)")
                            Text("\(data.gradeMA)")
                            Text("\(data.gradeMB)")
                            Text("\(data.gradeSC)")
                            Text("\(data.gradeSO)")
                            Text("\(transformELintToString(data.gradeEL))")
                            Text("\(data.gradePC) 級")
                            Text("\(data.gradePP) 級")
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
            
            ScrollView {
                
                LazyVStack{
                    
                    NavigationLink(destination: Result5SView(data: data, filiteredDept: filiteredDept)){
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
                    
                    NavigationLink(destination: Result4SView(data: data, filiteredDept: filiteredDept)){
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
                    
                    NavigationLink(destination: Result3SView(data: data, filiteredDept: filiteredDept)){
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
                    
                    NavigationLink(destination: Result2SView(data: data, filiteredDept: filiteredDept)){
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
                    
                    NavigationLink(destination: Result1SView(data: data, filiteredDept: filiteredDept)){
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
                    
                    ResultAllListView(data: data, deptList: filiteredDept)
                        .padding(.vertical, 10)
                    
                }
                
            }
            
            Spacer()
            
        }
        .padding()
        .sheet(isPresented: $isShowSheet){
            SheetExplansionView(explansion: $sheetExplansion)
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
