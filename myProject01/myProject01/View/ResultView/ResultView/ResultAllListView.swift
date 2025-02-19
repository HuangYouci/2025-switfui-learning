//
//  ResultAllListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//


import SwiftUI

struct ResultAllListView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    @State var searchText: String = ""
    @State private var isLoading = true
    // --------------- //
    
    let data: gradeData
    let deptList: [deptListModel]
    
    var filteredDeptList: [deptListModel] {
        if searchText.isEmpty {
            return deptList
        } else {
            return deptList.filter { dept in
                dept.fullName.contains(searchText) || dept.id.contains(searchText) || dept.departmentAbbreviation.contains(searchText)
            }
        }
    }
    
    
    var body: some View {
        
        let sortedDeptList = filteredDeptList.sorted {
            deptListFunc.calPassChance(testResult: $0.testResult, data: data) >
            deptListFunc.calPassChance(testResult: $1.testResult, data: data)
        }
        
        VStack {
            
            HStack{
                Image(systemName: "list.dash")
                    .opacity(0.5)
                
                if searchText.isEmpty {
                    Text("校系資料" + " (通過檢定，共" + deptList.count.description + "個校系)")
                        .opacity(0.5)
                } else {
                    Text("搜尋「" + searchText + "」 (已篩選出" + filteredDeptList.count.description + "個校系)")
                        .lineLimit(2)
                        .opacity(0.5)
                }
                
                Spacer()
            }
            .padding(.bottom,10)
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.systemGray))
                TextField("搜尋學校或科系", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(10)
            .background(Color(.quaternarySystemFill))
            .cornerRadius(10)
            
            ScrollView {
                LazyVStack {
                    ForEach(sortedDeptList) { dept in
                        
                        let passChance = deptListFunc.calPassChance(testResult: dept.testResult, data: data)
                        
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept)
                                .padding(.leading, 2)
                        }
                        
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(passChanceColor(for: passChance))
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                }
            }
            
        }
        .padding()
        
    }
    
    func passChanceColor(for chance: Double) -> Color {
        switch chance {
        case 0.8...:
            return .yellow
        case 0.6..<0.8:
            return .purple
        case 0.4..<0.6:
            return .blue
        case 0.2..<0.4:
            return .green
        case let x where x > 0 && x < 0.2:
            return .pink
        default:
            return .gray
        }
    }
    
}
