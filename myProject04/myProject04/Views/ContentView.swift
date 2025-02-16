//
//  ContentView.swift
//  myProject04
//
//  Created by 黃宥琦 on 2025/2/15.
//

import SwiftUI
import Contacts

struct ContentView: View {
    
    // --------------------- //
    // StateObject
    // EnvironmentObject
    @EnvironmentObject var contactData: ContactManager
    // Binding
    // State
    // --------------------- //
    
    var body: some View {
        VStack {
            List(contactData.contacts, id: \.identifier) { contact in
                VStack(alignment: .leading) {
                    Text("\(contact.givenName) \(contact.familyName)") // 顯示名和姓
                        .font(.headline)
                    // 你也可以顯示其他資訊，例如電話、電子郵件等
                    if !contact.phoneNumbers.isEmpty {
                        Text(contact.phoneNumbers.first?.value.stringValue ?? "無電話")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .onAppear {
            contactData.fetchContacts()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
