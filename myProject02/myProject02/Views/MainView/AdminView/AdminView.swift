//
//  AdminView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct AdminView: View {
    
    // 本 VIEW 新增環境變數
    @StateObject var adminViewModel = AdminViewModel()
    // 繼承環境變數
    // 本 VIEW 綁定變數
    
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                HStack{
                    Text("管理員設置")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()
                
            }
                    
            ScrollView {
                
                HStack{
                    Spacer()
                }
                
                ForEach(adminViewModel.users) { user in
                    AdminUsersRowView(user: user)
                }
                
            }
            .padding()
            .background(
                BlurView(style: .systemThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .edgesIgnoringSafeArea(.all)
            
        }
        .background(Image("bgLogin").opacity(0.3))
        .onAppear {
            adminViewModel.fetchUsers()
        }
        
    }
    
}

#Preview {
    AdminView()
}
