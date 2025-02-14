//
//  AutoLogin.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct AutoLogin: View {
    var body: some View {
        VStack{
            Image(systemName: "person.fill.checkmark")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding()
            Text("自動登入中...")
                .font(.title2)
        }
        .padding()
        .background(
            BlurView(style: .systemThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        )
    }
}

#Preview {
    AutoLogin()
}
