//
//  FirstStageFilterView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct FirstStageFilterView: View {
    
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
                Image(systemName: "line.3.horizontal.decrease")
                Text("第一階段篩選")
                Spacer()
            }
            .bold()
            .padding(.bottom, 10)
            
            let multiplierSubject: [String] = deptListFunc.sortSubjectsNames(CH: department.chineseMultiplier, EN: department.englishMultiplier, MA: department.mathAMultiplier, MB: department.mathBMultiplier, SC: department.scienceMultiplier, SO: department.socialMultiplier, multiple: department.customSubjectCombinationMultiplier, PC: department.programmingConceptTestMultiplier, PP: department.programmingPracticalTestMultiplier)
            
            let multiplierScore: [Double] = deptListFunc.sortSubjectsScores(CH: department.chineseMultiplier, EN: department.englishMultiplier, MA: department.mathAMultiplier, MB: department.mathBMultiplier, SC: department.scienceMultiplier, SO: department.socialMultiplier, multiple: department.customSubjectCombinationMultiplier, PC: department.programmingConceptTestMultiplier, PP: department.programmingPracticalTestMultiplier)
            
            HStack{
                Text("科目")
                    .bold()
                Spacer()
                Text("倍率")
                    .bold()
            }
            .padding(.bottom, 5)
            
            ForEach(0..<multiplierSubject.count, id: \.self){ index in
                HStack{
                    Text(multiplierSubject[index] == "組合科目" ? department.customSubjectCombination : multiplierSubject[index])
                    Spacer()
                    Text("\(String(format: "%.1f", multiplierScore[index]))")
                }
            }
            
            HStack{
                Text("超額篩選")
                    .bold()
                Spacer()
            }
            .padding(.vertical, 5)
            
            if (!department.sameLevelScoreExcessSelectionOrder1.isEmpty) {
                HStack{
                    Text("1")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    ScrollView(.horizontal){
                        Text(department.sameLevelScoreExcessSelectionOrder1)
                    }
                    Spacer()
                }
            }
            
            if (!department.sameLevelScoreExcessSelectionOrder2.isEmpty) {
                HStack{
                    Text("2")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    ScrollView(.horizontal){
                        Text(department.sameLevelScoreExcessSelectionOrder2)
                    }
                    Spacer()
                }
            }
            
            if (!department.sameLevelScoreExcessSelectionOrder3.isEmpty) {
                HStack{
                    Text("3")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    ScrollView(.horizontal){
                        Text(department.sameLevelScoreExcessSelectionOrder3)
                    }
                    Spacer()
                }
            }
            
            if (!department.sameLevelScoreExcessSelectionOrder4.isEmpty) {
                HStack{
                    Text("4")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    ScrollView(.horizontal){
                        Text(department.sameLevelScoreExcessSelectionOrder4)
                    }
                    Spacer()
                }
            }
            
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
    }
}
