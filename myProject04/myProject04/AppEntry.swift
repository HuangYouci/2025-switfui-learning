//
//  myProject04App.swift
//  myProject04
//
//  Created by 黃宥琦 on 2025/2/15.
//

import SwiftUI

@main
struct myProject04App: App {
    
    // --------------------- //
    // StateObject
    @StateObject var contactData = ContactManager()
    @StateObject var userDef = UserDef()
    // EnvironmentObject
    // Binding
    // State
    // --------------------- //
    
    var body: some Scene {
        WindowGroup {
            
            if userDef.isFirstLaunch {
                OnboardingView(isFirstLaunch: $userDef.isFirstLaunch)
                    .environmentObject(contactData)
            } else {
                ContentView()
                    .environmentObject(contactData)
            }
        }
    }
}
