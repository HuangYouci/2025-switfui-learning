//
//  Untitled.swift
//  myProject04
//
//  Created by 黃宥琦 on 2025/2/15.
//

import SwiftUI
import Contacts

    
// 檢查有無權限

func handleContactPermission(completion: @escaping (Int) -> Void) {
    let status = CNContactStore.authorizationStatus(for: .contacts)
    
    switch status {
    case .authorized:
        print("已授權存取聯絡人")
        completion(1)  // 授權成功
    case .denied:
        print("使用者拒絕授權")
        completion(-1)  // 授權拒絕
    case .restricted:
        print("權限受限，無法存取")
        completion(-2)  // 權限受限
    case .notDetermined:
        print("尚未選擇是否授權")
        requestContactAccess { granted in
            if granted {
                print("授權成功")
                completion(1)
            } else {
                print("授權失敗")
                completion(-1)
            }
        }
    case .limited:
        print("選擇少量聯絡人")
        completion(2)  // 限制授權
    @unknown default:
        print("未知的授權狀態")
        completion(-3)  // 未知錯誤
    }
}
    
private func requestContactAccess(completion: @escaping (Bool) -> Void) {
        CNContactStore().requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

