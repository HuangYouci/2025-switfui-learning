//
//  ListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//


import SwiftUI

struct ListView: View {
    
    // --------------- //
    // EnvironmentObject
    @EnvironmentObject var deptList: DeptDataModel
    // StateObject
    // Binding
    @Binding var selectedTab: Int
    // State
    // --------------- //

    
    var body: some View {
        
        NavigationView {
            
            DeptListView(deptList: deptList.departments, title: "所有校系資訊", displayMore: false, gradeData: gradeData(gradeCH: 11, gradeEN: 14, gradeMA: 7, gradeMB: 11, gradeSC: 12, gradeSO: 11, gradeEL: 1, gradePC: 3, gradePP: 3, gradeSK1: 1, gradeSK2: 0, gradeSK3: 0, gradeSK4: 0, gradeSK5: 0, gradeSKT: 0))
            
        }
    }
}
