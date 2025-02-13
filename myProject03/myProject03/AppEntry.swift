//
//  myProject03App.swift
//  myProject03
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI
import CoreData

@main
struct myProject03App: App {
    
    let persistenceController = PersistenceController.shared
    
        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
}
