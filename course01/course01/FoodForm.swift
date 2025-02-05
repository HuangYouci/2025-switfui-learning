//
//  FoodForm.swift
//  course01
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

extension FoodListView {
    struct FoodForm: View {
        
        @State var food: Food
        
        private var isNotValid: Bool {
            food.name.isEmpty || food.image.count > 2
        }
        
        private var notValidReason: String? {
            if food.name.isEmpty { return "食物名稱不得為空" }
            if food.image.count > 2 { return "食物圖示不得大於 2 字元" }
            return .none
        }
        
        var body: some View {
            VStack {
                Label("編輯食物資訊", systemImage: "pencil")
                    .font(.title.bold())
                    .foregroundStyle(.accent)
                Form {
                    LabeledContent("名稱"){
                        TextField("必填", text: $food.name)
                            .submitLabel(.next)
                    }
                    LabeledContent("圖示"){
                        TextField("最多輸入 2 個 Emoji", text: $food.image)
                            .submitLabel(.next)
                    }
                    
                    buildNumberField("熱量", $food.calorie, "大卡")
                    buildNumberField("蛋白質", $food.protein)
                    buildNumberField("脂肪", $food.fat)
                    buildNumberField("碳水", $food.carb)
                
                }.padding([.top])
                
                Button {
                    
                } label: {
                    Text(notValidReason ?? "儲存")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .mainButtonStyle()
                .padding()
                .disabled(isNotValid)
                
            }
            .background(Color(.systemGroupedBackground))
            .multilineTextAlignment(.trailing)
            .font(.title3)
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Text("Hi")
                }
                
            }
        }
        
        private func buildNumberField(_ title: String, _ value: Binding<Double>, _ suffix: String = "g") -> some View {
            LabeledContent(title){
                HStack{
                    TextField("", value: value, format: .number.precision(.fractionLength(1)))
                        .keyboardType(.decimalPad)
                    Text(suffix)
                }
            }
        }
        
        
    }
    
    
}

struct FoodForm_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView.FoodForm(food: Food.examples.first!)
    }
}
