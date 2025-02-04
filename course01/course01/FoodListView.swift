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
                Text(food.name)
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
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .padding()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, Color.accentColor.gradient)
                }
            }
        }
//        .sheet(isPresented: .constant(true)){
//            
//        }
//        .presentationDetents([.height(20)])
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
