//
//  ResultListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/16.
//

import SwiftUI

struct ResultListView: View {
    
    // --------------- //
    // EnvironmentObject
    @EnvironmentObject var data: UserDef
    @EnvironmentObject var deptList: DeptDataModel
    // StateObject
    // Binding
    @Binding var selectedTab: Int
    // State
    @State private var expandedIndices: Set<Int> = []
    @State private var deleteIndex: Int = 0
    @State private var showDeleteConfirmation: Bool = false
    // --------------- //
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack{
                    Text("所有分析結果")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack{
                    Image(systemName: "folder")
                        .opacity(0.5)
                    
                    Text("分析資料" + " (共" + data.userResultData.count.description + "個結果)")
                        .opacity(0.5)
                    
                    Spacer()
                }
                .padding(.bottom,10)
                
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(data.userResultData.indices, id: \.self) { index in
                            
                            let isExpanded = expandedIndices.contains(index)
                            
                            let gradeData = gradeData(
                                gradeCH: data.userResultData[index].gradeCH,
                                gradeEN: data.userResultData[index].gradeEN,
                                gradeMA: data.userResultData[index].gradeMA,
                                gradeMB: data.userResultData[index].gradeMB,
                                gradeSC: data.userResultData[index].gradeSC,
                                gradeSO: data.userResultData[index].gradeSO,
                                gradeEL: data.userResultData[index].gradeEL,
                                gradePC: data.userResultData[index].gradePC,
                                gradePP: data.userResultData[index].gradePP,
                                gradeSK1: data.userResultData[index].gradeSK1,
                                gradeSK2: data.userResultData[index].gradeSK2,
                                gradeSK3: data.userResultData[index].gradeSK3,
                                gradeSK4: data.userResultData[index].gradeSK4,
                                gradeSK5: data.userResultData[index].gradeSK5,
                                gradeSKT: data.userResultData[index].gradeSKT
                            )
                            
                            VStack {
                                HStack{
                                    VStack{
                                        HStack{
                                            Text("分析 #\(index + 1)")
                                            Spacer()
                                        }
                                        HStack{
                                            Text("國\(data.userResultData[index].gradeCH)")
                                            Text("英\(data.userResultData[index].gradeEN)")
                                            Text("數A \(data.userResultData[index].gradeMA)")
                                            Text("數B \(data.userResultData[index].gradeMB)")
                                            Text("自\(data.userResultData[index].gradeSC)")
                                            Text("社\(data.userResultData[index].gradeSO)")
                                            Spacer()
                                        }
                                        .font(.system(.footnote, design: .monospaced))
                                        .foregroundColor(Color(.systemGray))
                                    }
                                    Image(systemName: isExpanded ? "chevron.down" :"chevron.right")
                                        .foregroundColor(Color(.systemGray))
                                        .padding(.trailing, 5)
                                }
                                if isExpanded {
                                    
                                    Divider()
                                        .padding(.vertical, 5)
                                    
                                    HStack{
                                        
                                        NavigationLink(destination: ResultView(data: gradeData)){
                                            Label("載入此資料的分析", systemImage: "square.and.arrow.down")
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .simultaneousGesture(TapGesture().onEnded {
                                            deptList.loadGradeData(gradeCH: data.userResultData[index].gradeCH, gradeEN: data.userResultData[index].gradeEN, gradeMA: data.userResultData[index].gradeMA, gradeMB: data.userResultData[index].gradeMB, gradeSC: data.userResultData[index].gradeSC, gradeSO: data.userResultData[index].gradeSO, gradeEL: data.userResultData[index].gradeEL, gradePC: data.userResultData[index].gradePC, gradePP: data.userResultData[index].gradePP)
                                        })
                                        
                                        Spacer()
                                        Button(role: .destructive){
                                            deleteIndex = index
                                            showDeleteConfirmation = true
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .buttonStyle(.bordered)
                                        
                                    }
                                    
                                }
                            }
                            .padding(10)
                            .background(Color(.quaternarySystemFill))
                            .cornerRadius(10)
                            .onTapGesture {
                                if isExpanded {
                                    expandedIndices.remove(index)
                                } else {
                                    expandedIndices.insert(index)
                                }
                            }

                        }
                        
                    }
                    
                    HStack {
                        Text("在首頁提交成績資料後，分析結果即顯示於此處")
                            .opacity(0.5)
                            .font(.caption)
                    }
                    .padding(.top, 10)
                    
                }
                
            }
            .padding()
            
        }
        .confirmationDialog("確定刪除此筆分析結果？", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("確定", role: .destructive) {
                data.userResultData.remove(at: deleteIndex)
            }
            Button("取消", role: .cancel) {
            }
        } message: {
            Text("此操作會刪除此筆成績資料與分析結果。\n清除後將不可復原，使用的分析次數亦不返還。")
        }
        
    }
    
}
