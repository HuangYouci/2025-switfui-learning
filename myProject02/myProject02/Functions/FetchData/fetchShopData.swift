//
//  fetchShopData.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import FirebaseFirestore

class ShopData: ObservableObject {
    
    @Published var loaded: Int = 0
    // Code: -1 (Error), 0 (Not Loaded), 1 (Loaded)
    
    @Published var t1o: Int = 10000
    @Published var t1s: Int = 10000
    @Published var t2o: Int = 10000
    @Published var t2s: Int = 10000
    @Published var t3o: Int = 10000
    @Published var t3s: Int = 10000
    
    // 假設我們要讀取全域資料中的 "settingsDocument"
    func fetchShopData() {
        let db = Firestore.firestore()

        // 讀取 "System/globalSettings/settingsDocument" 文檔
        db.collection("system").document("shopData").getDocument { (document, error) in
            if let error = error {
                print("func fetchShopData: 讀取錯誤：\(error.localizedDescription)")
                self.loaded = -1
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                DispatchQueue.main.async {
                    self.t1o = data?["t1o"] as? Int ?? 10000
                    self.t1s = data?["t1s"] as? Int ?? 10000
                    self.t2o = data?["t2o"] as? Int ?? 10000
                    self.t2s = data?["t2s"] as? Int ?? 10000
                    self.t3o = data?["t3o"] as? Int ?? 10000
                    self.t3s = data?["t3s"] as? Int ?? 10000
                    
                    self.loaded = 1
                }
            } else {
                print("func fetchShopData: 資料不存在")
                self.loaded = -1
            }
        }
    }
    
}
