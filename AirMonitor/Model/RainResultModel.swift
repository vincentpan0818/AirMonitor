//
//  RainResultModel.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import Foundation

struct RainResultModel: Codable {
    let records: [RainResultRecordsModel]?
}

struct RainResultRecordsModel: Codable {
    let siteId: String
    let siteName: String
    let county: String
    let itemId: String
    let itemName: String
    let itemEngName: String
    let itemUnit: String
    let monitorDate: String
    let concentration: String

    enum CodingKeys: String, CodingKey {
        case siteId = "SiteId"
        case siteName = "SiteName"
        case county = "County"
        case itemId = "ItemId"
        case itemName = "ItemName"
        case itemEngName = "ItemEngName"
        case itemUnit = "ItemUnit"
        case monitorDate = "MonitorDate"
        case concentration = "Concentration"
    }
}
