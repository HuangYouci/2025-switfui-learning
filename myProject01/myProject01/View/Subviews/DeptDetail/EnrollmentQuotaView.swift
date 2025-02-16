//
//  EnrollmentQuotaView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct EnrollmentQuotaView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    // --------------- //
    
    var department: deptListModel
    
    private var totalAdditionalQuota: Int {
        (Int(department.indigenousAdditionalQuota) ?? 0) +
        (Int(department.outlyingIslandAdditionalQuota) ?? 0) +
        (Int(department.visionProgramAdditionalQuota) ?? 0)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "info.circle")
                Text("招生名額")
                Spacer()
            }
            .bold()
            .padding(.bottom, 10)
            
            HStack {
                Text("甄試人數")
                Spacer()
                Text("共")
                Text(department.expectedExamCount)
                    .bold()
                Text("人")
            }
            
            HStack {
                Text("錄取人數")
                Spacer()
                if (department.genderRequirement == "女" || department.genderRequirement == "男") {
                    Text("限\(department.genderRequirement)性")
                }
                
                Text("共")
                Text(department.enrollmentQuota)
                    .bold()
                Text("人")
            }
            
            if (Int(department.maleEnrollmentQuota) ?? 0 > 0) {
                HStack {
                    Text("男性錄取名額")
                        .padding(.leading)
                    Spacer()
                    Text(department.maleEnrollmentQuota)
                        .bold()
                    Text("人")
                }
                .foregroundColor(Color(.darkGray))
            }
            
            if (Int(department.femaleEnrollmentQuota) ?? 0 > 0) {
                HStack {
                    Text("女性錄取名額")
                        .padding(.leading)
                    Spacer()
                    Text(department.femaleEnrollmentQuota)
                        .bold()
                    Text("人")
                }
                .foregroundColor(Color(.darkGray))
            }
            
            if totalAdditionalQuota > 0 {
                HStack {
                    Text("外加名額")
                    Spacer()
                    Text("共")
                    Text("\(totalAdditionalQuota)")
                        .bold()
                    Text("人")
                }
            }
            
            if (Int(department.indigenousAdditionalQuota) ?? 0 > 0) {
                HStack {
                    Text("原住民")
                        .padding(.leading)
                    Spacer()
                    Text(department.indigenousAdditionalQuota)
                        .bold()
                    Text("人")
                }
                .foregroundColor(Color(.darkGray))
            }
            
            if (Int(department.outlyingIslandAdditionalQuota) ?? 0 > 0) {
                HStack {
                    Text("離島")
                        .padding(.leading)
                    ScrollView(.horizontal) {
                        Text(department.outlyingIslandAdditionalQuotaDescription)
                    }
                    .ignoresSafeArea()
                    Spacer()
                    Text(department.outlyingIslandAdditionalQuota)
                        .bold()
                    Text("人")
                }
                .foregroundColor(Color(.darkGray))
            }
            
            if (Int(department.visionProgramAdditionalQuota) ?? 0 > 0) {
                HStack {
                    Text("願景")
                        .padding(.leading)
                    Spacer()
                    Text(department.visionProgramAdditionalQuota)
                        .bold()
                    Text("人")
                }
                .foregroundColor(Color(.darkGray))
            }
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
    }
}
