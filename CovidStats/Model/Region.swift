//
//  Region.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/22.
//

import Foundation

struct AllRegion: Codable {
    let data: [Country]
}

struct Country: Codable {
    let iso: String
    let name: String
    
    static let dummyData = Country(iso: "N/A", name: "Error")
}
