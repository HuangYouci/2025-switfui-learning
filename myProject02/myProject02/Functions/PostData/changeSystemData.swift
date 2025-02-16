//
//  changeSystemData.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import FirebaseFirestore

/// 更改兌換券價格
func changeShopPrice(changeID: Int, price: Int) {
    
    let db = Firestore.firestore()
    
    let ref = db.collection("system").document("shopData")
    
    db.runTransaction { (transaction, errorPointer) -> Any? in
        
        
        /*
        let item: DocumentSnapshot
        do {
            // 嘗試讀取使用者資料
            item = try transaction.getDocument(ref)
        } catch let error {
            print("讀取商店資料失敗: \(error.localizedDescription)")
            return nil
        }
        
        // 檢查資料是否存在
        guard let t1o = item.data()?["t1o"] as? Int else {
            print("商店資料不存在")
            return nil
        }
        guard let t1s = item.data()?["t1s"] as? Int else {
            print("商店資料不存在")
            return nil
        }
        guard let t2o = item.data()?["t2o"] as? Int else {
            print("商店資料不存在")
            return nil
        }
        guard let t2s = item.data()?["t2s"] as? Int else {
            print("商店資料不存在")
            return nil
        }
        guard let t3o = item.data()?["t3o"] as? Int else {
            print("商店資料不存在")
            return nil
        }
        guard let t3s = item.data()?["t3s"] as? Int else {
            print("商店資料不存在")
            return nil
        }
         */
        
        // 更新積分
        switch changeID {
        case 1:
            transaction.updateData(["t1o": price], forDocument: ref)
        case 2:
            transaction.updateData(["t1s": price], forDocument: ref)
        case 3:
            transaction.updateData(["t2o": price], forDocument: ref)
        case 4:
            transaction.updateData(["t2s": price], forDocument: ref)
        case 5:
            transaction.updateData(["t3o": price], forDocument: ref)
        case 6:
            transaction.updateData(["t3s": price], forDocument: ref)
        default: break
        }
        
        return nil
        
    } completion: { (result, error) in
        if let error = error {
            print("商店更改失敗: \(error.localizedDescription)")
        } else {
            print("商店更改成功")
        }
    }
}
