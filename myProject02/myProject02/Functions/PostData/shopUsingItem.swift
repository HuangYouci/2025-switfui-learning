//
//  shopUsingItem.swift
//  myProject02
//
//  Created by 黃宥琦 on 2025/2/14.
//

func shopUsingItem(userInfo: UserInfo, userID: String, itemID: Int) -> Int {
    switch itemID {
    case 1:
        changeUserVoucher(userId: userID, itemID: 1, change: -1)
        return 2
    case 2:
        changeUserVoucher(userId: userID, itemID: 2, change: -1)
        return 2
    case 3:
        changeUserVoucher(userId: userID, itemID: 3, change: -1)
        return 2
    default:
        return 1
    }
}
