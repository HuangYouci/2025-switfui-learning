//
//  AllListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/8.
//


import SwiftUI

struct AllListView: View {
    
    @EnvironmentObject var data: Data
    
    @Binding var selectedTab: Int
    
    @State var searchText: String = ""
    
    let deptList = loadCSVData()
    
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
        
        NavigationView {
            
            VStack {
                
                HStack{
                    Text("所有校系資訊")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack{
                    Image(systemName: "list.dash")
                        .opacity(0.5)
                    Text("校系資料" + " (共" + deptList.count.description + "個校系)")
                        .opacity(0.5)
                    
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
                            NavigationLink(destination: DeptDetailView(department: dept)){
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
}

#Preview {
    AllListView(selectedTab: .constant(3))
        .environmentObject(Data())
}
