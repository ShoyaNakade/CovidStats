//
//  Report.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/22.
//

import Foundation

struct AllReports: Codable {
    let data: [RegionReport]
}

struct RegionReport: Codable, Identifiable {
    let id = UUID()
    let date: Date
    let confirmed: Int
    let deaths: Int
    let confirmed_diff: Int?
    let deaths_diff: Int?
    let active: Int
    let fatality_rate: Double
    let region: RegionDetail
    
    var formattedData: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    static let dummyData = RegionReport(date: Date.now, confirmed: 0, deaths: 0, confirmed_diff: 0, deaths_diff: 0, active: 0, fatality_rate: 0.0, region: RegionDetail(iso: "",lat: "",long: "", name: "N/A", province: ""))
    
}

struct RegionDetail: Codable {
//    let lat: Double
//    let long: Double
    let iso: String
    let lat: String?
    let long: String?
    let name: String
    let province: String
    
}
