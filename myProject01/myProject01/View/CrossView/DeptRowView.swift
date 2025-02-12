//
//  DeptRowView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DeptRowView: View {
    var department: deptListModel
    
    @EnvironmentObject var data: Data
    
    private var isPassed: Bool {
        deptListFunc.checkTestPassed(
            CH: department.chineseTest,
            EN: department.englishTest,
            MA: department.mathATest,
            MB: department.mathBTest,
            SC: department.scienceTest,
            SO: department.socialTest,
            EL: department.englishListeningTest,
            data: data,
            PC: department.programmingConceptTest,
            PP: department.programmingPracticalTest
        )
    }
    
    var body: some View {
        VStack {
            HStack{
                VStack{
                    HStack{
                        Text(department.fullName)
                        Spacer()
                    }
                    HStack{
                        Text(department.id + "·" + department.enrollmentQuota)
                        Spacer()
                    }
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(Color(.systemGray))
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.systemGray))
                    .padding(.trailing, 5)
            }
        }
        .padding(10)
        .background(isPassed ? Color(.clear) : Color.red.opacity(0.1))
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .contextMenu{
            ShareLink(item: "我看上了 \(department.fullName) [\(department.id)]！共有 \(department.enrollmentQuota) 名額，快到「學測個申分析系統」搜尋科系 ID「\(department.id)」來查看詳細資料。") {
                Label("分享", systemImage: "square.and.arrow.up")
            }
        }
    }
}
