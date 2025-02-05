//
//  Settings.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var editingTempName: String = ""
    @State private var showingConfirmationForDeleteAllData: Bool = false
    
    @FocusState private var isTextFieldFocusedOnName: Bool
    
    @EnvironmentObject var userData: DataManager
    
    var body: some View {
        VStack{
            HStack{
                Text("設定")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            Form {
                Section("基本資料") {
                    HStack{
                        Text("名稱")
                            .foregroundColor(.accentColor)
                        
                        TextField("請輸入顯示名稱", text: $editingTempName)
                            .focused($isTextFieldFocusedOnName)
                        
                        if isTextFieldFocusedOnName {
                            Button(role: .none, action: {
                                userData.setName(editingTempName)
                                isTextFieldFocusedOnName = false
                            }, label: {
                                Text("儲存")
                            })
                            .disabled(editingTempName.isEmpty)
                            .buttonStyle(.borderedProminent)
                        }
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
        }
        .confirmationDialog("確定要重置所有資料？", isPresented: $showingConfirmationForDeleteAllData, titleVisibility: .visible) {
                Button("確認", role: .destructive){
                    userData.resetScore()
                    userData.resetName()
                    editingTempName = "用戶"
                }
                Button("取消", role: .cancel){
                    //
                }
            } message: {
                Text("此操作不可逆！您的 \(userData.userScore) 積分將會被清除。")
            }
    }
    
}

#Preview {
    SettingsView().environmentObject(DataManager())
}
