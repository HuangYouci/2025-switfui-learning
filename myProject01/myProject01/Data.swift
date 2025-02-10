//
//  Data.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/7.
//

import SwiftUI

class Data: ObservableObject {
    
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var gradeCH: Int {
        didSet {
            UserDefaults.standard.set(gradeCH, forKey: "gradeCH")
        }
    }
    
    @Published var gradeMA: Int {
        didSet {
            UserDefaults.standard.set(gradeMA, forKey: "gradeMA")
        }
    }
    
    @Published var gradeMB: Int {
        didSet {
            UserDefaults.standard.set(gradeMB, forKey: "gradeMB")
        }
    }
    
    @Published var gradeSC: Int {
        didSet {
            UserDefaults.standard.set(gradeSC, forKey: "gradeSC")
        }
    }
    
    @Published var gradeSO: Int {
        didSet {
            UserDefaults.standard.set(gradeSO, forKey: "gradeSO")
        }
    }
    
    @Published var gradeEN: Int {
        didSet {
            UserDefaults.standard.set(gradeEN, forKey: "gradeEN")
        }
    }
    
    @Published var gradeEL: Int {
        didSet {
            UserDefaults.standard.set(gradeEL, forKey: "gradeEL")
        }
    }
    
    @Published var gradePC: Int {
        didSet {
            UserDefaults.standard.set(gradePC, forKey: "gradePC")
        }
    }
    
    @Published var gradePP: Int {
        didSet {
            UserDefaults.standard.set(gradePP, forKey: "gradePP")
        }
    }
    
    @Published var gradeSK1: Int {
            didSet {
                UserDefaults.standard.set(gradeSK1, forKey: "gradeSK1")
            }
        }
        
    @Published var gradeSK2: Int {
        didSet {
            UserDefaults.standard.set(gradeSK2, forKey: "gradeSK2")
        }
    }
    
    @Published var gradeSK3: Int {
        didSet {
            UserDefaults.standard.set(gradeSK3, forKey: "gradeSK3")
        }
    }
    
    @Published var gradeSK4: Int {
        didSet {
            UserDefaults.standard.set(gradeSK4, forKey: "gradeSK4")
        }
    }
    
    @Published var gradeSK5: Int {
        didSet {
            UserDefaults.standard.set(gradeSK5, forKey: "gradeSK5")
        }
    }
    
    @Published var gradeSKT: Int {
        didSet {
            UserDefaults.standard.set(gradeSKT, forKey: "gradeSKT")
        }
    }
    
    @Published var displayMore: Int {
        didSet {
            UserDefaults.standard.set(displayMore, forKey: "displayMore")
        }
    }
    
    
    @Published var gradeTotal1: Int = 0
    @Published var gradeTotal2: Int = 0
    @Published var gradeTotal3: Int = 0
    
    init() {
        // 讀取 UserDefaults 中的值
        self.username = UserDefaults.standard.string(forKey: "username") ?? "用戶"
        self.gradeCH = UserDefaults.standard.integer(forKey: "gradeCH")
        self.gradeMA = UserDefaults.standard.integer(forKey: "gradeMA")
        self.gradeMB = UserDefaults.standard.integer(forKey: "gradeMB")
        self.gradeSC = UserDefaults.standard.integer(forKey: "gradeSC")
        self.gradeSO = UserDefaults.standard.integer(forKey: "gradeSO")
        self.gradeEN = UserDefaults.standard.integer(forKey: "gradeEN")
        self.gradeEL = UserDefaults.standard.integer(forKey: "gradeEL")
        self.gradePC = UserDefaults.standard.integer(forKey: "gradePC")
        self.gradePP = UserDefaults.standard.integer(forKey: "gradePP")
        self.gradeSK1 = UserDefaults.standard.integer(forKey: "gradeSK1")
        self.gradeSK2 = UserDefaults.standard.integer(forKey: "gradeSK2")
        self.gradeSK3 = UserDefaults.standard.integer(forKey: "gradeSK3")
        self.gradeSK4 = UserDefaults.standard.integer(forKey: "gradeSK4")
        self.gradeSK5 = UserDefaults.standard.integer(forKey: "gradeSK5")
        self.gradeSKT = UserDefaults.standard.integer(forKey: "gradeSKT")
        self.displayMore = UserDefaults.standard.integer(forKey: "displayMore")
        // 計算總分
        updateTotal()
    }
    
    // Functions
    
    func updateTotal(){
        gradeTotal1 = calculateGradeTotal(CH: true, MA: true, SC: true, EN: true)
        gradeTotal2 = calculateGradeTotal(CH: true, MA: true, SO: true, EN: true)
        gradeTotal3 = calculateGradeTotal(CH: true, MB: true, SO: true, EN: true)
    }
    
    func calculateGradeTotal(CH: Bool = false, MA: Bool = false, MB: Bool = false, SC: Bool = false, SO: Bool = false, EN: Bool = false) -> Int {
        return ((CH ? gradeCH : 0 ) + (MA ? gradeMA : 0 ) + (MB ? gradeMB : 0 ) + (SC ? gradeSC : 0 ) + (SO ? gradeSO : 0 ) + (EN ? gradeEN : 0 ))
    }
    
}
