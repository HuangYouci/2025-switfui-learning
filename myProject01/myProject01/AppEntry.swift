//
//  myProject01App.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/1/25.
//

import SwiftUI
import GoogleMobileAds

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
    
    class AppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            MobileAds.shared.start(completionHandler: nil)
            return true
        }
    }
    
    var body: some Scene {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        
        WindowGroup {
            if !data.notFirstUse {
                FirstInfoView()
                    .environmentObject(data)
            } else {
                ContentView()
                    .environmentObject(data)
                    .environmentObject(deptList)
            }
        }
    }
    
}
