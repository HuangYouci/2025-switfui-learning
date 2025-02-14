//
//  ContentView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/1/30.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userDef: UserDef
    
    @State private var isLoggedIn = false
    
    var body: some View {
            
        if isLoggedIn {
            MainView(isLoggedIn: $isLoggedIn)
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(UserDef())
}
