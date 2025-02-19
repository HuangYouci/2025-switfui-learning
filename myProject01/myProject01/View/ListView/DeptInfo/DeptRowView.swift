//
//  DeptRowView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DeptRowView: View {
    
    // --------------- //
    // EnvironmentObject
    @EnvironmentObject var data: UserDef
    // StateObject
    // Binding
    // State
    // --------------- //
    
    var department: deptListModel
    
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
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .contextMenu{
            
            Button(role: .none){
                if data.favoriteDept.contains(department.id) {
                    data.favoriteDept.remove(at: Int(data.favoriteDept.firstIndex(of: department.id)!))
                } else {
                    data.favoriteDept.append(department.id)
                }
            } label: {
                Label(data.favoriteDept.contains(department.id) ? "移除最愛" : "加入最愛", systemImage: data.favoriteDept.contains(department.id) ? "heart.fill" : "heart")
            }
            
            ShareLink(item: "我看上了 \(department.fullName) [\(department.id)]！共有 \(department.enrollmentQuota) 名額，快到「學測個申分析系統」搜尋科系 ID「\(department.id)」來查看詳細資料。") {
                Label("分享", systemImage: "square.and.arrow.up")
            }
            
        }
    }
}
