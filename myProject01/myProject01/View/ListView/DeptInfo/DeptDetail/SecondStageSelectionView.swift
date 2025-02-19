//
//  SecondStageSelectionView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct SecondStageSelectionView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    // --------------- //
    
    var department: deptListModel
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Image(systemName: "magnifyingglass")
                Text("第二階段甄選")
                Spacer()
            }
            .bold()
            .padding(.bottom, 10)
            
            if (!department.practicalExamScoreRatio.isEmpty){
                HStack{
                    Text("術科成績採計")
                        .bold()
                    Spacer()
                    Text("\(department.practicalExamScoreRatio)%")
                        .bold()
                }
                .padding(.bottom, 5)
            }
            
            HStack{
                Text("學測成績採計")
                    .bold()
                Spacer()
                Text("\(department.selectionScoreRatio)%")
                    .bold()
            }
            .padding(.bottom, 5)
            
            
            if (department.selectionScoreRatio != "0") {
                
                let multiplierSubject: [String] = deptListFunc.sortSubjectsNames(CH: department.chineseScoreCalculation, EN: department.englishScoreCalculation, MA: department.mathAScoreCalculation, MB: department.mathBScoreCalculation, SC: department.scienceScoreCalculation, SO: department.socialScoreCalculation, multiple: "--", PC: "--", PP: "--")
            
                
                let multiplierScore: [Double] = deptListFunc.sortSubjectsScores(CH: department.chineseScoreCalculation, EN: department.englishScoreCalculation, MA: department.mathAScoreCalculation, MB: department.mathBScoreCalculation, SC: department.scienceScoreCalculation, SO: department.socialScoreCalculation, multiple: "--", PC: "--", PP: "--")
                
                ForEach(0..<multiplierSubject.count, id: \.self){ index in
                    HStack{
                        Text(multiplierSubject[index] == "組合科目" ? department.customSubjectCombination : multiplierSubject[index])
                            .padding(.leading)
                        Spacer()
                        Text("\(String(format: "*%.2f", multiplierScore[index]))")
                    }
                }
                
            }
            
            if (Int(department.designatedItem1ScoreRatio) ?? 0) > 0 {
                HStack{
                    Text(department.designatedItem1)
                        .bold()
                    Spacer()
                    Text( department.designatedItem1Test == "0"  ? "" : "(\(department.designatedItem1Test)↑)")
                        .foregroundColor(Color(.systemGray2))
                    Text("\(department.designatedItem1ScoreRatio)%")
                        .bold()
                }
                .padding(.vertical, 5)
            }
            
            if (Int(department.designatedItem2ScoreRatio) ?? 0) > 0 {
                HStack{
                    Text(department.designatedItem2)
                        .bold()
                    Spacer()
                    Text( department.designatedItem2Test == "0"  ? "" : "(\(department.designatedItem2Test)↑)")
                        .foregroundColor(Color(.systemGray2))
                    Text("\(department.designatedItem2ScoreRatio)%")
                        .bold()
                }
                .padding(.bottom, 5)
            }
            
            if (Int(department.designatedItem3ScoreRatio) ?? 0) > 0 {
                HStack{
                    Text(department.designatedItem3)
                        .bold()
                    Spacer()
                    Text( department.designatedItem3Test == "0"  ? "" : "(\(department.designatedItem3Test)↑)")
                        .foregroundColor(Color(.systemGray2))
                    Text("\(department.designatedItem3ScoreRatio)%")
                        .bold()
                }
                .padding(.bottom, 5)
            }
            
            if (Int(department.designatedItem4ScoreRatio) ?? 0) > 0 {
                HStack{
                    Text(department.designatedItem4)
                        .bold()
                    Spacer()
                    Text( department.designatedItem4Test == "0"  ? "" : "(\(department.designatedItem4Test)↑)")
                        .foregroundColor(Color(.systemGray2))
                    Text("\(department.designatedItem4ScoreRatio)%")
                        .bold()
                }
                .padding(.bottom, 5)
            }
            
            if (Int(department.designatedItem5ScoreRatio) ?? 0) > 0 {
                HStack{
                    Text(department.designatedItem5)
                        .bold()
                    Spacer()
                    Text( department.designatedItem5Test == "0"  ? "" : "(\(department.designatedItem5Test)↑)")
                        .foregroundColor(Color(.systemGray2))
                    Text("\(department.designatedItem5ScoreRatio)%")
                        .bold()
                }
                .padding(.bottom, 5)
            }
            
            if (Int(department.designatedItem6ScoreRatio) ?? 0) > 0 {
                HStack{
                    Text(department.designatedItem6)
                        .bold()
                    Spacer()
                    Text( department.designatedItem6Test == "0"  ? "" : "(\(department.designatedItem6Test)↑)")
                        .foregroundColor(Color(.systemGray2))
                    Text("\(department.designatedItem6ScoreRatio)%")
                        .bold()
                }
                .padding(.bottom, 5)
            }
            
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
        
    }
    
}
