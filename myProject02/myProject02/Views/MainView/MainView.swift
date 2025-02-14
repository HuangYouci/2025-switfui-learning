//
//  MainView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct MainView: View {
    
    // 本 VIEW 新增環境變數
    @StateObject private var userInfo = UserInfo()
    // 繼承環境變數
    @EnvironmentObject var userDef: UserDef
    // 本 VIEW 綁定變數
    @Binding var isLoggedIn: Bool
    
    @State private var loggingOut = false
    
    var body: some View {
        
        ZStack {
            HomeView(loggingOut: $loggingOut)
                .environmentObject(userInfo)
                .environmentObject(userDef)
            
            // 尚未載入
            if userInfo.loaded == 0 {
                ProgressingView()
            }
            
        }
        .onAppear{
            if userDef.uid != "0" {
                userInfo.fetchUserData(userId: userDef.uid)
            } else {
                isLoggedIn = false
            }
        }
        .onChange(of: loggingOut) { newValue in
            if newValue {
                userDef.uid = "0"
                userDef.userEmail = ""
                isLoggedIn = false
                loggingOut = false
            }
        }
        .onChange(of: userInfo.loaded ) { errorcode in
            if errorcode == -1 {
                loggingOut = true
            }
        }
        
    }
        
}

#Preview {
    MainView(isLoggedIn: .constant(true))
        .environmentObject(UserDef())
}
