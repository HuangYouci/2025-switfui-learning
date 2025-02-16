//
//  ContactManager.swift
//  myProject04
//
//  Created by 黃宥琦 on 2025/2/15.
//

import SwiftUI
import Contacts

class ContactManager: ObservableObject {
    
    @Published var contacts: [CNContact] = [] // 存放聯絡人清單
    private let store = CNContactStore() // 聯絡人存取工具

    // 讀取聯絡人資訊
    func fetchContacts() {
        let keys: [CNKeyDescriptor] = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey,
                CNContactIdentifierKey
            ] as [CNKeyDescriptor]
        
        DispatchQueue.global(qos: .userInitiated).async { // 背景執行緒讀取聯絡人
            let request = CNContactFetchRequest(keysToFetch: keys)
            var newContacts: [CNContact] = []
            
            do {
                try self.store.enumerateContacts(with: request) { contact, _ in
                    newContacts.append(contact) // 現在在背景執行緒
                }
            } catch {
                print("讀取聯絡人失敗：\(error)")
            }

            DispatchQueue.main.async { // 回到主執行緒更新 UI
                self.contacts = newContacts
            }
        }
        
    }

}

