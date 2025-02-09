//
//  SheetExplansionView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//

import SwiftUI

struct SheetExplansionView: View {
    
    @Binding var explansion: String?
    @State private var contentHeight: CGFloat = 100
    
    var body: some View {

        VStack{
            
            HStack{
                Label("說明", systemImage: "questionmark.circle.fill")
                    .foregroundColor(.accentColor)
                    .bold()
                    .font(.title3)
                Spacer()
                Text("下滑以關閉")
                    .opacity(0.4)
            }
            .padding(.bottom,10)
            
            Text(explansion ?? "尚未設置")
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear(){
                                contentHeight = geometry.size.height + 100
                            }
                        }
                    )
            
            Spacer()
        }
        .padding()
        .presentationDetents([.height(contentHeight)])
    }
}
