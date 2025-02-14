//
//  HistoryView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI
import FirebaseFirestore

struct HistoryView: View {
    
    // 本 VIEW 新增環境變數
    @StateObject private var pointsHistoryViewModel = PointsHistoryViewModel()
    // 繼承環境變數
    // 本 VIEW 綁定變數

    let uid: String
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                HStack{
                    Text("積分變更歷史")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()
                
            }
                
            
            ScrollView {
                HStack{
                    Spacer()
                }
                
                if let errorMessage = pointsHistoryViewModel.errorMessage {
                    Text(errorMessage)
                } else if pointsHistoryViewModel.isLoading {
                    ProgressingView()
                } else {
                    ForEach(pointsHistoryViewModel.pointsHistory) { history in
                        HistoryRowView(pointHistory: history)
                    }
                }
                
                if pointsHistoryViewModel.pointsHistory.count == 0 {
                    Text("目前還沒有紀錄")
                        .padding(.top, 5)
                        .foregroundColor(Color(.systemGray2))
                } else {
                    Text("已經到底了")
                        .padding(.top, 5)
                        .foregroundColor(Color(.systemGray2))
                }
                
            }
            .padding()
            .background(
                BlurView(style: .systemThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .edgesIgnoringSafeArea(.all)
            
        }
        .background(Image("bgLogin").opacity(0.3))
        .onAppear {
            pointsHistoryViewModel.fetchPointsHistory(userId: uid)
                }
        
    }
    
}
