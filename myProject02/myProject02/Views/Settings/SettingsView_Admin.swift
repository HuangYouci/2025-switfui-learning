//
//  Admin.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//


import SwiftUI

struct AdminView: View {
    
    @State private var editingScore: String = ""
    @State private var editingRM: String = ""
    @State private var editingItemA: String = ""
    @State private var editingItemB: String = ""
    @State private var editingItemC: String = ""
    @State private var editingStorePromo: String = ""
    
    @State private var hasPremission: Bool = false
    @State private var editingPassword: String = ""
    
    @FocusState private var isTextFieldFocusedOnScore: Bool
    @FocusState private var isTextFieldFocusedOnRM: Bool
    @FocusState private var isTextFieldFocusedOnItemA: Bool
    @FocusState private var isTextFieldFocusedOnItemB: Bool
    @FocusState private var isTextFieldFocusedOnItemC: Bool
    @FocusState private var isTextFieldFocusedOnStorePromo: Bool
    
    @State private var showingConfirmationForReset: Bool = false
    
    @EnvironmentObject var userData: DataManager
    
    var body: some View {
        VStack{
            HStack{
                Text("管理員設定")
                    .font(.largeTitle)
                    .bold()
                    .padding()
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
                                .foregroundColor(Color(.systemGray))
                        }
                        
                    }
                    Section("獎勵積分") {
                        
                        HStack{
                            Text("獎勵積分")
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                            
                            TextField(String(userData.userScore), text: $editingScore)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnScore)
                                .onAppear {
                                    editingScore = String(userData.userScore)
                                }
                            
                            if isTextFieldFocusedOnScore {
                                Button(role: .none, action: {
                                    
                                    userData.setScore(Int(editingScore) ?? 0)
                                    editingScore = ""
                                    isTextFieldFocusedOnScore = false
                                    
                                }, label: {
                                    Text("變更")
                                })
                                .disabled(editingScore.isEmpty || (editingScore == String(userData.userScore)))
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                        HStack{
                            Text("增減積分")
                                .foregroundColor(.accentColor)
                            
                            TextField("請輸入正負整數", text: $editingRM)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnRM)
                            
                            if isTextFieldFocusedOnRM {
                                Button(role: .none, action: {
                                    
                                    userData.modifyScore(Int(editingRM) ?? 0)
                                    editingScore = String(userData.userScore)
                                    editingRM = ""
                                    isTextFieldFocusedOnRM = false
                                    
                                }, label: {
                                    Text("執行")
                                })
                                .disabled(editingRM.isEmpty)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    Section("兌換券") {
                        
                        HStack{
                            Text("15 分鐘")
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                            
                            TextField(String(userData.userItemA), text: $editingItemA)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnItemA)
                                .onAppear {
                                    editingItemA = String(userData.userItemA)
                                }
                            
                            if isTextFieldFocusedOnItemA {
                                Button(role: .none, action: {
                                    
                                    userData.setItem(a: Int(editingItemA) ?? 0)
                                    editingItemA = ""
                                    isTextFieldFocusedOnItemA = false
                                    
                                }, label: {
                                    Text("變更")
                                })
                                .disabled(editingItemA.isEmpty || (editingItemA == String(userData.userItemA)))
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                        HStack{
                            Text("1 小時")
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                            
                            TextField(String(userData.userItemB), text: $editingItemB)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnItemB)
                                .onAppear {
                                    editingItemB = String(userData.userItemB)
                                }
                            
                            if isTextFieldFocusedOnItemB {
                                Button(role: .none, action: {
                                    
                                    userData.setItem(b: Int(editingItemB) ?? 0)
                                    editingItemB = ""
                                    isTextFieldFocusedOnItemB = false
                                    
                                }, label: {
                                    Text("變更")
                                })
                                .disabled(editingItemB.isEmpty || (editingItemB == String(userData.userItemB)))
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                        HStack{
                            Text("整天")
                                .foregroundStyle(Color.accentColor)
                            Spacer()
                            
                            TextField(String(userData.userItemC), text: $editingItemC)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocusedOnItemC)
                                .onAppear {
                                    editingItemC = String(userData.userItemC)
                                }
                            
                            if isTextFieldFocusedOnItemC {
                                Button(role: .none, action: {
                                    
                                    userData.setItem(c: Int(editingItemC) ?? 0)
                                    editingItemC = ""
                                    isTextFieldFocusedOnItemC = false
                                    
                                }, label: {
                                    Text("變更")
                                })
                                .disabled(editingItemC.isEmpty || (editingItemC == String(userData.userItemC)))
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        
                    }
                    Section("商店優惠") {
                        VStack{
                            HStack{
                                Text("全面折扣")
                                    .foregroundColor(Color.accentColor)
                                Spacer()
                                TextField("\(String(userData.systemPromo))", text: $editingStorePromo)
                                    .multilineTextAlignment(.trailing)
                                    .focused($isTextFieldFocusedOnStorePromo)
                                    .keyboardType(.decimalPad)
                                Text("倍")
                                    .foregroundColor(Color(.systemGray))
                                
                                if isTextFieldFocusedOnStorePromo {
                                    Button(role: .none, action: {
                                        
                                        userData.systemPromo = Double(editingStorePromo) ?? 1.0
                                        
                                        isTextFieldFocusedOnStorePromo = false
                                        
                                    }, label: {
                                        Text("變更")
                                    })
                                    .disabled(editingStorePromo == String(userData.systemPromo))
                                    .buttonStyle(.borderedProminent)
                                }
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
                    TextField("密碼", text: $editingPassword)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .cornerRadius(20)
                        .border(Color.accentColor, width: 1)
                        .frame(maxWidth: 230, minHeight: 50)
                    Spacer()
                }
                
                Button(role: .none, action: {
                    if editingPassword == "950509" {
                        hasPremission = true
                        editingPassword = ""
                    } else {
                        editingPassword = ""
                    }
                }, label: {
                    Text("送出")
                })
                .buttonStyle(.borderedProminent)
                .padding(10)
                
                Spacer()
            }
        }
        .confirmationDialog("確定要重置獎勵積分和兌換券？", isPresented: $showingConfirmationForReset, titleVisibility: .visible) {
                Button("確認", role: .destructive){
                    userData.setScore(0)
                    userData.setItem(a: 0, b: 0, c: 0)
                    editingScore = "0"
                }
                Button("取消", role: .cancel){
                    //
                }
            } message: {
                Text("此操作不可逆！\(userData.userName) 的 \(userData.userScore) 積分、\(userData.userItemA) 個十五分鐘兌換券、\(userData.userItemB) 個一小時兌換券和 \(userData.userItemC) 整天兌換券將會被清除。")
            }
    }
    
}

#Preview {
    AdminView().environmentObject(DataManager())
}
