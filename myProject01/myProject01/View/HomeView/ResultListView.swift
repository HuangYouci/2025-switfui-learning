//
//  ResultListView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/16.
//

import SwiftUI

struct ResultListView: View {
    
    // --------------- //
    // EnvironmentObject
    @EnvironmentObject var data: UserDef
    // StateObject
    // Binding
    @Binding var selectedTab: Int
    // State
    // --------------- //
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack{
                    Text("所有分析結果")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack{
                    Image(systemName: "list.dash")
                        .opacity(0.5)
                    
                    Text("分析資料" + " (共" + data.userResultData.count.description + "個結果)")
                        .opacity(0.5)
                    
                    Spacer()
                }
                .padding(.bottom,10)
                
                
                ScrollView {
                    LazyVStack {
                        ForEach(data.userResultData.indices, id: \.self) { index in
                            NavigationLink(destination: ResultView(data: data.userResultData[index])){
                                VStack {
                                    HStack{
                                        VStack{
                                            HStack{
                                                Text("分析 #\(index + 1)")
                                                Spacer()
                                            }
                                            HStack{
                                                Text("國\(data.userResultData[index].gradeCH)")
                                                Text("英\(data.userResultData[index].gradeEN)")
                                                Text("Ａ\(data.userResultData[index].gradeMA)")
                                                Text("Ｂ\(data.userResultData[index].gradeMB)")
                                                Text("自\(data.userResultData[index].gradeSC)")
                                                Text("社\(data.userResultData[index].gradeSO)")
                                                Spacer()
                                            }
                                            .font(.system(.footnote, design: .monospaced))
                                            .foregroundColor(Color(.systemGray))
                                        }
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color(.systemGray))
                                            .padding(.trailing, 5)
                                    }
                                }
                                .padding(10)
                                .background(Color(.quaternarySystemFill))
                                .cornerRadius(10)
                                .contextMenu{
                                    Button(role: .destructive){
                                        data.userResultData.remove(at: index)
                                    } label: {
                                        Label("刪除此筆資料", systemImage: "trash")
                                    }
                                }
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
