//
//  Main.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/5.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var userData: DataManager
    
    var body: some View {
        VStack{
            HStack{
                Text("您好，\n\(userData.userName)")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding()
            
            VStack{
                HStack{
                    Text("您目前的獎勵積分")
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
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MainView().environmentObject(DataManager())
}
