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
    
    @State private var editingDisplayMore: Bool = false
    
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
            
        VStack{
            
            HStack{
                Text("關於")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
            ScrollView {
                
                HStack{
                    Text("你的資訊")
                        .padding(.vertical, 1)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(5)
                
                VStack{
                    HStack{
                        Text("用戶名稱")
                            .foregroundStyle(Color.accentColor)
                        
                        Spacer()
                        
                        Text("\(data.username)")
                        
                    }
                    .padding(5)
                    
                    Divider()
                    
                    HStack{
                        Text("裝置識別碼")
                            .foregroundStyle(Color.accentColor)
                        
                        Spacer()
                        
                        Text("0")
                            .foregroundColor(Color(.systemGray2))
                        
                    }
                    .padding(5)
                }
                .padding(10)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                
                HStack{
                    Text("偏好設置")
                        .padding(.vertical, 1)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(5)
                
                VStack{
                    
                    HStack{
                        
                        Toggle("在科系資訊中顯示詳細資料", isOn: $editingDisplayMore)
                            .onChange(of: editingDisplayMore){
                                data.displayMore = editingDisplayMore ? 1 : 0
                            }
                            .onAppear(){
                                editingDisplayMore = ( data.displayMore == 1 )
                            }
                        
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
                .padding(5)
                
                VStack{
                    HStack{
                        
                        Button(role: .destructive, action: {
                            showDeleteConfirmation = true
                        }, label: {
                            Spacer()
                            Text("清除所有資料")
                            Spacer()
                        })
                        .padding(5)
                        
                    }
                }
                .padding(10)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                
                Spacer()
                
                HStack{
                    Text("關於本程式")
                        .padding(.vertical, 1)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(5)
                
                VStack{
                    
                    VStack{
                        Image("logo")
                            .resizable() // 讓圖片可以縮放
                            .scaledToFit() // 保持圖片比例
                            .frame(width: 100, height: 100) // 設定大小
                            .clipShape(RoundedRectangle(cornerRadius: 20)) // 設定圓角
                            .padding()
                        
                        Text("學測個申分析系統")
                            .bold()
                        
                        Text("由 黃宥琦 開發")
                        
                    }
                    .padding(10)
                    
                    Divider()
                    
                    HStack{
                        
                        Text("程式版本")
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                        
                        Text("Developer v0.1")
                        
                    }
                    .padding(5)
                }
                .padding(10)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                
            }
            
        }
        .padding()
        .confirmationDialog("確定要清除所有資料嗎？", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            
            Button("確認刪除", role: .destructive){
                data.resetUserDefaults()
                selectedTab = 0
            }
            Button("取消", role: .cancel){
                // Cancel
            }
            
        } message: {
            Text("此操作會刪除您的成績資料與分析結果。\n清除後將返回主畫面，部分內容需要重新啟動程式才會生效。")
        }
        
        
    }
}


#Preview {
    AboutView(selectedTab: .constant(2))
        .environmentObject(Data())
}
