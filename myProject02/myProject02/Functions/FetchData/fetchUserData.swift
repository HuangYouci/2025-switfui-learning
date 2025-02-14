//
//  fetchUserData.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import FirebaseFirestore

class UserInfo: ObservableObject {
    
    @Published var loaded: Int = 0
    // Code: -1 (Error), 0 (Not Loaded), 1 (Loaded)
    
    @Published var userName: String = "載入中..."
    @Published var userIsAdmin: Bool = false
    @Published var userPoints: Int = 0
    @Published var userTime1Voucher: Int = 0
    @Published var userTime2Voucher: Int = 0
    @Published var userTime3Voucher: Int = 0
    
    func fetchUserData(userId: String) {
        
        checkAndCreateUserData(userId: userId)
        
        let db = Firestore.firestore()

        db.collection("users").document(userId).getDocument { (document, error) in
            if let error = error {
                print("func fetchUserData: fetchUserData 讀取錯誤：\(error.localizedDescription)")
                self.loaded = -1
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                DispatchQueue.main.async {
                    self.userName = data?["userName"] as? String ?? "用戶"
                    self.userIsAdmin = data?["userIsAdmin"] as? Bool ?? false
                    self.userPoints = data?["userPoints"] as? Int ?? 0
                    self.userTime1Voucher = data?["userTime1Voucher"] as? Int ?? 0
                    self.userTime2Voucher = data?["userTime2Voucher"] as? Int ?? 0
                    self.userTime3Voucher = data?["userTime3Voucher"] as? Int ?? 0
                    
                    self.loaded = 1
                }
            } else {
                print("func fetchUserData: 用戶資料不存在")
                self.loaded = -1
            }
        }
    }
    
    func checkAndCreateUserData(userId: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("func checkAndCreateUserData: 用戶資料已存在，無需建立")
            } else {
                print("func checkAndCreateUserData: 用戶資料不存在，正在建立...")
                
                // 設定初始用戶資料
                let userData: [String: Any] = [
                    "userName": "用戶",  // 預設用戶名稱
                    "userPoints": 0,    // 預設積分
                    "userTime1Voucher": 0,
                    "userTime2Voucher": 0,
                    "userTime3Voucher": 0,
                    "userIsAdmin": false
                ]
                
                userRef.setData(userData) { error in
                    if let error = error {
                        print("func checkAndCreateUserData: 建立用戶資料失敗: \(error.localizedDescription)")
                    } else {
                        print("func checkAndCreateUserData: 用戶資料成功建立！")
                    }
                }
            }
        }
    }

}
