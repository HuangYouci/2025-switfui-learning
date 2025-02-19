//
//  DeptListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/17.
//

import SwiftUI

struct DeptListView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    @State var searchText: String = "" // 篩選器：搜尋字串
    // --------------- //
    
    let deptList: [deptListModel] // 傳入要顯示的所有科系
    let title: String // 傳入 Title
    let displayMore: Bool // 傳入是否顯示更多
    
    let gradeData: gradeData // 傳入該筆資料的成績
    
    // 自訂篩選器
    
    // 篩選：搜尋字串
    
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
        
        VStack{
            
            HStack{
                Text(title)
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack{
                Image(systemName: "list.dash")
                    .opacity(0.5)
                
                if searchText.isEmpty {
                    Text("校系資料" + " (共" + deptList.count.description + "個校系)")
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
                    ForEach(filteredDeptList) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: gradeData, displayMore: displayMore)){
                            DeptRowView(department: dept)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
        }
        .padding()
        
    }
}
