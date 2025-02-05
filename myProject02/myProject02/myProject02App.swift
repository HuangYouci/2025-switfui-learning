//
//  myProject02App.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/1/30.
//

import SwiftUI

@main
struct myProject02App: App {
    
    @StateObject private var userData = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
