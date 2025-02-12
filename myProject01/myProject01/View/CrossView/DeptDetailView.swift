//
//  DeptDetailView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DeptDetailView: View {
    
    /// 父 View 資料
    // 科系主要資料
    var department: deptListModel
    // 用戶成績資料
    @EnvironmentObject var data: Data
    // 顯示解釋資料
//    @State private var isShowSheet = false
//    @State var sheetExplansion: String?
    
    var body: some View {
        
        let displayMore = data.displayMore == 1 ? true : false
        
        VStack {
            
            DepartmentHeaderView(department: department)
            
            Divider()
            
            ScrollView {
                
                if displayMore { PassChanceQuickView(department: department) }
                
                EnrollmentQuotaView(department: department)
                
                FirstStageTestView(department: department)
                
                FirstStageFilterView(department: department)
                
                FirstStageResultView(department: department)
                
                SecondStageSelectionView(department: department)
                    
                DepartmentNotesView(department: department)
                
                if displayMore { PassChanceView(department: department) }
                
            }
        }
        .padding()
    }
    
}

