//
//  ContentView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/1/30.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView{
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView().environmentObject(DataManager())
}
