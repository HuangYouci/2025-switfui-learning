//
//  ContentView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var lv: [String] = ["0", "0", "0", "0", "0", "0"]
    
    @State private var lvInt: [Int] = [0,0,0,0,0,0]
    
    @State private var totalLv: [Int] = [0,0,0,0,0]

    
    var body: some View {
        VStack(alignment: .leading){
            Text("歡迎")
                .font(.largeTitle)
                .bold()
            
            Text("請輸入你的學測級分資訊")
                .font(.title)
                .padding(.bottom, 20)
            
            HStack{
                VStack{
                    Text("國文")
                    TextField("級分", text: $lv[0])
                        .keyboardType(.numberPad)
                }
                VStack{
                    Text("英文")
                    TextField("級分", text: $lv[1])
                        .keyboardType(.numberPad)
                    
                }
                VStack{
                    Text("數Ａ")
                    TextField("級分", text: $lv[2])
                        .keyboardType(.numberPad)
                }
                VStack{
                    Text("數Ｂ")
                    TextField("級分", text: $lv[3])
                        .keyboardType(.numberPad)
                }
                VStack{
                    Text("自然")
                    TextField("級分", text: $lv[4])
                        .keyboardType(.numberPad)
                }
                VStack{
                    Text("社會")
                    TextField("級分", text: $lv[5])
                        .keyboardType(.numberPad)
                }
            }
            
            Button("提交") {
                
                for i in 0...5 {
                    lvInt[i] = Int(lv[i]) ?? 0
                }
                
                totalLv[0] = 0
                for i in 0...5 {
                    totalLv[0] += lvInt[i]
                }
                totalLv[1] = totalLv[0] - lvInt[3] - lvInt[5]
                totalLv[2] = totalLv[0] - lvInt[3] - lvInt[4]
                totalLv[3] = totalLv[0] - lvInt[2] - lvInt[4]
                
            }
            .padding(.top, 20)
            .buttonStyle(.borderedProminent)
            
            if (totalLv[0] > 0) {
                VStack(alignment: .leading){
                    Text("總級分為 \(totalLv[0])")
                        .font(.subheadline)
                    Text("自然組總級分 \(totalLv[1])")
                        .font(.subheadline)
                    Text("社會組(商管財)總級分為 \(totalLv[2])")
                        .font(.subheadline)
                    Text("社會組(文史哲)總級分為 \(totalLv[3])")
                        .font(.subheadline)
                }
            }
            
            
        }
        .padding()
        .animation(.easeInOut(duration: 1), value: totalLv[0])
        
        
        
    }
}

#Preview {
    ContentView()
}
