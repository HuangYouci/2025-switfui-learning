//
//  AdminShopView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/16.
//

import SwiftUI

struct AdminShopView: View {
    
    // 本 VIEW 新增環境變數
    @StateObject var shopData = ShopData()
    // 繼承環境變數
    // 本 VIEW 綁定變數
    
    @State var EditingTF1: String = ""
    @State var EditingTF2: String = ""
    @State var EditingTF3: String = ""
    @State var EditingTF4: String = ""
    @State var EditingTF5: String = ""
    @State var EditingTF6: String = ""
    
    var body: some View {
        VStack{
            
            VStack{
                
                HStack{
                    Text("商店設置")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()
                
            }
            
            ScrollView {
                
                VStack{
                    
                    VStack{
                        HStack{
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(5)
                                .background(Color(.systemGray).opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray).opacity(0.2), lineWidth: 1)
                                )
                            VStack(alignment: .leading){
                                Text("15分鐘兌換券")
                                Text("可用於兌換15分鐘獎勵時間")
                                    .foregroundColor(Color(.systemGray2))
                                    .font(.caption)
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(shopData.t1s)")
                                    .bold()
                                
                                Text("原價 \(shopData.t1o)")
                                    .font(.caption)
                            }
                        }
                        Divider()
                            .padding(.vertical, 5)
                        HStack{
                            Text("原價")
                            TextField("正整數 留空以保持預設", text: $EditingTF1)
                                .keyboardType(.numberPad)
                            Spacer()
                        }
                        HStack{
                            Text("售價")
                            TextField("正整數 留空以保持預設", text: $EditingTF2)
                                .keyboardType(.numberPad)
                        }
                        HStack{
                            Spacer()
                            Button(role: .none){
                                changeShopPrice(changeID: 1, price: Int(EditingTF1) ?? shopData.t1o)
                                changeShopPrice(changeID: 2, price: Int(EditingTF2) ?? shopData.t1s)
                                EditingTF1 = ""
                                EditingTF2 = ""
                            } label: {
                                Text("變更")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    
                    VStack{
                        HStack{
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(5)
                                .background(Color(.systemGray).opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray).opacity(0.2), lineWidth: 1)
                                )
                            VStack(alignment: .leading){
                                Text("1小時兌換券")
                                Text("可用於兌換1小時獎勵時間")
                                    .foregroundColor(Color(.systemGray2))
                                    .font(.caption)
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(shopData.t2s)")
                                    .bold()
                                
                                Text("原價 \(shopData.t2o)")
                                    .font(.caption)
                            }
                        }
                        Divider()
                            .padding(.vertical, 5)
                        HStack{
                            Text("原價")
                            TextField("正整數 留空以保持預設", text: $EditingTF3)
                                .keyboardType(.numberPad)
                            Spacer()
                        }
                        HStack{
                            Text("售價")
                            TextField("正整數 留空以保持預設", text: $EditingTF4)
                                .keyboardType(.numberPad)
                        }
                        HStack{
                            Spacer()
                            Button(role: .none){
                                changeShopPrice(changeID: 3, price: Int(EditingTF3) ?? shopData.t2o)
                                changeShopPrice(changeID: 4, price: Int(EditingTF4) ?? shopData.t2s)
                                EditingTF3 = ""
                                EditingTF4 = ""
                            } label: {
                                Text("變更")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    
                    VStack{
                        HStack{
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(5)
                                .background(Color(.systemGray).opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray).opacity(0.2), lineWidth: 1)
                                )
                            VStack(alignment: .leading){
                                Text("整天兌換券")
                                Text("可用於兌換整天獎勵時間")
                                    .foregroundColor(Color(.systemGray2))
                                    .font(.caption)
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(shopData.t3s)")
                                    .bold()
                                
                                Text("原價 \(shopData.t3o)")
                                    .font(.caption)
                            }
                        }
                        Divider()
                            .padding(.vertical, 5)
                        HStack{
                            Text("原價")
                            TextField("正整數 留空以保持預設", text: $EditingTF5)
                                .keyboardType(.numberPad)
                            Spacer()
                        }
                        HStack{
                            Text("售價")
                            TextField("正整數 留空以保持預設", text: $EditingTF6)
                                .keyboardType(.numberPad)
                        }
                        HStack{
                            Spacer()
                            Button(role: .none){
                                changeShopPrice(changeID: 5, price: Int(EditingTF5) ?? shopData.t3o)
                                changeShopPrice(changeID: 6, price: Int(EditingTF6) ?? shopData.t3s)
                                EditingTF5 = ""
                                EditingTF6 = ""
                            } label: {
                                Text("變更")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    
                }
                
            }
            .simultaneousGesture(
                DragGesture().onChanged { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                 to: nil,
                                                 from: nil,
                                                 for: nil)
                }
            ) // 關閉鍵盤 (iOS 15)
            .padding()
            .background(
                BlurView(style: .systemThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .padding()
            
        }
        .background(Image("bgLogin").opacity(0.3))
        .onAppear {
            shopData.fetchShopData()
        }
    }
    
}
