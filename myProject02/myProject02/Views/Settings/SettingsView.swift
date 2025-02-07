//
//  Settings.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var editingName: String = ""
    @State private var showingConfirmationForDeleteAllData: Bool = false
    @State private var goingToAdminView: Bool = false
    
    @FocusState private var isTextFieldFocusedOnName: Bool
    
    @EnvironmentObject var userData: DataManager
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("設定")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Spacer()
                }
                
                Form {
                    Section("基本資料") {
                        HStack{
                            Text("名稱")
                                .foregroundColor(.accentColor)
                            
                            TextField("請輸入顯示名稱", text: $editingName)
                                .multilineTextAlignment(.trailing)
                                .focused($isTextFieldFocusedOnName)
                                .onAppear{
                                    editingName = userData.userName
                                }
                            
                            if isTextFieldFocusedOnName {
                                Button(role: .none, action: {
                                    userData.setName(editingName)
                                    isTextFieldFocusedOnName = false
                                }, label: {
                                    Text("儲存")
                                })
                                .disabled(editingName.isEmpty)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    
                    Section("管理員功能"){
                        HStack{
                            
                            Button(role: .none, action: {
                                
                                goingToAdminView = true
                                
                            }, label: {
                                Text("管理員設定")
                            })
                        }
                    }
                    
                    Section("毀滅性功能"){
                        
                        HStack{
                            Spacer()
                            
                            Button(role: .destructive, action: {
                                showingConfirmationForDeleteAllData = true
                            }, label: {
                                Text("清除所有資料")
                            })
                            
                            Spacer()
                        }
                        
                    }
                }
                
                NavigationLink("", destination: AdminView(), isActive: $goingToAdminView)
                
            }
            .confirmationDialog("確定要重置所有資料？", isPresented: $showingConfirmationForDeleteAllData, titleVisibility: .visible) {
                Button("確認", role: .destructive){
                    userData.setScore(0)
                    userData.setName("用戶")
                    userData.setItem(a: 0, b: 0, c: 0)
                    editingName = "用戶"
                }
                Button("取消", role: .cancel){
                    //
                }
            } message: {
                Text("此操作不可逆！您的 \(userData.userScore) 積分、\(userData.userItemA) 個十五分鐘兌換券、\(userData.userItemB) 個一小時兌換券和 \(userData.userItemC) 整天兌換券將會被清除。")
            }
        }
    }
    
}

#Preview {
    SettingsView().environmentObject(DataManager())
}
