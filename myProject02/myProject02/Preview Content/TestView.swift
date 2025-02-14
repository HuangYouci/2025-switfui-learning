//
//  TestView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct TestView: View {
    
    let itemName: String = "15分鐘時間兌換券"
    let itemPrice: Int = 100
    let itemOrigPrice: Int = 1000
    let balance: Int = 0
    
    var body: some View {
        
        VStack{
            HStack{
                Text("購買確認")
                    .bold()
                    .font(.title)
                Spacer()
            }
            .padding(.bottom, 5)
            HStack{
                Text("確定要購買")
                    .foregroundColor(Color(.systemGray))
                Text(itemName)
                    .foregroundColor(.accentColor)
                    .bold()
                Text("嗎")
                    .foregroundColor(Color(.systemGray))
                Spacer()
            }
            .font(.title3)
            
            Divider()
                .padding(.vertical, 10)
            
            HStack{
                
                if itemOrigPrice != itemPrice {
                    Text(String(itemOrigPrice))
                        .font(.title)
                        .foregroundColor(Color(.systemGray))
                        .strikethrough(true, color: .red)
                    Image(systemName: "arrow.right")
                }
                
                Text(String(itemPrice))
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .bold()
                Text("P")
                    .foregroundColor(.accentColor)
                
                Spacer()
                Button(role: .none){
                    
                } label: {
                    Text("購買")
                        .font(.title2)
                }
                .buttonStyle(.borderedProminent)
                .disabled(balance < itemPrice)
            }
            .padding(.bottom, 10)
        }
        .padding()
        
    }
    
}

#Preview {
    TestView()
}
