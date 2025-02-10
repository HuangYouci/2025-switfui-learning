//
//  FirstStageResultView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct FirstStageResultView: View {
    
    /// 父 View 資料
    // 科系主要資料
    var department: deptListModel
    // 用戶成績資料
//    @EnvironmentObject var data: Data
    // 顯示解釋資料
//    @State private var isShowSheet = false
//    @State var sheetExplansion: String?
    
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
        
    }
    
}
