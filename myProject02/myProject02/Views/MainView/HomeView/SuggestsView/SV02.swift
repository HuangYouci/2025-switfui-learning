//
//  SV02.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

import SwiftUI

struct SV02 : View {
    var body: some View {
        
        HStack{
            Image(systemName: "percent")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .padding(.trailing, 5)
            VStack{
                HStack{
                    Text("商店特價")
                        .font(.title3)
                    Spacer()
                }
                HStack{
                   Text("商店正進行特價，全面五折！")
                        .foregroundColor(Color(.systemGray2))
                        .font(.caption)
                    Spacer()
                }
                
                Divider()
                    .padding(.vertical, 5)
                
                HStack{
                    Text("【限時優惠🔥 全場5折！】  \n時間兌換券商店瘋狂特賣開跑！現在所有商品 **全面五折**，這是你入手夢幻兌換券的最佳時機！⏳✨ 無論是想獲得額外學習時間、放鬆時光，還是享受獨特體驗，現在就是出手的時候！🎉\n機會稍縱即逝，特價活動限時開放，錯過就要等下次！趕快逛逛，選購你的專屬時間優惠券，用最划算的價格，為自己爭取更多價值！💡💰\n👉 **立即搶購，讓時間為你所用！**")
                        .font(.callout)
                    Spacer()
                }
            }
//            Image(systemName: "chevron.right")
//                .foregroundColor(Color(.systemGray))
//                .padding(.trailing, 5)
        }
        .padding()
        .background(Color(.systemGroupedBackground).opacity(0.1))
        .background(BlurView(style: .systemThinMaterial))
        .cornerRadius(10)
        
    }
}

#Preview {
    SV02()
}
