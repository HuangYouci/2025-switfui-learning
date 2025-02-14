//
//  changeUserPoints.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import FirebaseFirestore

/// 更改指定用戶的積分並記錄在積分歷史中
/// - Parameters:
///   - userId: 要更改積分的用戶 ID
///   - pointsChange: 要更改的積分數值（可以是正數或負數）
func changeUserPoints(userId: String, pointsChange: Int, reason: String = "無原因") {
    let db = Firestore.firestore()
    
    // 取得使用者資料的參照
    let userRef = db.collection("users").document(userId)
    
    // 更新使用者的積分
    db.runTransaction { (transaction, errorPointer) -> Any? in
        let userDocument: DocumentSnapshot
        do {
            // 嘗試讀取使用者資料
            userDocument = try transaction.getDocument(userRef)
        } catch let error {
            print("讀取用戶資料失敗: \(error.localizedDescription)")
            return nil
        }
        
        // 檢查資料是否存在
        guard let currentPoints = userDocument.data()?["userPoints"] as? Int else {
            print("用戶資料不存在")
            return nil
        }
        
        // 計算新的積分
        let newPoints = currentPoints + pointsChange
        
        // 更新積分
        transaction.updateData(["userPoints": newPoints], forDocument: userRef)
        
        // 記錄積分歷史
        let pointsHistoryRef = userRef.collection("pointsHistory").document()
        let timestamp = Timestamp(date: Date())  // 當前時間
        let historyData: [String: Any] = [
            "changeAmount": pointsChange,
            "oldPoints": currentPoints,
            "newPoints": newPoints,
            "reason": reason,
            "timestamp": timestamp
        ]
        
        // 新增一條積分變動歷史紀錄
        transaction.setData(historyData, forDocument: pointsHistoryRef)
        
        return nil
    } completion: { (result, error) in
        if let error = error {
            print("交易失敗: \(error.localizedDescription)")
        } else {
            print("積分更改成功，並已記錄歷史")
        }
    }
}
