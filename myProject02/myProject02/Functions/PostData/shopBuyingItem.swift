//
//  shopBuyingItem.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

func shopBuyingItem(userInfo: UserInfo, userID: String, itemID: Int, price: Int) -> Int {
    switch itemID {
    case 1:
        changeUserVoucher(userId: userID, itemID: 1, change: 1)
        changeUserPoints(userId: userID, pointsChange: -price, reason: "購買15分鐘兌換券")
        return 2
    case 2:
        changeUserVoucher(userId: userID, itemID: 2, change: 1)
        changeUserPoints(userId: userID, pointsChange: -price, reason: "購買1小時兌換券")
        return 2
    case 3:
        changeUserVoucher(userId: userID, itemID: 3, change: 1)
        changeUserPoints(userId: userID, pointsChange: -price, reason: "購買整天兌換券")
        return 2
    default:
        return 1
    }
}
