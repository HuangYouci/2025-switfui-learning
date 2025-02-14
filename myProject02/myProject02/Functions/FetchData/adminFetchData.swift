//
//  adminFetchData.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import FirebaseFirestore

struct User: Identifiable {
    var id: String
    var userName: String
    var userPoints: Int
    var userIsAdmin: Bool
    var userTime1Voucher: Int
    var userTime2Voucher: Int
    var userTime3Voucher: Int
}

class AdminViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers() {
        let db = Firestore.firestore()
        
        // 讀取 Firestore 資料
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print("讀取用戶資料錯誤：\(error.localizedDescription)")
                return
            }
            
            print("成功讀取到用戶資料：\(snapshot?.documents.count ?? 0) 個用戶")
            
            // 確保 snapshot 存在並處理資料
            self.users = snapshot?.documents.compactMap { document in
                let data = document.data()
                let userName = data["userName"] as? String ?? "未知"
                let userPoints = data["userPoints"] as? Int ?? 0
                let userIsAdmin = data["userIsAdmin"] as? Bool ?? false
                let userTime1Voucher = data["userTime1Voucher"] as? Int ?? 0
                let userTime2Voucher = data["userTime2Voucher"] as? Int ?? 0
                let userTime3Voucher = data["userTime3Voucher"] as? Int ?? 0
                
                return User(
                    id: document.documentID,
                    userName: userName,
                    userPoints: userPoints,
                    userIsAdmin: userIsAdmin,
                    userTime1Voucher: userTime1Voucher,
                    userTime2Voucher: userTime2Voucher,
                    userTime3Voucher: userTime3Voucher
                )
            } ?? []
        }
    }
}
