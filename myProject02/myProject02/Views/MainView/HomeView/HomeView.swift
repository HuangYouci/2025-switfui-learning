//
//  HomeView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct HomeView: View {
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    @EnvironmentObject var userDef: UserDef
    @EnvironmentObject var userInfo: UserInfo
    // 本 VIEW 綁定變數
    @Binding var loggingOut: Bool
    
    var body: some View {
        VStack{
            
            VStack{
                
                HStack{
                    Text(userInfo.userName)
                        .font(.largeTitle)
                        .bold()
                    
                    if userInfo.userIsAdmin {
                        NavigationLink(destination: AdminView()){
                                Text("管理員")
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color(.red))
                                    .cornerRadius(10)
                            }
                    }
                    
                    Spacer()
                    
                    Button(role: .none){
                        loggingOut = true
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
                
                HStack{
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .padding(5)
                        .background(Color(.systemGray).opacity(0.1))
                        .cornerRadius(10)
                    Text(verbatim: userDef.userEmail)
                    Spacer()
                }
                .padding(.top, -15)
                .padding(.bottom, 10)
                
                HStack{
                    
                    NavigationLink(destination: HistoryView(uid: userDef.uid)){
                        VStack{
                            
                            HStack{
                                Text("獎勵積分")
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            HStack{
                                Spacer()
                                Text(String(userInfo.userPoints))
                                    .bold()
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                            }
                            
                        }
                        .padding()
                        .background(
                            BlurView(style: .systemThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        )
                    }
                    
                    NavigationLink(destination: VoucherView()
                        .environmentObject(userInfo)
                        .environmentObject(userDef)){
                            VStack{
                                
                                HStack{
                                    Text("時間兌換券")
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                
                                HStack{
                                    Spacer()
                                    Text(String(userInfo.userTime1Voucher+userInfo.userTime2Voucher+userInfo.userTime3Voucher))
                                        .bold()
                                        .font(.title)
                                        .foregroundColor(.accentColor)
                                }
                                
                            }
                            .padding()
                            .background(
                                BlurView(style: .systemThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            )
                        }
                    
                }
                
            }
            .padding()
                
            
            ScrollView {
                HStack{
                    Spacer()
                }
                HStack{
                    Text("建議的事項")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 10)
                
                if userInfo.userIsAdmin == true {
                    NavigationLink(destination: AdminView()){
                        SV01_AdminCanSet() // 管理員設定
                    }
                }
                
                SV02()
                
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
        .navigationTitle("主頁")
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeView(loggingOut: .constant(false))
        .environmentObject(UserDef())
        .environmentObject(UserInfo())
}
