//
//  StoreView.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/7.
//

import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var userData: DataManager
    
    var body: some View {
        VStack{
            HStack{
                Text("\(userData.userName)，\n歡迎來到獎勵積分商店")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            
            VStack{
                HStack{
                    Text("\(Image(systemName: "dollarsign.circle")) 獎勵積分")
                        .bold()
                    Spacer()
                }
                
                HStack{
                    Text("\(userData.userScore)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            }
            .padding()
            
            VStack{
                
                HStack{
                    Text("\(Image(systemName: "creditcard.circle")) 螢幕使用時間兌換券")
                        .bold()
                    Spacer()
                }
                .padding()
                
                HStack{
                    
                    VStack{
                        Text("15分鐘")
                        Text("\(userData.userItemA)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    VStack{
                        Text("1小時")
                        Text("\(userData.userItemB)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("整天")
                        Text("\(userData.userItemC)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    
                    Spacer()
                }
            }
            .padding(.bottom)
            
            VStack{
                HStack{
                    Text("\(Image(systemName: "cart.circle")) 購買螢幕使用時間兌換券")
                        .bold()
                        .padding()
                    Spacer()
                }
                
                ScrollView{
                    
                    if Constants.PROMOTION != 1.0 {
                        HStack{
                            Text("現正進行 \(String(format: "%.1f",(Constants.PROMOTION * 10))) 折促銷！")
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                        .background(Color.red.opacity(0.5))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    }
                    
                    HStack{
                        
                        Text("以 \(Int(Constants.ITEMACOST * Constants.PROMOTION)) 獎勵積分購買 15 分鐘兌換券")
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(role: .none){
                            
                            userData.modifyScore( -Int( (Constants.ITEMACOST * Constants.PROMOTION)) )
                            
                            userData.modifyItem(a: 1)
                            
                        } label: {
                            Text("購買")
                        }
                        .disabled(userData.userScore <= Int( (Constants.ITEMACOST * Constants.PROMOTION)))
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing)
                        
                        
                    }
                    
                    HStack{
                        
                        Text("以 \(Int(Constants.ITEMBCOST * Constants.PROMOTION)) 獎勵積分購買 1 小時兌換券")
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(role: .none){
                            
                            userData.modifyScore( -Int( (Constants.ITEMBCOST * Constants.PROMOTION)) )
                            
                            userData.modifyItem(b: 1)
                            
                        } label: {
                            Text("購買")
                        }
                        .disabled(userData.userScore <= Int( (Constants.ITEMBCOST * Constants.PROMOTION)))
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing)
                        
                        
                    }
                    
                    HStack{
                        
                        Text("以 \(Int(Constants.ITEMCCOST * Constants.PROMOTION)) 獎勵積分購買整天兌換券")
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(role: .none){
                            
                            userData.modifyScore( -Int( (Constants.ITEMCCOST * Constants.PROMOTION)) )
                            
                            userData.modifyItem(c: 1)
                            
                        } label: {
                            Text("購買")
                        }
                        .disabled(userData.userScore <= Int( (Constants.ITEMCCOST * Constants.PROMOTION)))
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing)
                        
                        
                    }
                    
                    
                }
                
            }
            
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    StoreView().environmentObject(DataManager())
}

