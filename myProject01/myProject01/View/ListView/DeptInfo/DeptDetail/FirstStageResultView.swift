//
//  FirstStageResultView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct FirstStageResultView: View {
    
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
                
                let testResultUserGrade = deptListFunc.convertSubjects(testResultName, gradeData: data)
                
                HStack{
                    Text("科目 (組合)")
                    Spacer()
                    Text("級分").frame(width: 50, alignment: .trailing)
                    if displayMore && testResultUserGrade != [0] {
                        Text("你的").frame(width: 50, alignment: .trailing)
                    }
                }
                .bold()
                
                ForEach(Array(testResultName.indices), id: \.self) { index in
                    HStack {
                        Text(testResultName[index])
                        Spacer()
                        Text(testResultNumber[index]).frame(width: 50, alignment: .trailing)
                        if displayMore && ( testResultName[index] != "超額篩選" ) {
                            Text(String(testResultUserGrade[index]))
                                .foregroundColor(testResultUserGrade[index] >= (Int(testResultNumber[index]) ?? 0) ? Color.green : Color.red)
                                .frame(width: 50, alignment: .trailing)
                        }
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
        
    }
    
}
