//
//  LocalFileManager.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/23.
//

//  info.plist を開き、次の２行を追加し、Valueを YES にするとファイルが見られる。
//  Application supports iTunes file sharing
//  Supports opening documents in place

import Foundation

final class LocalFileManager {

    static let shared = LocalFileManager()
    
    func saveCountriesLocally(countryData: Data?) {
        if let countryData = countryData {
            if let json = try? JSONSerialization.jsonObject(with: countryData, options: []) as? [String : Any] {
                
                do {
                    let fileURL = getDocumentDirectory().appendingPathComponent("country.json")
                    
                    try JSONSerialization.data(withJSONObject: json).write(to: fileURL)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchLocalCountries() -> Data? {
        do {
            let fileURL = getDocumentDirectory().appendingPathComponent("country.json")
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func getDocumentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

}
