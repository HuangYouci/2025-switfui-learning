//
//  ScoreManager.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

class DataManager: ObservableObject {
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
    
    init() {
        self.userScore = UserDefaults.standard.integer(forKey: "userScore")
        
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? "用戶"
    }
    
    func resetScore() {
        userScore = 0
    }
    
    func setScore(_ setTo: Int){
        userScore = setTo
    }
    
    func modifyScore(_ setTo: Int){
        userScore += setTo
    }
                                      
    func resetName() {
        userName = "用戶"
    }
    
    func setName(_ setTo: String){
        userName = setTo
    }
    
}
