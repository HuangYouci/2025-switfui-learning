//
//  DepartmentNotesView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/10.
//

import SwiftUI

struct DepartmentNotesView: View {
    
    // --------------- //
    // EnvironmentObject
    // StateObject
    // Binding
    // State
    @State private var isShowSheet = false
    @State var sheetExplansion: String?
    // --------------- //
    
    var department: deptListModel
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack{
                Image(systemName: "doc.text")
                Text("備註")
                Spacer()
            }
            .bold()
            .padding(.bottom, 10)
            
            HStack{
                Text("甄試費用")
                Spacer()
                Text(department.examFee)
                Text("元")
                    .foregroundColor(Color(.systemGray2))
            }
            .font(.headline)
            .padding(.bottom, 5)
            
            HStack{
                Text("公告甄試通知")
                Spacer()
                Text(department.notifyOrAnnounceExam)
            }
            .font(.headline)
            .padding(.bottom, 5)
            
            HStack{
                Text("甄試日期")
                Spacer()
                Text( !department.examDate1.isEmpty ? department.examDate1 : "點擊查看")
            }
            .font(.headline)
            .padding(.bottom, 5)
            .onTapGesture {
                sheetExplansion = "甄試日期 1：\(department.examDate1)\n甄試日期 2：\(department.examDate2)\n甄試日期 3：\(department.examDate3)\n甄試日期：\(department.examStartDate) ~ \(department.examEndDate)"
                isShowSheet = true
            }
            
            HStack{
                Text("榜示日期")
                Spacer()
                Text(department.announcementDate)
            }
            .font(.headline)
            .padding(.bottom, 5)
            
            HStack{
                Text("審查資料收件截止")
                Spacer()
                Text(department.documentSubmissionDeadline)
            }
            .font(.headline)
            .padding(.bottom, 5)
            
            HStack{
                Text("審查資料項目")
                Spacer()
            }
            .font(.headline)
            .padding(.vertical, 5)
            
            if (!department.document1.isEmpty) {
                HStack{
                    Text("1")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.document1)
                    Spacer()
                }
            }
            
            if (!department.document2.isEmpty) {
                HStack{
                    Text("2")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.document2)
                    Spacer()
                }
            }
            
            if (!department.document3.isEmpty) {
                HStack{
                    Text("3")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.document3)
                    Spacer()
                }
            }
            
            if (!department.document4.isEmpty) {
                HStack{
                    Text("4")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.document4)
                    Spacer()
                }
            }
            
            if (!department.document5.isEmpty) {
                HStack{
                    Text("5")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.document5)
                    Spacer()
                }
            }
            
            if (!department.document6.isEmpty) {
                HStack{
                    Text("6")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.document6)
                    Spacer()
                }
            }
            
            HStack{
                Text("第二階段同分參酌")
                Spacer()
            }
            .font(.headline)
            .padding(.vertical, 5)
            
            if (!department.tieBreakerOrder1.isEmpty) {
                HStack{
                    Text("1")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.tieBreakerOrder1)
                    Spacer()
                }
            }
            
            if (!department.tieBreakerOrder2.isEmpty) {
                HStack{
                    Text("2")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.tieBreakerOrder2)
                    Spacer()
                }
            }
            
            if (!department.tieBreakerOrder3.isEmpty) {
                HStack{
                    Text("3")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.tieBreakerOrder3)
                    Spacer()
                }
            }
            
            if (!department.tieBreakerOrder4.isEmpty) {
                HStack{
                    Text("4")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text(department.tieBreakerOrder4)
                    Spacer()
                }
            }
            
            HStack{
                Text("審查資料說明")
                Spacer()
            }
            .font(.headline)
            .padding(.vertical, 5)
            
            Text(department.documentDescription.isEmpty ? "無" : department.documentDescription)
            
            HStack{
                Text("甄試說明")
                Spacer()
            }
            .font(.headline)
            .padding(.vertical, 5)
            
            Text(department.designatedItemDescription)
            
            HStack{
                Text("其他備註")
                Spacer()
            }
            .font(.headline)
            .padding(.vertical, 5)
            
            Text(department.remarks)
            
        }
        .padding()
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .padding(5)
        .sheet(isPresented: $isShowSheet){
            SheetExplansionView(explansion: $sheetExplansion)
        }
        
    }
    
}
