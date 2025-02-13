//
//  PersistenceController.swift
//  myProject03
//
//  Created by 黃宥琦 on 2025/2/13.
//

import CoreData

// PersistenceController 用來管理 Core Data 堆疊
class PersistenceController {
    // 單例，方便在全應用程式中使用
    static let shared = PersistenceController()

    // Core Data 的 container
    let container: NSPersistentContainer

    init() {
        // 指定資料模型名稱，這應該與你的 .xcdatamodeld 檔案名稱相同
        container = NSPersistentContainer(name: "TrainSchedule")
        
        // 載入 Persistent Stores
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
