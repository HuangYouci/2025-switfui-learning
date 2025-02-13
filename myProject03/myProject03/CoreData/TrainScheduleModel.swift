//
//  TrainScheduleModel.swift
//  myProject03
//
//  Created by 黃宥琦 on 2025/2/13.
//

struct TrainScheduleResponse: Codable {
    let updateTime: String
    let updateInterval: Int
    let srcUpdateTime: String
    let srcUpdateInterval: Int
    let effectiveDate: String
    let expireDate: String
    let srcVersion: String
    let timetableName: String
    let validityDesciption: String
    let trainTimetables: [TrainTimetableResponse]
}

struct TrainTimetableResponse: Codable {
    let trainInfo: TrainInfoResponse
    let stopTimes: [StopTimeResponse]
    let serviceDay: ServiceDayResponse
}

struct TrainInfoResponse: Codable {
    let trainNo: String
    let routeID: String
    let direction: Int
    let trainTypeID: String
    let trainTypeCode: String
    let trainTypeName: TrainName
    let tripHeadSign: String
    let startingStationID: String
    let startingStationName: TrainName
    let endingStationID: String
    let endingStationName: TrainName
    let overNightStationID: String
    let tripLine: Int
    let wheelChairFlag: Int
    let packageServiceFlag: Int
    let diningFlag: Int
    let breastFeedFlag: Int
    let bikeFlag: Int
    let carFlag: Int
    let dailyFlag: Int
    let extraTrainFlag: Int
    let note: String
}

struct TrainName: Codable {
    let zh_tw: String
    let en: String
}

struct StopTimeResponse: Codable {
    let stopSequence: Int
    let stationID: String
    let stationName: TrainName
    let arrivalTime: String
    let departureTime: String
}

struct ServiceDayResponse: Codable {
    let serviceTag: String
    let monday: Int
    let tuesday: Int
    let wednesday: Int
    let thursday: Int
    let friday: Int
    let saturday: Int
    let sunday: Int
    let nationalHolidays: Int
    let dayBeforeHoliday: Int
    let dayAfterHoliday: Int
    let typhoonDay: Int
}
