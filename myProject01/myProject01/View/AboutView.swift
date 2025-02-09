//
//  AboutView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftUI

struct AboutView: View {
    
    @EnvironmentObject var data: Data
    
    @Binding var selectedTab: Int
    
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
            
        VStack{
            
            HStack{
                Text("關於")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
            HStack{
                Text("你的資訊")
                    .padding(.vertical, 1)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 5)
            
            VStack{
                HStack{
                    Text("用戶名稱")
                        .foregroundStyle(Color.accentColor)
                    
                    Spacer()
                    
                    Text("\(data.username)")
                    
                }
                
                Divider()
                    .padding(3)
                
                HStack{
                    Text("裝置識別碼")
                        .foregroundStyle(Color.accentColor)
                    
                    Spacer()
                    
                    Text("0")
                        .foregroundColor(Color(.systemGray2))
                    
                }
            }
            .padding(10)
            .background(Color(.quaternarySystemFill))
            .cornerRadius(10)
            
            HStack{
                Text("毀滅性功能")
                    .padding(.vertical, 1)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 5)
            
            HStack{
                
                Button(role: .destructive, action: {
                    showDeleteConfirmation = true
                }, label: {
                    Spacer()
                    Text("清除所有資料")
                    Spacer()
                })
                
            }
            .padding(10)
            .background(Color(.quaternarySystemFill))
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .confirmationDialog("確定要清除所有資料嗎？", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            
            Button("確認刪除", role: .destructive){
                data.gradeCH = 0
                data.gradeEN = 0
                data.gradeMA = 0
                data.gradeSO = 0
                data.gradeSC = 0
                data.gradeMB = 0
                data.gradeEL = 0
                data.username = "用戶"
                selectedTab = 0
            }
            Button("取消", role: .cancel){
                // Cancel
            }
            
        } message: {
            Text("此操作會刪除您的成績資料與分析結果。\n清除後將返回主畫面")
        }
        
        
    }
}


#Preview {
    AboutView(selectedTab: .constant(2))
        .environmentObject(Data())
}
