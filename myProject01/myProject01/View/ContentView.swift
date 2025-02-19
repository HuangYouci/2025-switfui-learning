//
//  ContentView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/1/25.
//

import SwiftUI

struct ContentView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    @EnvironmentObject private var data: UserDef
    @EnvironmentObject var deptList: DeptDataModel
    // Binding
    // State
    @State private var selectedTab = 0
    // --------------- //
    
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("首頁")
                }
                .tag(0)
            
            ResultListView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "chart.line.text.clipboard")
                    Text("分析")
                }
                .tag(1)
            
            ListView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("清單")
                }
                .tag(3)
            
            AboutView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "person")
                    Text("關於")
                }
                .tag(2)
        }
    }
}
