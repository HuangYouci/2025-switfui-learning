//
//  ContactRowView.swift
//  myProject04
//
//  Created by 黃宥琦 on 2025/2/15.
//

import SwiftUI
import Contacts

struct ContactRowView: View {
    
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
                    Text("\(contact.givenName) \(contact.familyName)")
                        .font(.headline)
                    
                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                        Text("📞 \(phoneNumber)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    if let email = contact.emailAddresses.first?.value as String? {
                        Text("✉️ \(email)")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding()
    }
}


