//
//  ShopView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct ShopView: View {
    
    // 本 VIEW 新增環境變數
    @StateObject private var shopData = ShopData()
    // 繼承環境變數
    @EnvironmentObject var userInfo: UserInfo
    @EnvironmentObject var userDef: UserDef
    // 本 VIEW 綁定變數
    
    @State private var buyConfirmationSheet: Bool = false
    @State private var buyingItemID: Int = 1
    
    var body: some View {
        
        ZStack{
            
            if shopData.loaded == 1{
                VStack{
                    
                    VStack{
                        
                        HStack{
                            Text("商店")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                        }
                        .padding()
                        
                    }
                    
                    
                    ScrollView {
                        
                        HStack{
                            
                            Image(systemName: "creditcard")
                                .font(.largeTitle)
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                            
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("獎勵積分")
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Text(String(userInfo.userPoints))
                                        .foregroundColor(.accentColor)
                                        .bold()
                                        .font(.title)
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        .padding()
                        
                        
                        // ITEM 1
                        VStack {
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
                                
                                Text(String(shopData.t1s))
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .bold()
                                
                                Text("P")
                                    .foregroundColor(.accentColor)
                                
                            }
                            Divider()
                                .padding(.bottom, 5)
                            HStack{
                                Text("目前擁有")
                                Text(String(userInfo.userTime1Voucher))
                                Spacer()
                                Text("原價")
                                Text(String(shopData.t1o))
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground).opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                        .onTapGesture{
                            buyingItemID = 1
                            buyConfirmationSheet = true
                        }
                        
                        // ITEM 2
                        VStack {
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
                                
                                Text(String(shopData.t2s))
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .bold()
                                
                                Text("P")
                                    .foregroundColor(.accentColor)
                                
                            }
                            Divider()
                                .padding(.bottom, 5)
                            HStack{
                                Text("目前擁有")
                                Text(String(userInfo.userTime2Voucher))
                                Spacer()
                                Text("原價")
                                Text(String(shopData.t2o))
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground).opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                        .onTapGesture{
                            buyingItemID = 2
                            buyConfirmationSheet = true
                        }
                        
                        // ITEM 3
                        
                        VStack {
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
                                
                                Text(String(shopData.t3s))
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .bold()
                                
                                Text("P")
                                    .foregroundColor(.accentColor)
                                
                            }
                            Divider()
                                .padding(.bottom, 5)
                            HStack{
                                Text("目前擁有")
                                Text(String(userInfo.userTime3Voucher))
                                Spacer()
                                Text("原價")
                                Text(String(shopData.t3o))
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground).opacity(0.3))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                        .onTapGesture{
                            buyingItemID = 3
                            buyConfirmationSheet = true
                        }
                        
                        
                    }
                    .padding()
                    .background(
                        BlurView(style: .systemThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    )
                    .edgesIgnoringSafeArea(.all)
                    
                }
                .background(Image("bgLogin").opacity(0.3))
            }
            
            if shopData.loaded == 0 {
                ProgressingView()
                    .background(Image("bgLogin").opacity(0.3))
            }
            
        }
        .onAppear{
            if userDef.uid != "0" {
                shopData.fetchShopData()
                userInfo.fetchUserData(userId: userDef.uid)
            }
        }
        .onChange(of: buyConfirmationSheet) { _ in
            userInfo.fetchUserData(userId: userDef.uid)
        }
        .fullScreenCover(isPresented: $buyConfirmationSheet){
            BuyConfirmationSheet(buyConfirmationSheet: $buyConfirmationSheet, itemID: buyingItemID)
                .environmentObject(userInfo)
                .environmentObject(userDef)
                .environmentObject(shopData)
                .ignoresSafeArea()
        }
        
    }
    
}
