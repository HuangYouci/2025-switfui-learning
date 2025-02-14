//
//  UserDef.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

class UserDef: ObservableObject {
    
    
    @Published var uid: String {
        didSet {
            UserDefaults.standard.set(uid, forKey: "uid")
        }
    }
    
    @Published var userEmail: String {
        didSet {
            UserDefaults.standard.set(userEmail, forKey: "userEmail")
        }
    }
    
    init() {
        self.uid = UserDefaults.standard.string(forKey: "uid") ?? "0"
        self.userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? "0"
    }
    
}
