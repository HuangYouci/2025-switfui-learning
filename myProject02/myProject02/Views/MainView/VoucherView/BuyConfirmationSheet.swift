//
//  BuyConfirmationSheet.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct BuyConfirmationSheet: View {
    
    // 本 VIEW 新增環境變數
    // 繼承環境變數
    @EnvironmentObject var userInfo: UserInfo
    @EnvironmentObject var userDef: UserDef
    @EnvironmentObject var shopData: ShopData
    // 本 VIEW 綁定變數
    @Binding var buyConfirmationSheet: Bool
    
    let itemID: Int
    
    @State private var itemName: String = "未知"
    @State private var itemPrice: Int = 100000
    @State private var itemOrigPrice: Int = 100000
    @State private var balance: Int = 0
    @State private var buying: Int = -1
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            VStack{
                HStack{
                    Text("購買確認")
                        .bold()
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack{
                    Text("確定要購買")
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
                    
                    if itemOrigPrice != itemPrice {
                        Text(String(itemOrigPrice))
                            .font(.title)
                            .foregroundColor(Color(.systemGray))
                            .strikethrough(true, color: .red)
                        Image(systemName: "arrow.right")
                    }
                    
                    Text(String(itemPrice))
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                        .bold()
                    Text("P")
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                }
                .padding(.bottom, 10)
                
                if buying == -1 {
                    HStack{
                        
                        Spacer()
                        
                        Button(role: .none){
                            buying = 0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                                buyConfirmationSheet = false
                            }
                        } label: {
                            Text("取消")
                                .font(.title2)
                        }
                        .buttonStyle(.bordered)
                        Button(role: .none){
                            buying = 0
                            buying = shopBuyingItem(userInfo: userInfo, userID: userDef.uid, itemID: itemID, price: itemPrice)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2 ){
                                if buying > 0 { buyConfirmationSheet = false }
                            }
                        } label: {
                            Text("購買")
                                .font(.title2)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(balance < itemPrice)
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
            .onAppear{
                balance = userInfo.userPoints
                updateValue(itemID: itemID)
            }
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(10)
            .padding()
            
            Spacer()
            
        }
        .ignoresSafeArea(edges: .all)
        .background(Image("bgLogin").opacity(0.3))
        .background(BlurView(style: .systemMaterial))
        
    }
    
    func updateValue(itemID: Int){
        switch itemID {
        case 1:
            itemName = "15分鐘兌換券"
            itemPrice = shopData.t1s
            itemOrigPrice = shopData.t1o
        case 2:
            itemName = "1小時兌換券"
            itemPrice = shopData.t2s
            itemOrigPrice = shopData.t2o
        case 3:
            itemName = "整天兌換券"
            itemPrice = shopData.t3s
            itemOrigPrice = shopData.t3o
        default:
            itemName = "未知"
            itemPrice = 100000
            itemOrigPrice = 100000
        }
    }
    
}
