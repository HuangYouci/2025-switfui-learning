//
//  myProject01App.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/1/25.
//

import SwiftUI

@main
struct myProject01App: App {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    @StateObject private var data = UserDef()
    @StateObject private var deptList = DeptDataModel()
    // Binding
    // State
    // --------------- //
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
                .environmentObject(deptList)
        }
    }
    
}
