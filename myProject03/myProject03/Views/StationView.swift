//
//  StationView.swift
//  myProject03
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI
import CoreData

struct StationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TrainTimetable.trainInfo?.trainNo, ascending: true)],
        animation: .default)
    private var timetables: FetchedResults<TrainTimetable>
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(timetables, id: \.self) { timetable in
                        VStack(alignment: .leading) {
                            Text("列車編號: \(timetable.trainInfo?.trainNo ?? "")")
                                .font(.headline)
                            Text("車種: \(timetable.trainInfo?.trainTypeZhTw ?? "")")
                            Text("起點站: \(timetable.trainInfo?.startingStationZhTw ?? "")")
                            Text("終點站: \(timetable.trainInfo?.endingStationZhTw ?? "")")
                        }
                    }
                }
                .navigationTitle("列車時刻表")
                .toolbar {
                    Button(action: {
                        Task {
                            await updateData()
                        }
                    }) {
                        Text("更新資料")
                    }
                    .disabled(isLoading)
                }
                
                if isLoading {
                    ProgressView("載入中...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
            }
        }
        .alert("錯誤", isPresented: $showError) {
            Button("確定", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .task {
            await updateData()
        }
    }
    
    private func updateData() async {
        isLoading = true
        do {
            try await TrainDataManager.shared.fetchAndStoreTrainData()
            await MainActor.run {
                viewContext.reset() // 重置 context 以確保重新從持久化存儲加載數據
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                showError = true
                isLoading = false
            }
        }
    }
}

#Preview {
    StationView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
