//
//  Admin.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//


import SwiftUI

struct AdminView: View {
    
    @State private var editingTempScore: String = ""
    @State private var editingTempScore2: String = ""
    
    @State private var hasPremission: Bool = false
    @State private var password: String = ""
    
    @FocusState private var isTextFieldFocusedOnScore: Bool
    @FocusState private var isTextFieldFocusedOnScore2: Bool
    
    @State private var showingConfirmationForReset: Bool = false
    
    @EnvironmentObject var userData: DataManager
    
    var body: some View {
        VStack{
            HStack{
                Text("管理員設定")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            if hasPremission {
                
                Form {
                    Section("基本資料") {
                        HStack{
                            Text("用戶名稱")
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                            Text("\(userData.userName)")
                        }
                        HStack{
                            Text("獎勵積分")
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                            Text("\(userData.userScore)")
                        }
                    }
                    Section("調整獎勵積分") {
                        HStack{
                            Text("直接設置")
                                .foregroundColor(.accentColor)
                            
                            TextField("請輸入整數", text: $editingTempScore)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnScore)
                            
                            if isTextFieldFocusedOnScore {
                                Button(role: .none, action: {
                                    userData.setScore(Int(editingTempScore) ?? 0)
                                    editingTempScore = ""
                                    isTextFieldFocusedOnScore = false
                                }, label: {
                                    Text("儲存")
                                })
                                .disabled(editingTempScore.isEmpty)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                        HStack{
                            Text("增加減少")
                                .foregroundColor(.accentColor)
                            
                            TextField("請輸入正負整數", text: $editingTempScore2)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnScore2)
                            
                            if isTextFieldFocusedOnScore2 {
                                Button(role: .none, action: {
                                    userData.modifyScore(Int(editingTempScore2) ?? 0)
                                    editingTempScore2 = ""
                                    isTextFieldFocusedOnScore2 = false
                                }, label: {
                                    Text("執行")
                                })
                                .disabled(editingTempScore.isEmpty)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                    }
                    Section("其他操作"){
                        
                        Button(role: .cancel, action: {
                            hasPremission = false
                        }, label: {
                            Text("登出")
                        })
                        
                        Button(role: .destructive, action: {
                            showingConfirmationForReset = true
                        }, label: {
                            Text("重置")
                        })
                        
                    }
                }
                
            } else {
                Spacer()
                
                Text("請輸入密碼以進入本畫面")
                    .font(.title3)
                
                HStack{
                    Spacer()
                    TextField("密碼", text: $password)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .cornerRadius(20)
                        .border(Color.accentColor, width: 1)
                        .frame(maxWidth: 230, minHeight: 50)
                    Spacer()
                }
                
                Button(role: .none, action: {
                    if password == "950509" {
                        hasPremission = true
                        password = ""
                    }
                }, label: {
                    Text("送出")
                })
                .buttonStyle(.borderedProminent)
                .padding(10)
                
                Spacer()
            }
        }
        .confirmationDialog("確定要重置獎勵積分？", isPresented: $showingConfirmationForReset, titleVisibility: .visible) {
                Button("確認", role: .destructive){
                    userData.resetScore()
                }
                Button("取消", role: .cancel){
                    //
                }
            } message: {
                Text("此操作不可逆！\(userData.userName) 的 \(userData.userScore) 積分將會被清除。")
            }
        
    }
    
}

#Preview {
    AdminView().environmentObject(DataManager())
}
