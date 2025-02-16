//
//  AdminUsersDetailView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct AdminUsersDetailView: View {
    
    // 本 VIEW 新增環境變數
    @StateObject var userData: UserInfo = UserInfo()
    // 繼承環境變數
    // 本 VIEW 綁定變數
    
    @State private var keyboardHeight: CGFloat = 0

    var uid: String
    
    @State var editingTF1: String = ""
    @State var editingTF2: String = ""
    @State var editingTF3: String = ""
    @State var editingTF4: Int = 1
    @State var doneHint: String = ""
    @State var doneHintTFG2: String = ""
    @State var updateHint: Bool = false
    @State var updateHintTFG2: Bool = false

    var body: some View {
        
        VStack{
            
            VStack{
                
                HStack{
                    Text("變更使用者資料")
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
                
                HStack{
                    Text(userData.userName)
                        .font(.title)
                        .bold()
                    if ( userData.userIsAdmin == true ) {
                        Text("管理員")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color(.red))
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                
                HStack{
                    Image(systemName: "person.text.rectangle.fill")
                        .frame(width: 12, height: 12)
                        .padding(5)
                        .background(Color(.systemGray).opacity(0.1))
                        .cornerRadius(10)
                    Text(verbatim: userData.userId)
                    Spacer()
                }
                .padding(.bottom)
                
                NavigationLink(destination: HistoryView(uid: userData.userId)){
                    VStack{
                        HStack{
                            Text("獎勵積分")
                            Spacer()
                            
                        }
                        HStack{
                            Spacer()
                            Text(String(userData.userPoints))
                                .font(.title)
                                .bold()
                                .foregroundColor(.accentColor)
                        }
                    }
                    .font(.title3)
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                }
                
                VStack{
                    HStack{
                        Text("15分鐘兌換券")
                        Spacer()
                        Text(String(userData.userTime1Voucher))
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    
                    Divider()
                        .padding(.bottom, 5)
                    
                    HStack{
                        Text("1小時兌換券")
                        Spacer()
                        Text(String(userData.userTime2Voucher))
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    
                    Divider()
                        .padding(.bottom, 5)
                    
                    HStack{
                        Text("整天兌換券")
                        Spacer()
                        Text(String(userData.userTime3Voucher))
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    
                }
                .font(.title3)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
                .padding(.bottom, 10)
                
                Divider()
                    .padding(.bottom)
                
                VStack{
                    HStack{
                        Text("增減獎勵積分")
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "number")
                            .frame(width: 20)
                        TextField("正負整數", text: $editingTF1)
                            .keyboardType(.numbersAndPunctuation)
                            .onChange(of: editingTF1) { newValue in
                                // 過濾非數字和非 - 符號的字符
                                let filteredValue = newValue.filter { "0123456789-".contains($0) }
                                if newValue != filteredValue {
                                    editingTF1 = filteredValue
                                }
                            }
                    }
                    
                    HStack{
                        Image(systemName: "text.quote")
                            .frame(width: 20)
                        TextField("原因", text: $editingTF2)
                    }
                    
                    HStack{
                        Spacer()
                        Text(doneHint)
                            .foregroundColor(.green)
                        Button(role: .none){
                            if editingTF2.isEmpty { editingTF2 = "無原因" }
                            changeUserPoints(userId: userData.userId, pointsChange: (Int(editingTF1) ?? 0), reason: editingTF2)
                            doneHint = "已異動 \(userData.userName) 獎勵積分 \(editingTF1) 點"
                            updateHint = true
                            editingTF1 = ""
                            editingTF2 = ""
                            userData.fetchUserData(userId: userData.userId)
                        } label: {
                            Text("執行")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(editingTF1.isEmpty)
                    }
                    
                }
                    .padding(.bottom)
                
                VStack{
                    HStack{
                        Text("增減時間兌換券")
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "number")
                            .frame(width: 20)
                        TextField("正負整數", text: $editingTF3)
                            .keyboardType(.numbersAndPunctuation)
                            .onChange(of: editingTF3) { newValue in
                                // 過濾非數字和非 - 符號的字符
                                let filteredValue = newValue.filter { "0123456789-".contains($0) }
                                if newValue != filteredValue {
                                    editingTF3 = filteredValue
                                }
                            }
                    }
                    
                    HStack{
                        Image(systemName: "list.number")
                            .frame(width: 20)
                        Picker("選擇", selection: $editingTF4){
                            Text("15分鐘兌換券")
                                .tag(1)
                            Text("1小時兌換券")
                                .tag(2)
                            Text("整天兌換券")
                                .tag(3)
                        }
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Text(doneHintTFG2)
                            .foregroundColor(.green)
                        Button(role: .none){
                            changeUserVoucher(userId: userData.userId, itemID: editingTF4, change: Int(editingTF3) ?? 0)
                            doneHintTFG2 = "已異動 \(userData.userName) 物品 \(editingTF4) \(editingTF3) 個"
                            updateHintTFG2 = true
                            editingTF3 = ""
                            editingTF4 = 1
                            userData.fetchUserData(userId: userData.userId)
                        } label: {
                            Text("執行")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(editingTF3.isEmpty || editingTF4 < 1 )
                    }
                    
                }
                
            }
            .simultaneousGesture(
                DragGesture().onChanged { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                 to: nil,
                                                 from: nil,
                                                 for: nil)
                }
            ) // 關閉鍵盤 (iOS 15)
            .padding()
            .background(
                BlurView(style: .systemThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .padding()
            
        }
        .onAppear {
            userData.fetchUserData(userId: uid)
        }
        .background(Image("bgLogin").opacity(0.3).ignoresSafeArea())
        
    }
    
}

