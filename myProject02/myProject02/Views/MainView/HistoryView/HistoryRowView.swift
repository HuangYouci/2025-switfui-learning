//
//  HistoryRowView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct HistoryRowView: View {
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    // 本 VIEW 綁定變數
    
    var pointHistory: PointsHistory
    
    private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter
        }
    
    var body: some View {
        VStack {
            HStack{
                VStack{
                    HStack{
                        Text(pointHistory.reason)
                        Spacer()
                    }
                    HStack{
                        Text(pointHistory.timestamp, formatter: dateFormatter)
                        Spacer()
                    }
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(Color(.systemGray))
                }
                Text(String(pointHistory.changeAmount))
                    .foregroundColor(pointHistory.changeAmount > 0 ? Color(.green) : Color(.red))
            }
        }
        .padding(10)
        .background(Color(.quaternarySystemFill))
        .cornerRadius(10)
        .contextMenu {
            Text("變更前 " + String(pointHistory.oldPoints))
            Text("變更後 " + String(pointHistory.newPoints))
        }
    }
    
}
