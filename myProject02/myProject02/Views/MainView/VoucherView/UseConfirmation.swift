//
//  BuyConfirmationSheet.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct UseConfirmationSheet: View {
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    @EnvironmentObject var userInfo: UserInfo
    @EnvironmentObject var userDef: UserDef
    // 本 VIEW 綁定變數
    @Binding var useConfirmationSheet: Bool
    
    let itemID: Int
    
    @State private var itemName: String = "未知"
    @State private var itemCount: Int = 0
    @State private var using: Int = -1
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            VStack{
                HStack{
                    Text("使用確認")
                        .bold()
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack{
                    Text("確定要使用")
                        .foregroundColor(Color(.systemGray))
                    Text(itemName)
                        .foregroundColor(.accentColor)
                        .bold()
                    Text("嗎")
                        .foregroundColor(Color(.systemGray))
                    Spacer()
                }
                .font(.title3)
                
                Divider()
                    .padding(.vertical, 10)
                
                HStack{
                    
                    if itemCount >= 1 {
                        
                        Text(String(itemCount))
                            .font(.title)
                            .foregroundColor(Color(.systemGray))
                        Image(systemName: "arrow.right")
                        
                        Text(String(itemCount - 1))
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                            .bold()
                        Text("個")
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                        
                    } else {
                        
                        Text("0")
                            .font(.title)
                            .foregroundColor(Color(.systemGray))
                        Text("個")
                            .foregroundColor(Color(.systemGray))
                        Spacer()
                        
                    }
                    
                }
                .padding(.bottom, 10)
                
                if using == -1 {
                    HStack{
                        
                        Spacer()
                        
                        Button(role: .none){
                            using = 0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                                useConfirmationSheet = false
                            }
                        } label: {
                            Text("取消")
                                .font(.title2)
                        }
                        .buttonStyle(.bordered)
                        Button(role: .none){
                            using = 0
                            using = shopUsingItem(userInfo: userInfo, userID: userDef.uid, itemID: itemID)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
                                if using > 0 { useConfirmationSheet = false }
                            }
                        } label: {
                            Text( itemCount < 1 ? "積分不足" : "確認")
                                .font(.title2)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(itemCount < 1)
                    }
                } else {
                    HStack {
                        Spacer()
                        Button(role: .none){
                        } label: {
                            Text("處理中...")
                                .font(.title2)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(true)
                    }
                }
                
            }
            .padding()
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .onAppear{
            updateValue(itemID: itemID)
        }
        .ignoresSafeArea(edges: .all)
        .background(Image("bgLogin").opacity(0.3))
        .background(BlurView(style: .systemMaterial))
        
    }
    
    func updateValue(itemID: Int){
        switch itemID {
        case 1:
            itemCount = userInfo.userTime1Voucher
            itemName = "15分鐘兌換券"
        case 2:
            itemCount = userInfo.userTime2Voucher
            itemName = "1小時兌換券"
        case 3:
            itemCount = userInfo.userTime3Voucher
            itemName = "整天兌換券"
        default:
            itemName = "未知"
        }
    }
    
}
