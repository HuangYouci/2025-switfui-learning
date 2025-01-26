//
//  ContentView.swift
//  course01
//
//  Created by 黃宥琦 on 2025/1/25.
//

import SwiftUI

struct ContentView: View {
    
    let food = Food.examples
    
    @State private var selectedFood: Food?
    @State private var showInfo: Bool = false
    
    var body: some View {
        VStack (spacing: 30) {
            
            if selectedFood != .none {
                
                Text(selectedFood!.image)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                    
            } else {
                
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
            }
                
            Text("今天吃什麼？")
                .font(.title)
                .bold()
            
            if selectedFood != .none {
                
                HStack{
                    
                    Text(selectedFood!.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.green)
                        .transition(.scale)
                    
                    Button(role: .none){
                        showInfo = true
                    } label: {
                        Text("營養資訊")
                    }
                        .buttonStyle(.bordered)
                    
                }
                
                if showInfo {
                    Text("熱量 \(Int(selectedFood!.calorie.rounded())) 大卡")
                        .font(.title)
                    
                    HStack{
                        Group{
                            VStack{
                                Text("蛋白質")
                                Divider()
                                Text("\(Int(selectedFood!.protein.rounded())) g")
                            }
                            VStack{
                                Text("脂肪")
                                Divider()
                                Text("\(Int(selectedFood!.fat.rounded())) g")
                            }
                            VStack{
                                Text("碳水")
                                Divider()
                                Text("\(Int(selectedFood!.carb.rounded())) g")
                            }
                        }
                        .padding([.leading, .trailing], 5)
                    }
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(10)
                }
                
            }
            
            // Color.clear
            Spacer()
            
            Button(role: .none){
                selectedFood = food.shuffled().first
                showInfo = false
            } label: {
                Text( selectedFood == nil ? "告訴我" : "換一個" )
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    ContentView()
}
