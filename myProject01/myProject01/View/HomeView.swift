//
//  HomeView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/7.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var data: Data
    
    @State private var EditingGradeCH = ""
    @State private var EditingGradeMA = ""
    @State private var EditingGradeMB = ""
    @State private var EditingGradeSC = ""
    @State private var EditingGradeSO = ""
    @State private var EditingGradeEN = ""
    @State private var EditingGradeEL = "0"
    
    @FocusState private var focusField: Field?
    
    @State private var isFinishedForm = false
    @State private var showOtherSubjectView = false
    
    @State private var contentHeight: CGFloat = 0
    
    @Binding var selectedTab: Int
    
    enum Field: Hashable {
        case gradeCH, gradeEN, gradeMA, gradeMB, gradeSC, gradeSO
    }
    
    func isValidGrade(_ grade: String) -> Bool {
        if let gradeValue = Int(grade), gradeValue >= 0, gradeValue <= 15 {
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
                                Text("A 級").tag("1")
                                Text("B 級").tag("2")
                                Text("C 級").tag("3")
                                Text("F 級 / 未報考").tag("4")
                            } label : {
                                Text("英文聽力選擇")
                            }
                            .background(Color.clear)
                            .onAppear {
                                EditingGradeEL = String(data.gradeEL)
                            }
                            
                            
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
                Spacer()
                
                HStack{
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                    Text("成績輸入完成")
                        .foregroundColor(.green)
                    
                    Spacer()
                }
                .padding(.bottom,10)
                
                Text("成績已輸入完成，資料已經更新。快到「分析」結果頁查看結果！")
                    .font(.caption)
                    .opacity(0.5)
                    .padding(.bottom,10)
            }
            
            Button(role: .none) {
                
                if isFinishedForm {
                    selectedTab = 1
                } else {
                    hideKeyboard()
                    data.gradeCH = Int(EditingGradeCH) ?? 0
                    data.gradeEN = Int(EditingGradeEN) ?? 0
                    data.gradeMA = Int(EditingGradeMA) ?? 0
                    data.gradeMB = Int(EditingGradeMB) ?? 0
                    data.gradeSC = Int(EditingGradeSC) ?? 0
                    data.gradeSO = Int(EditingGradeSO) ?? 0
                    data.gradeEL = Int(EditingGradeEL) ?? 0
                    data.updateTotal()
                    isFinishedForm = true
                }
                
            } label : {
                Spacer()
                
                Text(isFinishedForm ? "查看分析結果" : "提交")
                
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
                !isValidGrade(EditingGradeEL)
            )
            .padding()
            
        }
        .padding()
        .sheet(isPresented: $showOtherSubjectView){
            OtherSubjectChooseView(show: $showOtherSubjectView)
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
                    .onAppear {
                        switch field {
                            case .gradeCH:
                                grade.wrappedValue = String(data.gradeCH)
                            case .gradeEN:
                                grade.wrappedValue = String(data.gradeEN)
                            case .gradeMA:
                                grade.wrappedValue = String(data.gradeMA)
                            case .gradeMB:
                                grade.wrappedValue = String(data.gradeMB)
                            case .gradeSC:
                                grade.wrappedValue = String(data.gradeSC)
                            case .gradeSO:
                                grade.wrappedValue = String(data.gradeSO)
                        }
                        
                        if ( (data.gradeCH  + data.gradeEN + data.gradeMA + data.gradeMB + data.gradeSC + data.gradeSO + data.gradeEL) == 0 ) {
                            grade.wrappedValue = ""
                        }
                        
                    }
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

#Preview {
    HomeView(selectedTab: .constant(0))
        .environmentObject(Data())
}

