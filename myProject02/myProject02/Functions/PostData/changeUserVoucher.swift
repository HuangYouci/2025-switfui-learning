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
///   - itemID: 商品代號
///   - change: 要更改的數值（可以是正數或負數）

func changeUserVoucher(userId: String, itemID: Int, change: Int) {
    let db = Firestore.firestore()
    let userRef = db.collection("users").document(userId)
    
    // 確定要更新的欄位名稱
    var fieldName: String
    switch itemID {
    case 1:
        fieldName = "userTime1Voucher"
    case 2:
        fieldName = "userTime2Voucher"
    case 3:
        fieldName = "userTime3Voucher"
    default:
        print("無效的 itemID")
        return
    }
    
    // 執行 Firestore 更新
    userRef.updateData([fieldName: FieldValue.increment(Int64(change))]) { error in
        if let error = error {
            print("更新失敗: \(error.localizedDescription)")
        } else {
            print("成功更新 \(fieldName) 增加 \(change)")
        }
    }
}
