//
//  FoodListView.swift
//  course01
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI
struct FoodListView: View {
    
    @Environment(\.editMode) var editMode
    @State private var food = Food.examples
    @State private var selectedFood = Set<Food.ID>()
    
    @State private var tappedFood: Food?
    @State private var foodDetailHeight: CGFloat = FoodDetailSheetHeightKey.defaultValue
    
    @State private var shouldShowForm = false
    
    var isEditing: Bool { editMode?.wrappedValue == .active }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Label("食物清單", systemImage: "fork.knife")
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                EditButton()
                    .buttonStyle(.bordered)
                    .padding(.trailing)
            }
            
            List($food, editActions: .all, selection: $selectedFood) { $food in
                HStack {
                    Text(food.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isEditing { return }
                            tappedFood = food
                        }
                    if isEditing {
                        Image(systemName: "pencil")
                            .font(.title2.bold())
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .listStyle(.plain)
            .padding(.horizontal)
            
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom, alignment: isEditing ? .center : .trailing) {
            if isEditing {
                
                Button {
                    withAnimation{
                        food = food.filter { !selectedFood.contains($0.id) }
                    }
                } label: {
                    Text("刪除選取")
                        .buttonStyle(.borderedProminent)
                }
            } else {
                
                Button {
                    shouldShowForm = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .padding()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, Color.accentColor.gradient)
                }
            }
        }
        .sheet(isPresented: $shouldShowForm) {
            FoodForm(food: Food(name: "", image: ""))
        }
        .sheet(item: $tappedFood){ food in
            VStack{
                Text(food.image)
                    .font(.system(size:100))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Grid(horizontalSpacing: 30, verticalSpacing: 12){
                    buildNutritionView(title: "熱量", value: food.calorie)
                    buildNutritionView(title: "蛋白質", value: food.protein)
                    buildNutritionView(title: "脂肪", value: food.fat)
                    buildNutritionView(title: "碳水", value: food.carb)
                }
            }
            .padding()
            .background {
                GeometryReader { proxy in
                    Color.clear.preference(key: FoodDetailSheetHeightKey.self, value: proxy.size.height)
                }
            }
            .onPreferenceChange(FoodDetailSheetHeightKey.self) {
                foodDetailHeight = $0
            }
            .presentationDetents([.height(foodDetailHeight)])
        }
        
    }
    
    func buildNutritionView(title: String, value: Double) -> some View {
        HStack{
            Text("\(title)")
            Text("\(Int(value)) g")
        }
    }
    
}

private extension FoodListView {
    struct FoodDetailSheetHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat){
            value = nextValue()
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
