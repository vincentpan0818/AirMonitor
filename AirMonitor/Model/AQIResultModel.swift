//
//  AQIResultModel.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/21.
//

import Foundation

struct AQIResultModel: Codable {
    let records: [AQIResultRecordsModel]?
    
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        records = try container.decodeIfPresent([AQIResultRecordsModel].self, forKey: .records) ?? []
    }
}



struct AQIResultRecordsModel: Codable {
    let siteName: String?
    let county: String?
    var aqi: String?
    let pollutant: String?
    let status: String?
    let so2: String?
    let co: String?
    let co_8hr: String?
    var o3: String?
    let o3_8hr: String?
    let pm10: String?
    let pm2_5: String?
    let no2: String?
    let nox: String?
    let no: String?
    let windSpeed: String?
    let windDirec: String?
    let publishTime: String?
    let pm2_5_avg: String?
    let pm10_avg: String?
    let so2_avg: String?
    let longitude: String?
    let latitude: String?
    let siteId: String?
    let importDate: String?
    
    var distence: Double = 0.0
    
    enum CodingKeys: String, CodingKey{
        case siteName = "SiteName"
        case county = "County"
        case aqi = "AQI"
        case pollutant = "Pollutant"
        case status = "Status"
        case so2 = "SO2"
        case co = "CO"
        case co_8hr = "CO_8hr"
        case o3 = "O3"
        case o3_8hr = "O3_8hr"
        case pm10 = "PM10"
        case pm2_5 = "PM2.5"
        case no2 = "NO2"
        case nox = "NOx"
        case no = "No"
        case windSpeed = "WindSpeed"
        case windDirec = "WindDirec"
        case publishTime = "PublishTime"
        case pm2_5_avg = "PM2.5_AVG"
        case pm10_avg = "PM10_AVG"
        case so2_avg = "SO2_AVG"
        case longitude = "Longitude"
        case latitude = "Latitude"
        case siteId = "SiteId"
        case importDate = "ImportData"
    }
    init(siteName: String = "",
         county: String = "",
         aqi: String = "0",
         pollutant: String = "",
         status: String = "",
         so2: String = "",
         co: String = "",
         co_8hr: String = "",
         o3: String = "",
         o3_8hr: String = "",
         pm10: String = "",
         pm2_5: String = "",
         no2: String = "",
         nox: String = "",
         no: String = "",
         windSpeed: String = "",
         windDirec: String = "",
         publishTime: String = "",
         pm2_5_avg: String = "",
         pm10_avg: String = "",
         so2_avg: String = "",
         longitude: String = "",
         latitude: String = "",
         siteId: String = "",
         importDate: String = ""
         ){
        self.siteName = siteName
        self.county = county
        self.aqi = aqi
        self.pollutant = pollutant
        self.status = status
        self.so2 = so2
        self.co = co
        self.co_8hr = co_8hr
        self.o3 = o3
        self.o3_8hr = o3_8hr
        self.pm10 = pm10
        self.pm2_5 = pm2_5
        self.no2 = no2
        self.nox = nox
        self.no = no
        self.windSpeed = windSpeed
        self.windDirec = windDirec
        self.publishTime = publishTime
        self.pm10_avg = pm10_avg
        self.pm2_5_avg = pm2_5_avg
        self.so2_avg = so2_avg
        self.longitude = longitude
        self.latitude = latitude
        self.siteId = siteId
        self.importDate = importDate
    }
}
