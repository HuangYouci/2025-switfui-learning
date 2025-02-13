//
//  TrainDataManager.swift
//  myProject03
//
//  Created by 黃宥琦 on 2025/2/13.
//

import CoreData

class TrainDataManager {
    static let shared = TrainDataManager()
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchAndStoreTrainData() async throws {
        // 檢查是否需要更新數據
        if await !shouldUpdateData() {
            return
        }
        
        // 從 API 獲取數據
        let data = try await fetchDataFromAPI()
        let decoder = JSONDecoder()
        let response = try decoder.decode(TrainScheduleResponse.self, from: data)
        
        // 在主線程中保存到 Core Data
        try await MainActor.run {
            saveToDatabase(response)
            try context.save() // 確保變更被保存
        }
    }
    
    private func shouldUpdateData() async -> Bool {
        // 檢查最後更新時間
        let fetchRequest: NSFetchRequest<TrainSchedule> = TrainSchedule.fetchRequest()
        let schedules = try? context.fetch(fetchRequest)
        
        guard let lastUpdate = schedules?.first?.updateTime else {
            print("func shouldUpdateData return true")
            return true // 如果沒有數據，需要更新
        }
        
        // 檢查是否需要更新（例如：每24小時更新一次）
        // 這裡可以根據需求調整更新頻率
        return true // 目前總是更新，您可以根據需求修改這個邏輯
    }
    
    private func fetchAccessToken() async throws -> String {
        let url = URL(string: "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = [
            "grant_type": "client_credentials",
            "client_id": "",  // 你的 Client Id
            "client_secret": ""  // 你的 Client Secret
        ]
        
        let bodyData = body.map { key, value in
            return "\(key)=\(value)"
        }.joined(separator: "&")
        
        request.httpBody = bodyData.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        print("Access Token Response: \(jsonResponse ?? [:])")
        
        guard let accessToken = jsonResponse?["access_token"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        return accessToken
    }

    
    private func fetchDataFromAPI() async throws -> Data {
        let accessToken = try await fetchAccessToken()
        
        guard let url = URL(string: "https://tdx.transportdata.tw/api/basic/v3/Rail/TRA/DailyTrainTimetable/Today/TrainNo/108") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let responseStr = String(data: data, encoding: .utf8) {
            print("API Response: \(responseStr)")
        }
        
        return data
    }


    
    private func saveToDatabase(_ response: TrainScheduleResponse) {
        // 清除現有數據
        clearExistingData()
        
        // 創建新的 TrainSchedule
        let schedule = TrainSchedule(context: context)
        schedule.updateTime = response.updateTime
        schedule.updateInterval = Int32(response.updateInterval)
        schedule.srcUpdateTime = response.srcUpdateTime
        schedule.srcUpdateInterval = Int32(response.srcUpdateInterval)
        schedule.effectiveDate = response.effectiveDate
        schedule.expireDate = response.expireDate
        schedule.srcVersion = response.srcVersion
        schedule.timetableName = response.timetableName
        schedule.validityDescription = response.validityDesciption
        
        // 保存所有時刻表
        for timetableResponse in response.trainTimetables {
            let timetable = TrainTimetable(context: context)
            
            // 保存 TrainInfo
            let trainInfo = TrainInfo(context: context)
            trainInfo.trainNo = timetableResponse.trainInfo.trainNo
            trainInfo.routeID = timetableResponse.trainInfo.routeID
            trainInfo.direction = Int16(timetableResponse.trainInfo.direction)
            trainInfo.trainTypeID = timetableResponse.trainInfo.trainTypeID
            trainInfo.trainTypeCode = timetableResponse.trainInfo.trainTypeCode
            trainInfo.trainTypeZhTw = timetableResponse.trainInfo.trainTypeName.zh_tw
            trainInfo.trainTypeEn = timetableResponse.trainInfo.trainTypeName.en
            // ... 設置其他 TrainInfo 屬性
            
            // 保存 StopTimes
            for stopTimeResponse in timetableResponse.stopTimes {
                let stopTime = StopTime(context: context)
                stopTime.stopSequence = Int16(stopTimeResponse.stopSequence)
                stopTime.stationID = stopTimeResponse.stationID
                stopTime.stationZhTw = stopTimeResponse.stationName.zh_tw
                stopTime.stationEn = stopTimeResponse.stationName.en
                stopTime.arrivalTime = stopTimeResponse.arrivalTime
                stopTime.departureTime = stopTimeResponse.departureTime
                stopTime.timetable = timetable
            }
            
            // 保存 ServiceDay
            let serviceDay = ServiceDay(context: context)
            serviceDay.serviceTag = timetableResponse.serviceDay.serviceTag
            serviceDay.monday = Int16(timetableResponse.serviceDay.monday)
            serviceDay.tuesday = Int16(timetableResponse.serviceDay.tuesday)
            serviceDay.wednesday = Int16(timetableResponse.serviceDay.wednesday)
            serviceDay.thursday = Int16(timetableResponse.serviceDay.thursday)
            serviceDay.friday = Int16(timetableResponse.serviceDay.friday)
            serviceDay.saturday = Int16(timetableResponse.serviceDay.saturday)
            serviceDay.sunday = Int16(timetableResponse.serviceDay.sunday)
            serviceDay.nationalHolidays = Int16(timetableResponse.serviceDay.nationalHolidays)
            serviceDay.dayBeforeHoliday = Int16(timetableResponse.serviceDay.dayBeforeHoliday)
            serviceDay.dayAfterHoliday = Int16(timetableResponse.serviceDay.dayAfterHoliday)
            serviceDay.typhoonDay = Int16(timetableResponse.serviceDay.typhoonDay)
            serviceDay.timetable = timetable
            
            // 設置關係
            timetable.trainInfo = trainInfo
            timetable.serviceDay = serviceDay
            timetable.schedule = schedule
        }
        
        // 保存上下文
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
            context.rollback()
        }
    }
    
    private func clearExistingData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TrainSchedule.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error clearing existing data: \(error)")
        }
    }
}
