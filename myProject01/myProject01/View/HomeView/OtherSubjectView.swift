//
//  OtherSubjectView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/9.
//

import SwiftUI

struct OtherSubjectChooseView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    @FocusState private var focusField: Field?
    // Binding
    @Binding var EditingGradePC: Int
    @Binding var EditingGradePP: Int
    @Binding var EditingGradeSK1: String
    @Binding var EditingGradeSK2: String
    @Binding var EditingGradeSK3: String
    @Binding var EditingGradeSK4: String
    @Binding var EditingGradeSK5: String
    @Binding var EditingGradeSKT: Int
    @Binding var showOtherSubjectView: Bool
    // State
    // --------------- //
    
    var labels: [String] {
            switch EditingGradeSKT {
            case 1: // 美術
                return ["素描", "彩繪技法", "創意表現", "水墨書畫", "美術鑒賞"]
            case 3: // 音樂
                return ["主修", "副修", "樂理", "視唱", "聽寫"]
            default:
                return ["先選類別", "先選類別", "先選類別", "先選類別", "先選類別"]
            }
        }
    
    enum Field: Hashable {
        case gradeSK1, gradeSK2, gradeSK3, gradeSK4, gradeSK5
    }
    
    func isValidGrade(_ grade: String) -> Bool {
        if let gradeValue = Int(grade), gradeValue >= 0, gradeValue <= 100 {
            return true
        }
        return false
    }
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text("其他科目")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom)
            
            HStack{
                Text("程式設計（APCS）")
                    .font(.title2)
                Spacer()
            }
            
            HStack{
                Text("術科目前僅支援成績輸入與檢定，尚未支援篩選計算")
                    .font(.caption)
                Spacer()
            }
            .padding(.vertical, 10)
            
            HStack {
                
                HStack {
                    
                    Text("觀念")
                        .foregroundStyle(Color.accentColor)
                    
                    Spacer()
                    
                    Picker(selection: $EditingGradePC){
                        Section("0 級分或未報考請選「0 級」"){
                            Text("0 級").tag(0)
                        }
                        Text("1 級").tag(1)
                        Text("2 級").tag(2)
                        Text("3 級").tag(3)
                        Text("4 級").tag(4)
                        Text("5 級").tag(5)
                    } label : {
                        Text("選擇器")
                    }
                    .padding(.horizontal, -10)
                    .background(Color.clear)
                    
                }
                .pickerStyle(MenuPickerStyle())
                .padding(5)
                .padding(.horizontal, 5)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                
                HStack {
                    
                    Text("實作")
                        .foregroundStyle(Color.accentColor)
                    
                    Spacer()
                    
                    Picker(selection: $EditingGradePP){
                        Section("0 級分或未報考請選「0 級」"){
                            Text("0 級").tag(0)
                        }
                        Text("1 級").tag(1)
                        Text("2 級").tag(2)
                        Text("3 級").tag(3)
                        Text("4 級").tag(4)
                        Text("5 級").tag(5)
                    } label : {
                        Text("選擇器")
                    }
                    .padding(.horizontal, -10)
                    .background(Color.clear)
                    
                }
                .pickerStyle(MenuPickerStyle())
                .padding(5)
                .padding(.horizontal, 5)
                .background(Color(.quaternarySystemFill))
                .cornerRadius(10)
                
            }
            
            /// 群組內的是術科的選擇器
            
            Group {
                
                HStack{
                    Text("術科")
                        .font(.title2)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                HStack{
                    Text("術科目前僅支援成績輸入，尚未支援檢定與篩選計算")
                        .font(.caption)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Picker(selection: $EditingGradeSKT){
                    Text("美術").tag(1)
                    Text("體育").tag(2)
                    Text("音樂").tag(3)
                } label : {
                    Text("選擇器")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                
                Group {
                    
                    if EditingGradeSKT != 2 {
                        
                        gradeInputView(label: labels[0], grade: $EditingGradeSK1, field: .gradeSK1)
                        
                        gradeInputView(label: labels[1], grade: $EditingGradeSK2, field: .gradeSK2)
                        
                        gradeInputView(label: labels[2], grade: $EditingGradeSK3, field: .gradeSK3)
                        
                        gradeInputView(label: labels[3], grade: $EditingGradeSK4, field: .gradeSK4)
                        
                        gradeInputView(label: labels[4], grade: $EditingGradeSK5, field: .gradeSK5)
                        
                    }
                    
                }
                .disabled(EditingGradeSKT == 0)
                
                if EditingGradeSKT == 2 {
                    
                    HStack {
                        Text("體育")
                            .foregroundColor(.accentColor)
                        TextField("0 至 100", text: $EditingGradeSK1)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("分")
                            .foregroundColor(Color(.systemGray2))
                    }
                    .padding(10)
                    .background(Color(.quaternarySystemFill))
                    .cornerRadius(10)
                    
                }
                
                Button(role: .none) {
                    
                    hideKeyboard()
                    
                    showOtherSubjectView = false
                    
                } label : {
                    Spacer()
                    
                    Text("關閉此頁")
                    
                    Spacer()
                }
                .clipShape(Capsule())
                .buttonStyle(.borderedProminent)
                .padding()
                
            }
            
            Spacer()
            
        }
        .padding()
        
    }

    private func gradeInputView(label: String, grade: Binding<String>, field: Field) -> some View {
            return HStack {
                Text(label)
                    .foregroundColor(.accentColor)
                TextField("0 至 100", text: grade)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($focusField, equals: field)
                    .onSubmit {
                        switch field {
                        case .gradeSK1:
                            focusField = .gradeSK2
                        case .gradeSK2:
                            focusField = .gradeSK3
                        case .gradeSK3:
                            focusField = .gradeSK4
                        case .gradeSK4:
                            focusField = .gradeSK5
                        case .gradeSK5:
                            focusField = nil
                        }
                    }
                Text("分")
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(10)
            .background(Color(.quaternarySystemFill))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isValidGrade(grade.wrappedValue) ? Color.clear : Color.red, lineWidth: 1)
                    .opacity(isValidGrade(grade.wrappedValue) ? 0 : 1)
                    .animation(isValidGrade(grade.wrappedValue) ? nil : Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: grade.wrappedValue)
            )
        }
}
