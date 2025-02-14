//
//  SV01_AdminCanSet.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct SV01_AdminCanSet : View {
    var body: some View {
        
        HStack{
            Image(systemName: "wrench.and.screwdriver.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .padding(.trailing, 5)
            VStack{
                HStack{
                    Text("管理員操作")
                        .font(.title3)
                    Spacer()
                }
                HStack{
                   Text("調整使用者的獎勵積分")
                        .foregroundColor(Color(.systemGray2))
                        .font(.caption)
                    Spacer()
                }
            }
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.systemGray))
                .padding(.trailing, 5)
        }
        .padding()
        .background(Color(.red).opacity(0.1))
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(10)
        
    }
}

#Preview {
    SV01_AdminCanSet()
}
