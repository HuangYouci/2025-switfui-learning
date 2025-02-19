//
//  DeptDetailView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DeptDetailView: View {
    
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
    var displayMore: Bool
    
    var body: some View {
        
        VStack {
            
            DepartmentHeaderView(department: department)
            
            Divider()
            
            ScrollView {
                
                if displayMore { PassChanceQuickView(department: department, data: data) } // 需要 data
                
                EnrollmentQuotaView(department: department)
                
                FirstStageTestView(department: department, data: data, displayMore: displayMore) // 需要 data
                
                FirstStageFilterView(department: department)
                
                FirstStageResultView(department: department, data: data, displayMore: displayMore) // 需要 data
                
                SecondStageSelectionView(department: department)
                
                DepartmentNotesView(department: department)
                
                if displayMore { PassChanceView(department: department, data: data) } // 需要 data
                
            }
        }
        .padding()
    }
    
}

