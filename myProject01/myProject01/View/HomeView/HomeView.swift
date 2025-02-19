//
//  HomeView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/7.
//

import SwiftUI

struct HomeView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    @EnvironmentObject private var data: UserDef
    // Binding
    @Binding var selectedTab: Int
    // State
    @FocusState private var focusField: Field?
    @State private var EditingGradeCH = ""
    @State private var EditingGradeMA = ""
    @State private var EditingGradeMB = ""
    @State private var EditingGradeSC = ""
    @State private var EditingGradeSO = ""
    @State private var EditingGradeEN = ""
    @State private var EditingGradeEL = 4
    @State private var EditingGradePC = 0
    @State private var EditingGradePP = 0
    @State private var EditingGradeSK1 = "0"
    @State private var EditingGradeSK2 = "0"
    @State private var EditingGradeSK3 = "0"
    @State private var EditingGradeSK4 = "0"
    @State private var EditingGradeSK5 = "0"
    @State private var EditingGradeSKT = 0
    @State private var isFinishedForm = false
    @State private var showOtherSubjectView = false
    @State private var contentHeight: CGFloat = 0
    // --------------- //
    
    enum Field: Hashable {
        case gradeCH, gradeEN, gradeMA, gradeMB, gradeSC, gradeSO
    }
    
    func isValidGrade(_ grade: String) -> Bool {
        if let gradeValue = Int(grade), gradeValue >= 0, gradeValue <= 15 {
            return true
        }
        return false
    }
    
    func isValidGradeSK(_ grade: String) -> Bool {
        if let gradeValue = Int(grade), gradeValue >= 0, gradeValue <= 100 {
            return true
        }
        return false
    }
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text("學測個人申請分析系統")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom)
            
            HStack{
                Image(systemName: "square.and.pencil")
                    .opacity(0.5)
                Text("成績輸入")
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.bottom,10)
            
            Text("輸入規則：於國文、英文、數Ａ、數Ｂ、自然、社會，請輸入 0 到 15 的整數（您的成績級分），如果您未報考該科，請輸入 0 級分；於英聽，請選擇 A/B/C/F 級。")
                .font(.caption)
                .opacity(0.5)
                .padding(.bottom,10)
            
            ScrollView {
                
                VStack{
                    
                    HStack{
                        gradeInputView(label: "國文", grade: $EditingGradeCH, field: .gradeCH)
                        gradeInputView(label: "英文", grade: $EditingGradeEN, field: .gradeEN)
                    }
                    HStack{
                        gradeInputView(label: "數Ａ", grade: $EditingGradeMA, field: .gradeMA)
                        gradeInputView(label: "數Ｂ", grade: $EditingGradeMB, field: .gradeMB)
                    }
                    HStack{
                        gradeInputView(label: "自然", grade: $EditingGradeSC, field: .gradeSC)
                        gradeInputView(label: "社會", grade: $EditingGradeSO, field: .gradeSO)
                    }
                    
                    HStack {
                        HStack {
                            
                            Text("英聽")
                                .foregroundStyle(Color.accentColor)
                            
                            Spacer()
                            
                            Picker(selection: $EditingGradeEL){
                                Text("A 級").tag(1)
                                Text("B 級").tag(2)
                                Text("C 級").tag(3)
                                Text("F 級 / 未報考").tag(4)
                            } label : {
                                Text("英文聽力選擇")
                            }
                            .background(Color.clear)
                            
                            
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(5)
                        .padding(.horizontal, 5)
                        .background(Color(.quaternarySystemFill))
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        Button(role: .none){
                            showOtherSubjectView = true
                        } label: {
                            Text("其他科目")
                                .padding(5)
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                    
                }
                
            }
                
            if isFinishedForm {
                
                HStack{
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                    Text("成績輸入完成")
                        .foregroundColor(.green)
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack{
                    Text("成績已輸入完成，資料已經新增。快到「分析」結果頁選擇該筆分析結果，查看詳細分析！")
                        .font(.caption)
                        .opacity(0.5)
                    Spacer()
                }
                
                Button(role: .none) {
                    selectedTab = 1
                } label : {
                    Spacer()
                    
                    Text("查看分析結果")
                    
                    Spacer()
                }
                .padding()
                
            } else {
                
                if data.analyzeCount < 1 {
                    HStack{
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        Text("分析次數不足")
                            .foregroundColor(.red)
                        
                        Spacer()
                    }
                    .padding(.bottom,5)
                    
                    HStack{
                        Text("目前沒有分析次數了，請到「關於」頁面了解如何獲得分析次數")
                            .font(.caption)
                            .opacity(0.5)
                        Spacer()
                    }
                }
                
                Button(role: .none) {
                    
                    hideKeyboard()
                    data.addNewResultData(gradeCH: Int(EditingGradeCH) ?? 0 , gradeEN: Int(EditingGradeEN) ?? 0 , gradeMA: Int(EditingGradeMA) ?? 0 , gradeMB: Int(EditingGradeMB) ?? 0 , gradeSC: Int(EditingGradeSC) ?? 0 , gradeSO: Int(EditingGradeSO) ?? 0 , gradeEL: EditingGradeEL, gradePC: EditingGradePC, gradePP: EditingGradePP, gradeSK1: Int(EditingGradeSK1) ?? 0 , gradeSK2: Int(EditingGradeSK2) ?? 0 , gradeSK3: Int(EditingGradeSK3) ?? 0 , gradeSK4: Int(EditingGradeSK4) ?? 0 , gradeSK5: Int(EditingGradeSK5) ?? 0 , gradeSKT: EditingGradeSKT)
                    isFinishedForm = true
                    data.analyzeCount -= 1
                    
                } label : {
                    Spacer()
                    
                    Text(data.analyzeCount < 1 ? "分析次數不足" : "提交")
                    
                    Spacer()
                }
                .clipShape(Capsule())
                .buttonStyle(.borderedProminent)
                .disabled(
                    !isValidGrade(EditingGradeCH) ||
                    !isValidGrade(EditingGradeMA) ||
                    !isValidGrade(EditingGradeMB) ||
                    !isValidGrade(EditingGradeSC) ||
                    !isValidGrade(EditingGradeSO) ||
                    !isValidGrade(EditingGradeEN) ||
                    !isValidGradeSK(EditingGradeSK1) ||
                    !isValidGradeSK(EditingGradeSK2) ||
                    !isValidGradeSK(EditingGradeSK3) ||
                    !isValidGradeSK(EditingGradeSK4) ||
                    !isValidGradeSK(EditingGradeSK5) || data.analyzeCount < 1
                )
                .padding()
                
            }
            
        }
        .padding()
        .sheet(isPresented: $showOtherSubjectView){
            OtherSubjectChooseView(EditingGradePC: $EditingGradePC, EditingGradePP: $EditingGradePP, EditingGradeSK1: $EditingGradeSK1, EditingGradeSK2: $EditingGradeSK2, EditingGradeSK3: $EditingGradeSK3, EditingGradeSK4: $EditingGradeSK4, EditingGradeSK5: $EditingGradeSK5, EditingGradeSKT: $EditingGradeSKT, showOtherSubjectView: $showOtherSubjectView)
        }
        .onAppear{
            isFinishedForm = false
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                
                Button {
                    
                    switch focusField {
                        case .gradeCH:
                            focusField = .gradeEN
                        case .gradeEN:
                            focusField = .gradeMA
                        case .gradeMA:
                            focusField = .gradeMB
                        case .gradeMB:
                            focusField = .gradeSC
                        case .gradeSC:
                            focusField = .gradeSO
                        case .gradeSO:
                            focusField = nil
                    case .none:
                        focusField = nil
                    }
                    
                } label: {
                    Text("下一格")
                        .foregroundColor(.accentColor)
                    Image(systemName: "arrow.forward")
                }
                
                Button {
                    focusField = nil
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
                
            }
        }
    }
    
    private func gradeInputView(label: String, grade: Binding<String>, field: Field) -> some View {
            return HStack {
                Text(label)
                    .foregroundColor(.accentColor)
                TextField("0 至 15", text: grade)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($focusField, equals: field)
                    .onSubmit {
                        switch field {
                        case .gradeCH:
                            focusField = .gradeEN
                        case .gradeEN:
                            focusField = .gradeMA
                        case .gradeMA:
                            focusField = .gradeMB
                        case .gradeMB:
                            focusField = .gradeSC
                        case .gradeSC:
                            focusField = .gradeSO
                        case .gradeSO:
                            focusField = nil
                        }
                    }
                Text("級")
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

