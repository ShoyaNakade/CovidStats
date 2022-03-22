//
//  TotalData.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/22.
//

import Foundation

struct TotalDataObject: Codable {
    let data: TotalData // APIに合わせている
}

struct TotalData: Codable {
    let confirmed: Int
    let deaths: Int
    let active: Int
    let fatality_rate: Double
}
