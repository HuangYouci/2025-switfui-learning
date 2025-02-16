//
//  TestView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct TestView: View {
    
    @State var EditingTF1: String = ""
    @State var EditingTF2: String = ""
    
    var body: some View {
        
        VStack{
            
            VStack{
                HStack{
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(5)
                        .background(Color(.systemGray).opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray).opacity(0.2), lineWidth: 1)
                        )
                    VStack(alignment: .leading){
                        Text("15分鐘兌換券")
                        Text("可用於兌換15分鐘獎勵時間")
                            .foregroundColor(Color(.systemGray2))
                            .font(.caption)
                    }
                    Spacer()
                    VStack{
                        Text("shopData.t1s")
                            .bold()
                        
                        Text("原價 shopData.t1o")
                            .font(.caption)
                    }
                }
                Divider()
                    .padding(.vertical, 5)
                HStack{
                    Text("原價")
                    TextField("正整數", text: $EditingTF1)
                        .keyboardType(.numberPad)
                        .onAppear{
                            // 抓取
                        }
                    Spacer()
                }
                HStack{
                    Text("售價")
                    TextField("正整數", text: $EditingTF2)
                        .keyboardType(.numberPad)
                        .onAppear{
                            // 抓取
                        }
                }
                HStack{
                    Spacer()
                    Button(role: .none){
                        //
                    } label: {
                        Text("變更")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .background(Color(.systemGroupedBackground).opacity(0.3))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray3), lineWidth: 1)
            )
            
        }
        
    }
    
}

#Preview {
    TestView()
}
