//
//  Data.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/7.
//

import SwiftUI

struct gradeData: Identifiable, Codable {
    var id = UUID()
    var gradeCH: Int
    var gradeEN: Int
    var gradeMA: Int
    var gradeMB: Int
    var gradeSC: Int
    var gradeSO: Int
    var gradeEL: Int
    var gradePC: Int
    var gradePP: Int
    var gradeSK1: Int
    var gradeSK2: Int
    var gradeSK3: Int
    var gradeSK4: Int
    var gradeSK5: Int
    var gradeSKT: Int
}

class UserDef: ObservableObject {
    
    // 用戶名稱
    
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var userpurchased: Bool {
        didSet {
            UserDefaults.standard.set(userpurchased, forKey: "userpurchased")
        }
    }
    
    // 分析結果資料
    
    @Published var userResultData: [gradeData] {
        didSet {
            saveUserResultData()
        }
    }
    
    private func saveUserResultData() {
            if let encoded = try? JSONEncoder().encode(userResultData) {
                UserDefaults.standard.set(encoded, forKey: "userResultData")
            }
        }
    
    private static func loadUserResultData() -> [gradeData]? {
            if let savedData = UserDefaults.standard.data(forKey: "userResultData"),
               let decodedData = try? JSONDecoder().decode([gradeData].self, from: savedData) {
                return decodedData
            }
            return nil
        }
    
    // 偏好設置
    
    @Published var displayMore: Int {
        didSet {
            UserDefaults.standard.set(displayMore, forKey: "displayMore")
        }
    }
    
    @Published var favoriteDept: [String] {
        didSet {
            UserDefaults.standard.set(favoriteDept, forKey: "favoriteDept")
        }
    }
    
    // 可分析次數
    
    @Published var analyzeCount: Int {
        didSet {
            UserDefaults.standard.set(analyzeCount, forKey: "analyzeCount")
        }
    }
    
    // 開過沒
    
    @Published var notFirstUse: Bool {
        didSet {
            UserDefaults.standard.set(notFirstUse, forKey: "notFirstUse")
        }
    }
    
    // MARK: 初始化
    
    init() {
        // 讀取 UserDefaults 中的值
        self.username = UserDefaults.standard.string(forKey: "username") ?? "用戶"
        self.userpurchased = UserDefaults.standard.bool(forKey: "userpurchased")
        self.userResultData = Self.loadUserResultData() ?? [gradeData(gradeCH: 11, gradeEN: 14, gradeMA: 7, gradeMB: 11, gradeSC: 12, gradeSO: 11, gradeEL: 1, gradePC: 3, gradePP: 3, gradeSK1: 0, gradeSK2: 0, gradeSK3: 0, gradeSK4: 0, gradeSK5: 0, gradeSKT: 0)]
        self.displayMore = UserDefaults.standard.integer(forKey: "displayMore")
        self.favoriteDept = UserDefaults.standard.array(forKey: "favoriteDept") as? [String] ?? []
        self.analyzeCount = UserDefaults.standard.integer(forKey: "analyzeCount")
        self.notFirstUse = UserDefaults.standard.bool(forKey: "notFirstUse")
    }
    
    // MARK: Functions
    
    // 插入一筆新資料
    
    func addNewResultData(gradeCH: Int = 0, gradeEN: Int = 0, gradeMA: Int = 0, gradeMB: Int = 0, gradeSC: Int = 0, gradeSO: Int = 0, gradeEL: Int = 0, gradePC: Int = 0, gradePP: Int = 0, gradeSK1: Int = 0, gradeSK2: Int = 0, gradeSK3: Int = 0, gradeSK4: Int = 0, gradeSK5: Int = 0, gradeSKT: Int = 0) {
        let appendData = gradeData(gradeCH: gradeCH, gradeEN: gradeEN, gradeMA: gradeMA, gradeMB: gradeMB, gradeSC: gradeSC, gradeSO: gradeSO, gradeEL: gradeEL, gradePC: gradePC, gradePP: gradePP, gradeSK1: gradeSK1, gradeSK2: gradeSK2, gradeSK3: gradeSK3, gradeSK4: gradeSK4, gradeSK5: gradeSK5, gradeSKT: gradeSKT)
        userResultData.append(appendData)
        print(userResultData)
    }
    
    // 重置所有資料
    
    func resetUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}
