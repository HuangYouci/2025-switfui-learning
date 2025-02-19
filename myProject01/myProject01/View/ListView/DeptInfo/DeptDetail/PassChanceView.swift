//
//  PassChanceView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct PassChanceView: View {
    
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
            }
            .bold()
            .padding(.bottom, 10)
            
            HStack{
                Spacer()
                if calPassChancePercent >= 80 {
                    VStack{
                        Text("保底志願")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        Text("\(Image(systemName: "star.fill")) \(Image(systemName: "star.fill")) \(Image(systemName: "star.fill")) \(Image(systemName: "star.fill")) \(Image(systemName: "star.fill"))")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
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
                    .shadow(radius: 5)
                } else if calPassChancePercent >= 60 {
                    VStack{
                        Text("安全志願")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        Text("\(Image(systemName: "star.fill")) \(Image(systemName: "star.fill")) \(Image(systemName: "star.fill")) \(Image(systemName: "star.fill"))")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
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
                    .shadow(radius: 5)
                } else if calPassChancePercent >= 40 {
                    VStack{
                        Text("一般志願")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        Text("\(Image(systemName: "star.fill")) \(Image(systemName: "star.fill")) \(Image(systemName: "star.fill"))")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
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
                    .shadow(radius: 5)
                } else if calPassChancePercent >= 20 {
                    VStack{
                        Text("進攻志願")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        Text("\(Image(systemName: "star.fill")) \(Image(systemName: "star.fill"))")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
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
                    .shadow(radius: 5)
                } else if calPassChancePercent > 0 {
                    VStack{
                        Text("夢幻志願")
                            .font(.title)
                            .foregroundColor(.black)
                            .bold()
                        Text("\(Image(systemName: "star.fill"))")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
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
                    .shadow(radius: 5)
                } else {
                    VStack{
                        Text("無資料")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
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
                    .shadow(radius: 5)
                }
                Spacer()
            }
            .padding(.bottom)
            
            /*
            HStack {
                Text("系統計算原始數據")
                Spacer()
                Text(String(calPassChancePercent))
            }
             */
            
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
        
    }
    
}
