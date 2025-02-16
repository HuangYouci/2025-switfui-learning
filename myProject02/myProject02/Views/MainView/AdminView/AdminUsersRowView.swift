//
//  AdminUsersRowView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct AdminUsersRowView: View {
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    // 本 VIEW 綁定變數
    
    var user: User
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: AdminUsersDetailView(uid: user.id)){
                HStack{
                    VStack{
                        HStack{
                            Text(user.userName)
                            Spacer()
                        }
                        HStack{
                            Text(String(user.userPoints) + "P")
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
        }
        .padding(10)
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .contextMenu{
            
            Button(role: .destructive){
                //
            } label: {
                Label("刪除帳號", systemImage: "trash")
            }
        }
    }
}
