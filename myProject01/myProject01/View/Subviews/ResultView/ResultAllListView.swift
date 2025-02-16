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
    
    var s1Dept: [deptListModel] {
        filteredDeptList.filter { dept in
            return (deptListFunc.calPassChance(testResult: dept.testResult, data: data) > 0 && deptListFunc.calPassChance(testResult: dept.testResult, data: data) < 0.2)
        }
    }
    
    var s2Dept: [deptListModel] {
        filteredDeptList.filter { dept in
            return (deptListFunc.calPassChance(testResult: dept.testResult, data: data) >= 0.2 && deptListFunc.calPassChance(testResult: dept.testResult, data: data) < 0.4)
        }
    }
    
    var s3Dept: [deptListModel] {
        filteredDeptList.filter { dept in
            return (deptListFunc.calPassChance(testResult: dept.testResult, data: data) >= 0.4 && deptListFunc.calPassChance(testResult: dept.testResult, data: data) < 0.6)
        }
    }
    
    var s4Dept: [deptListModel] {
        filteredDeptList.filter { dept in
            return (deptListFunc.calPassChance(testResult: dept.testResult, data: data) >= 0.6 && deptListFunc.calPassChance(testResult: dept.testResult, data: data) < 0.8)
        }
    }
    
    var s5Dept: [deptListModel] {
        filteredDeptList.filter { dept in
            return (deptListFunc.calPassChance(testResult: dept.testResult, data: data) >= 0.8)
        }
    }
    
    var nodataDept: [deptListModel] {
        filteredDeptList.filter { dept in
            return (deptListFunc.calPassChance(testResult: dept.testResult, data: data) == 0)
        }
    }
    
    var body: some View {
            
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
                    ForEach(s5Dept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept, displayMore: false)
                                .padding(.leading, 2)
                        }
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ForEach(s4Dept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept, displayMore: false)
                                .padding(.leading, 2)
                        }
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(Color.purple)
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ForEach(s3Dept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept, displayMore: false)
                                .padding(.leading, 2)
                        }
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ForEach(s2Dept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept, displayMore: false)
                                .padding(.leading, 2)
                        }
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ForEach(s1Dept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept, displayMore: false)
                                .padding(.leading, 2)
                        }
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(Color.pink)
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ForEach(nodataDept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept, data: data, displayMore: true)){
                            DeptRowView(department: dept, displayMore: false)
                                .padding(.leading, 2)
                        }
                        .overlay (
                            GeometryReader { proxy in
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 5, height: proxy.size.height)
                                    .position(x: 2.5, y: proxy.size.height / 2)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
        }
            
    }
}
