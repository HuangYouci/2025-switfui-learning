//
//  DepartmentHeaderView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DepartmentHeaderView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    // --------------- //
    
    var department: deptListModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(department.schoolName)
                    .font(.subheadline)
                Text(department.departmentName)
                    .font(.title2)
                    .bold()
            }
            
            Spacer()
            
            if department.departmentType != "一般" {
                Text(department.departmentType)
                    .foregroundColor(Color.white)
                    .padding(5)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            
            Text(department.id)
                .font(.system(.body, design: .monospaced))
                .padding(5)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
        }
        .padding()
    }
}
