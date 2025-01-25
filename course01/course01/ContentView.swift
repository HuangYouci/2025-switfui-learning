//
//  ContentView.swift
//  course01
//
//  Created by 黃宥琦 on 2025/1/25.
//

import SwiftUI

struct ContentView: View {
    
    let food = ["漢堡", "沙拉", "披薩", "義大利麵", "雞腿便當", "刀削麵", "火鍋", "牛肉麵", "關東煮"]
    
    @State private var selectedFood: String?
    
    var body: some View {
        VStack (spacing: 30) {
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                
            Text("今天吃什麼？")
                .font(.title)
                .bold()
            
            if (selectedFood != ""){
                
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.green)
                    .transition(.scale)
                
            }
            
            Button(role: .none){
                selectedFood = food.shuffled().first
            } label: {
                Text( selectedFood == .none ? "告訴我" : "換一個" )
                    .frame(width: 200, alignment: .center)
            }
                .font(.title)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.bottom, -15)
                .animation(.none, value: selectedFood)
            
            Button("取消") {
                selectedFood = .none
            }
                .font(.title)
                .buttonStyle(.bordered)
            
            
        }
        .padding()
        .animation(.easeInOut, value: selectedFood)
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    ContentView()
}
