//
//  ContentView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/1/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var score: Int = 20
    @State private var historyScore: [Int] = [20]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("歡迎使用獎勵積分系統")
                .font(.title)
            
            TimelineView(.periodic(from: .now, by: 1)) { context in
                        Text(dateFormatter.string(from: context.date))
                    }
            .padding(.bottom, 20)
            
            Text("目前餘額")
            HStack (alignment: .bottom){
                Text("\(score)")
                    .font(.largeTitle)
                    .bold()
                Text("分")
            }
            
            Spacer()
            
            VStack (alignment: .leading){
                Text("歷史紀錄")
                    .bold()
                
                
                ScrollView{
                    Text("\(historyScore.map(\.description).joined(separator: "\n"))")
                }
                .frame(minWidth: 30, maxHeight: 100, alignment: .leading)
                
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            
            Button{
                let addScore: Int = Int.random(in: 0...100)
                score += addScore
                historyScore.append(addScore)
            } label: {
                Text("要求積分")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .animation(.easeIn, value: score)
    }
}

#Preview {
    ContentView()
}
