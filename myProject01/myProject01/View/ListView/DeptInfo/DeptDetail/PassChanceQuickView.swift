//
//  PassChanceQuickView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct PassChanceQuickView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    // --------------- //
    
    var department: deptListModel
    var data: gradeData
    
    var body: some View {
        
        let calPassChance = deptListFunc.calPassChance(testResult: department.testResult, data: data)
        
        let calPassChancePercent = Int(calPassChance * 100)
        
            
        VStack(spacing: 0){
            
            HStack{
                Image(systemName: "medal.star")
                Text("系統計算")
                Spacer()
                
                if calPassChancePercent >= 80 {
                    
                    Text("保底志願")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.95, green: 0.35, blue: 0.27),
                                    Color(red: 0.96, green: 0.46, blue: 0.18)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                    
                } else if calPassChancePercent >= 60 {
                    
                    Text("安全志願")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.51, green: 0.22, blue: 0.89),
                                    Color(red: 0.38, green: 0.36, blue: 0.73)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                    
                } else if calPassChancePercent >= 40 {
                    
                    Text("一般志願")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.04, green: 0.54, blue: 0.64),
                                    Color(red: 0.35, green: 0.70, blue: 0.97)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                    
                } else if calPassChancePercent >= 20 {
                    
                    Text("進攻志願")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.09, green: 0.36, blue: 0.29),
                                    Color(red: 0.14, green: 0.48, blue: 0.30)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                    
                } else if calPassChancePercent > 0 {
                    
                    Text("夢幻志願")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.62, green: 0.50, blue: 0.80),
                                    Color(red: 0.97, green: 0.76, blue: 0.90)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                    
                } else {
                    
                    Text("無資料")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.11, green: 0.11, blue: 0.11),
                                    Color(red: 0.26, green: 0.26, blue: 0.26)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(15)
                    
                }
                    
            }
            .bold()
            
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
            
        
    }
    
}
