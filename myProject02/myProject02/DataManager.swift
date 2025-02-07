//
//  ScoreManager.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

class DataManager: ObservableObject {
    
    // UserData
    
    @Published var userScore: Int {
        didSet {
            UserDefaults.standard.set(userScore, forKey: "userScore")
        }
    }
    
    @Published var userName: String {
        didSet  {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    
    @Published var userItemA: Int {
        didSet {
            UserDefaults.standard.set(userItemA, forKey: "userItemA")
        }
    }
    
    @Published var userItemB: Int {
        didSet {
            UserDefaults.standard.set(userItemB, forKey: "userItemB")
        }
    }
    
    @Published var userItemC: Int {
        didSet {
            UserDefaults.standard.set(userItemC, forKey: "userItemC")
        }
    }
    
    // System
    
    @Published var systemPromo: Double {
        didSet {
            UserDefaults.standard.set(systemPromo, forKey: "systemPromo")
        }
    }
    
    init() {
        // UserData
        self.userScore = UserDefaults.standard.integer(forKey: "userScore")
        self.userItemA = UserDefaults.standard.integer(forKey: "userItemA")
        self.userItemB = UserDefaults.standard.integer(forKey: "userItemB")
        self.userItemC = UserDefaults.standard.integer(forKey: "userItemC")
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? "用戶"
        // System
        self.systemPromo = UserDefaults.standard.double(forKey: "systemPromo") == 0 ? 1 : UserDefaults.standard.double(forKey: "systemPromo")
    }
    
    // MARK: FUNCTIONS
    
    func setScore(_ setTo: Int){
        userScore = setTo
    }
    
    func modifyScore(_ setTo: Int){
        userScore += setTo
    }
    
    func setName(_ setTo: String){
        userName = setTo
    }
    
    func modifyItem(a: Int? = nil, b: Int? = nil, c: Int? = nil){
        userItemA += a ?? 0
        userItemB += b ?? 0
        userItemC += c ?? 0
    }
    
    func setItem(a: Int? = nil, b: Int? = nil, c: Int? = nil){
        userItemA = a ?? userItemA
        userItemB = b ?? userItemB
        userItemC = c ?? userItemC
    }
    
}
