//
//  VoucherView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct VoucherView: View{
    
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    @EnvironmentObject var userInfo: UserInfo
    @EnvironmentObject var userDef: UserDef
    // 本 VIEW 綁定變數
    
    @State private var useConfirmationSheet: Bool = false
    @State private var usingItemID: Int = 1
    
    var body: some View {
        
            VStack{
                
                VStack{
                    
                    HStack{
                        Text("時間兌換券")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    
                }
                
                
                ScrollView {
                    
                    NavigationLink(destination: ShopView().environmentObject(userInfo).environmentObject(userDef)){
                        HStack{
                            
                            Image(systemName: "cart")
                                .font(.largeTitle)
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(20)
                            
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("進入商店")
                                        .foregroundColor(.accentColor)
                                        .bold()
                                        .font(.title)
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Text("獎勵積分餘額")
                                    Text(String(userInfo.userPoints))
                                    Spacer()
                                }
                            }
                            
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        .padding()
                    }
                    
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
                        
                        Text(String(userInfo.userTime1Voucher))
                            .font(.title)
                            .bold()
                        
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    .onTapGesture{
                        usingItemID = 1
                        useConfirmationSheet = true
                    }
                    
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
                        
                        Text(String(userInfo.userTime2Voucher))
                            .font(.title)
                            .bold()
                        
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    .onTapGesture{
                        usingItemID = 2
                        useConfirmationSheet = true
                    }
                    
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
                        
                        Text(String(userInfo.userTime3Voucher))
                            .font(.title)
                            .bold()
                        
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground).opacity(0.3))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                    .onTapGesture{
                        usingItemID = 3
                        useConfirmationSheet = true
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
            .onChange(of: useConfirmationSheet) { _ in
                userInfo.fetchUserData(userId: userDef.uid)
            }
            .fullScreenCover(isPresented: $useConfirmationSheet) {
                UseConfirmationSheet(useConfirmationSheet: $useConfirmationSheet, itemID: usingItemID)
                    .environmentObject(userInfo)
                    .environmentObject(userDef)
                    .ignoresSafeArea()
            }
        
    }
}
