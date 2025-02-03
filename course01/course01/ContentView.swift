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
        ScrollView {
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
                    
                    VStack{
                        if showInfo {
                            Text("熱量 \(Int(selectedFood!.calorie.rounded())) 大卡")
                                .font(.title)
                            
                            Grid(verticalSpacing: 12) {
                                GridRow {
                                    Text("蛋白質")
                                    Text("脂肪")
                                    Text("碳水")
                                }.frame(minWidth: 60)
                                
                                Divider()
                                    .gridCellUnsizedAxes(.horizontal)
                                    .padding(.horizontal, -10)
                                
                                GridRow{
                                    Text("\(Int(selectedFood!.protein.rounded())) g")
                                    Text("\(Int(selectedFood!.fat.rounded())) g")
                                    Text("\(Int(selectedFood!.carb.rounded())) g")
                                }
                            }
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipped()
                }
                
                Spacer()
                
                Button(role: .none){
                    selectedFood = food.shuffled().first
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
                    showInfo = false
                }
                .font(.title)
                .buttonStyle(.bordered)
    
                
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
        }
        .background(Color(.secondarySystemBackground))
        .animation(.spring(dampingFraction: 0.55), value: showInfo)
        .animation(.easeInOut, value: selectedFood)
    }
}

//extension ContentView {
//    init(selectedFood: Food){
//        _selectedFood = State(wrappedValue: selectedFood)
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(selectedFood: .examples.first!)
//        ContentView(selectedFood: .examples.first!).previewDevice(PreviewDevice(rawValue: "iPad Pro 13-inch (M4)"))
//        ContentView(selectedFood: .examples.first!).previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//    }
//}

#Preview {
    ContentView()
}
