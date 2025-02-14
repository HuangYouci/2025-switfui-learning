//
//  fetchPointsHistory.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import FirebaseFirestore
import Foundation

// 定義點數變更歷史資料的結構
struct PointsHistory: Identifiable {
    var id: String
    var oldPoints: Int
    var newPoints: Int
    var changeAmount: Int
    var reason: String
    var timestamp: Date
}

// ViewModel 來處理從 Firestore 讀取點數歷史
class PointsHistoryViewModel: ObservableObject {
    @Published var pointsHistory: [PointsHistory] = []  // 儲存歷史紀錄
    @Published var isLoading: Bool = false  // 是否正在加載
    @Published var errorMessage: String? = nil  // 錯誤訊息
    
    func fetchPointsHistory(userId: String) {
        self.isLoading = true  // 開始加載資料
        let db = Firestore.firestore()
        let pointsHistoryRef = db.collection("users").document(userId).collection("pointsHistory")
        
        pointsHistoryRef.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            self.isLoading = false  // 結束加載資料
            
            if let error = error {
                self.errorMessage = "讀取歷史紀錄失敗: \(error.localizedDescription)"
                return
            }
            
            // 清空目前的歷史紀錄並轉換為 PointsHistory 物件
            self.pointsHistory = snapshot?.documents.compactMap { document in
                let data = document.data()
                let oldPoints = data["oldPoints"] as? Int ?? 0
                let newPoints = data["newPoints"] as? Int ?? 0
                let changeAmount = data["changeAmount"] as? Int ?? 0
                let reason = data["reason"] as? String ?? "無原因"
                let timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
                
                return PointsHistory(
                    id: document.documentID,
                    oldPoints: oldPoints,
                    newPoints: newPoints,
                    changeAmount: changeAmount,
                    reason: reason,
                    timestamp: timestamp.dateValue()
                )
            } ?? []
        }
    }
}
