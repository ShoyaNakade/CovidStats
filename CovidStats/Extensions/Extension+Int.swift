//
//  Extension+Int.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/23.
//

import Foundation


extension Int {
    var formatNumber: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))!
    }
      
    var roundedWidthAbbreviations: String {
        let number = Double(self)
        let million = number / 1_000_000
        
        if million >= 1.0 {
            return "\(round(million * 10) / 10)M"
        } else {
            return "\(self.formatNumber)"
        }
    }
}
