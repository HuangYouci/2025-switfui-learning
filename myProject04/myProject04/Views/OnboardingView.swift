//
//  OnboardingView.swift
//  myProject04
//
//  Created by 黃宥琦 on 2025/2/15.
//

import SwiftUI
import Contacts

struct OnboardingView: View {
    
    // --------------------- //
    // StateObject
    // EnvironmentObject
    @EnvironmentObject var contactData: ContactManager
    // Binding
    @Binding var isFirstLaunch: Bool
    // State
    @State var contactPermission: Bool = false
    // --------------------- //
    
    var body: some View {
        VStack{
            Image("Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
                .padding(.vertical, 30)
            Text("歡迎使用人際+")
                .font(.largeTitle)
                .bold()
            Text("助你更好管理聯絡人資訊")
                .font(.title3)
                .padding(.bottom, 30)
            
            HStack{
                Text("程式需要以下權限，請點擊以賦予")
                    .foregroundStyle(Color(.systemGray2))
                Spacer()
            }
            .padding(.horizontal, 30)
            
            HStack{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.accentColor)
                    .padding(.trailing)
                VStack(alignment: .leading){
                    Text("聯絡人")
                        .bold()
                    Text("程式依據本機的聯絡人資訊運作，因此需要取得聯絡人權限。")
                }
            }
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color( contactPermission ? .green : .red ).opacity(0.2), lineWidth: 1)
            )
            .onTapGesture {
                handleContactPermission() { status in
                    contactPermission = (status > 0)
                }
            }
            .padding(15)
            
            Spacer()
            
            Button(role: .none){
                isFirstLaunch = false
            } label: {
                Text("進入程式")
                    .font(.title2)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 40)
            .buttonStyle(.borderedProminent)
            .cornerRadius(10)
            .disabled(!contactPermission)
        }
    }
    
}
