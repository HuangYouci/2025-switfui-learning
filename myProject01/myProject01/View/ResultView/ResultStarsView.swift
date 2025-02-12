//
//  ResultStarsView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/12.
//

import SwiftUI

// MARK: 5S

struct Result5SView : View {
    
    @EnvironmentObject var data: Data
    
    let filiteredDept: [deptListModel]
    
    var body: some View {
        
        var displayDept: [deptListModel] {
            filiteredDept.filter { dept in
                return (deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) >= 0.8)
            }
        }
        
        VStack{
            HStack{
                Text("保底校系")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack{
                Image(systemName: "info.circle")
                    .opacity(0.5)
                Text("您已通過這些校系的科目檢定。經系統計算，非常有可能錄取的校系顯示於此，共" + String(displayDept.count) + "個校系在此清單中。")
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.bottom,10)
            
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(displayDept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept)) {
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

// MARK: 4S

struct Result4SView : View {
    
    @EnvironmentObject var data: Data
    
    let filiteredDept: [deptListModel]
    
    var body: some View {
        
        var displayDept: [deptListModel] {
            filiteredDept.filter { dept in
                return (deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) >= 0.6 && deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) < 0.8)
            }
        }
        
        VStack{
            HStack{
                Text("安全校系")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack{
                Image(systemName: "info.circle")
                    .opacity(0.5)
                Text("您已通過這些校系的科目檢定。經系統計算，有較高錄取機率的校系顯示於此，共" + String(displayDept.count) + "個校系在此清單中。")
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.bottom,10)
            
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(displayDept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept)) {
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

// MARK: 3S

struct Result3SView : View {
    
    @EnvironmentObject var data: Data
    
    let filiteredDept: [deptListModel]
    
    var body: some View {
        
        var displayDept: [deptListModel] {
            filiteredDept.filter { dept in
                return (deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) >= 0.4 && deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) < 0.6)
            }
        }
        
        VStack{
            HStack{
                Text("一般校系")
                    .font(.title)
                    .bold()
                Spacer()
                    .padding(.bottom, 10)
            }
            
            HStack{
                Image(systemName: "info.circle")
                    .opacity(0.5)
                Text("您已通過這些校系的科目檢定。經系統計算，有一般機率錄取的校系顯示於此，共" + String(displayDept.count) + "個校系在此清單中。")
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.bottom,10)
            
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(displayDept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept)) {
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

// MARK: 2S

struct Result2SView : View {
    
    @EnvironmentObject var data: Data
    
    let filiteredDept: [deptListModel]
    
    var body: some View {
        
        var displayDept: [deptListModel] {
            filiteredDept.filter { dept in
                return (deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) >= 0.2 && deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) < 0.4)
            }
        }
        
        VStack{
            HStack{
                Text("進攻校系")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack{
                Image(systemName: "info.circle")
                    .opacity(0.5)
                Text("您已通過這些校系的科目檢定。經系統計算，有小機率錄取的校系顯示於此，共" + String(displayDept.count) + "個校系在此清單中。")
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.bottom,10)
            
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(displayDept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept)) {
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

// MARK: 1S

struct Result1SView : View {
    
    @EnvironmentObject var data: Data
    
    let filiteredDept: [deptListModel]
    
    var body: some View {
        
        var displayDept: [deptListModel] {
            filiteredDept.filter { dept in
                return (deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) > 0 && deptListFunc.calPassChance(testResult: dept.testResult, data: Data()) < 0.2)
            }
        }
        
        VStack{
            HStack{
                Text("夢幻校系")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.bottom, 10)
            
            HStack{
                Image(systemName: "info.circle")
                    .opacity(0.5)
                Text("您已通過這些校系的科目檢定。經系統計算，有極低可能錄取機率的校系顯示於此，共" + String(displayDept.count) + "個校系在此清單中。")
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.bottom,10)
            
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(displayDept) { dept in
                        NavigationLink(destination: DeptDetailView(department: dept)) {
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
