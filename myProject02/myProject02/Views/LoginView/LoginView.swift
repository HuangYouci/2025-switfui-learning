//
//  LoginView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var userDef: UserDef
    
    @Binding var isLoggedIn: Bool
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var errorMessage: String? = nil
    @State private var cannotLogin: Bool = false
    @State private var progressLogin: Bool = false
    @State private var autoLogin: Bool = false
    
    // 登入的函數
    func loginUser() {
        // 清除先前的錯誤訊息
        errorMessage = nil
        
        // 使用 Firebase Auth 登入
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                    // 登入失敗
                    errorMessage = error.localizedDescription
                    cannotLogin = true
                    progressLogin = false
                } else if let user = result?.user {
                    // 登入成功
                    userDef.uid = user.uid
                    userDef.userEmail = user.email ?? "null"
                    isLoggedIn = true
                    progressLogin = false
                } else {
                    // 不應該發生的情況（除非 Firebase 有 Bug）
                    errorMessage = "未知錯誤"
                    cannotLogin = true
                    progressLogin = false
                }
        }
        
        
    }
    
    var body: some View {
        
        VStack {
            
            VStack{
                HStack{
                    Text("歡迎使用獎勵積分系統")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Spacer()
                }
            }
            .foregroundColor(Color.white)
            .shadow(radius: 5)
            
            Spacer()
            
            VStack{
                
                HStack{
                    Text("登入")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                HStack{
                    Text("以存取獎勵積分系統")
                    Spacer()
                }

                HStack{
                    Image(systemName: "envelope.open.fill")
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .background(Color(.systemGray).opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray).opacity(0.2), lineWidth: 1)
                            )
                        
                    TextField("帳號", text: $email)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding()
                .background(
                    BlurView(style: .systemThinMaterial)
                        .cornerRadius(20)
                    )
                
                // 輸入密碼
                
                HStack{
                    Image(systemName: "key.fill")
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .background(Color(.systemGray).opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray).opacity(0.2), lineWidth: 1)
                            )
                        
                    TextField("密碼", text: $password)
                        .keyboardType(.asciiCapable)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding()
                .background(
                    BlurView(style: .systemThinMaterial)
                        .cornerRadius(20)
                    )
                
                
                // 登入按鈕
                Button(role: .none) {
                    progressLogin = true
                    loginUser()
                } label: {
                    Text("登入")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .disabled(progressLogin)
                
                // 顯示錯誤訊息
                if cannotLogin {
                    Text("帳號或密碼錯誤，請重試！")
                        .foregroundColor(.red)
                        .padding(.vertical, 5)
                }
                
                // 許可協議
                
                HStack{
                    Text("登入表示你接受本程式的許可協議")
                        .font(.footnote)
                        .foregroundColor(Color(.systemGray2))
                    Spacer()
                }
                .padding(.vertical, 5)
                
                
                // 註冊資訊
                
                Divider()
                
                HStack{
                    Text("沒有帳號嗎？請洽程式管理員以協助註冊。")
                        .font(.footnote)
                        .foregroundColor(Color(.systemGray2))
                    Spacer()
                }
                .padding(.top, 5)
                
            }
            .padding()
            .background(
                BlurView(style: .systemThickMaterial)
                .cornerRadius(20)
            )
                
        }
        .padding()
        .background(Image("bgLogin"))
        .onAppear {
            // 自動登入（當之前登入過）
            if userDef.uid != "0" {
                withAnimation {
                    autoLogin = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3 ){
                    isLoggedIn = true
//                    autoLogin = false
                }
            }
        }
        .overlay( autoLogin ? AnyView(AutoLogin()) : AnyView(EmptyView()) )
        
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
        .environmentObject(UserDef())
}
