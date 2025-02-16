//
//  AdminView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/13.
//

import SwiftUI

struct AdminView: View {
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    // 本 VIEW 綁定變數
    
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                HStack{
                    Text("管理員設置")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()
                
            }
                    
            ScrollView {
                
                HStack{
                    Spacer()
                }
                
                NavigationLink(destination: AdminUserView()){
                    HStack{
                        VStack{
                            HStack{
                                Text("使用者設定")
                                Spacer()
                            }
                            HStack{
                                Text("調整使用者獎勵積分與兌換券資料")
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
                
                NavigationLink(destination: AdminShopView()){
                    HStack{
                        VStack{
                            HStack{
                                Text("商店設定")
                                Spacer()
                            }
                            HStack{
                                Text("調整商店物品價格")
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
                
                NavigationLink(destination: AdminAnnouncementView()){
                    HStack{
                        VStack{
                            HStack{
                                Text("公告設定")
                                Spacer()
                            }
                            HStack{
                                Text("查看、編輯、刪除現有公告")
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
    
}

#Preview {
    AdminView()
}
