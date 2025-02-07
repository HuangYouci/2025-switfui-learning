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
                    
                    if userData.systemPromo < 1.0 {
                        HStack{
                            Text("現正進行 \(String(format: "%.1f",(userData.systemPromo * 10))) 折促銷！")
                                .foregroundColor(Color(.white))
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                        .background(Color.red)
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    } else if userData.systemPromo > 1.0 {
                        HStack{
                            Text("目前價格較平常上漲 \(String(format: "%.1f",(userData.systemPromo))) 倍")
                                .foregroundColor(Color(.white))
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                        .background(Color.red)
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    }
                    
                    HStack{
                        
                        Text("\(Image(systemName: "ticket")) 15 分鐘兌換券")
                            .padding(.leading)
                        
                        Spacer()
                        
                        if (userData.systemPromo != 1.0){
                            Text("\(Int(Constants.ITEMACOST))")
                                .strikethrough(true, color: .accentColor)
                        }
                        
                        Text("\(Int(Constants.ITEMACOST * userData.systemPromo))")
                        
                        Text("P")
                        
                        Button(role: .none){
                            
                            userData.modifyScore( -Int( (Constants.ITEMACOST * userData.systemPromo)) )
                            
                            userData.modifyItem(a: 1)
                            
                        } label: {
                            Text("購買")
                        }
                        .disabled(userData.userScore < Int( (Constants.ITEMACOST * userData.systemPromo)))
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing)
                        
                        
                    }
                    
                    HStack{
                        
                        Text("\(Image(systemName: "ticket")) 1 小時兌換券")
                            .padding(.leading)
                        
                        Spacer()
                        
                        if (userData.systemPromo != 1.0){
                            Text("\(Int(Constants.ITEMBCOST))")
                                .strikethrough(true, color: .accentColor)
                        }
                        
                        Text("\(Int(Constants.ITEMBCOST * userData.systemPromo))")
                        
                        Text("P")
                        
                        Button(role: .none){
                            
                            userData.modifyScore( -Int( (Constants.ITEMBCOST * userData.systemPromo)) )
                            
                            userData.modifyItem(b: 1)
                            
                        } label: {
                            Text("購買")
                        }
                        .disabled(userData.userScore < Int( (Constants.ITEMBCOST * userData.systemPromo)))
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing)
                        
                        
                    }
                    
                    HStack{
                        
                        Text("\(Image(systemName: "ticket")) 整天兌換券")
                            .padding(.leading)
                        
                        Spacer()
                        
                        if (userData.systemPromo != 1.0){
                            Text("\(Int(Constants.ITEMCCOST))")
                                .strikethrough(true, color: .accentColor)
                        }
                        
                        Text("\(Int(Constants.ITEMCCOST * userData.systemPromo))")
                        
                        Text("P")
                        
                        Button(role: .none){
                            
                            userData.modifyScore( -Int( (Constants.ITEMCCOST * userData.systemPromo)) )
                            
                            userData.modifyItem(c: 1)
                            
                        } label: {
                            Text("購買")
                        }
                        .disabled(userData.userScore < Int( (Constants.ITEMCCOST * userData.systemPromo)))
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

