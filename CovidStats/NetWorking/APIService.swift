//
//  APIService.swift
//  CovidStats
//  https://rapidapi.com/axisbits-axisbits-default/api/covid-19-statistics/
//  Created by 中出翔也 on 2022/03/22.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private init () {
        
    }
    
    private let headers = [
        "X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com",
        "X-RapidAPI-Key": "eda6f3892emsh2d191f757d6c379p1e4dd5jsn14e1a892529f" //This is free Key by NakadeShoya
    ]
    
    private let baseURLString = "https://covid-19-statistics.p.rapidapi.com"
    
    func fetchTotalData(completion: @escaping ( Result<TotalData, Error>) -> Void) {

        let totalURLString = baseURLString + "/reports/total"
        
        let url = URL(string:  totalURLString)
        
        guard let url = url else {
            completion(.failure(CovidError.incorrectURL))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                completion(.failure(CovidError.noDataReceived))
            } else {
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
//                }
                let decorder = JSONDecoder()
                
                do {
                    let totalDataObject = try decorder.decode(TotalDataObject.self, from: data!)
                    completion(.success(totalDataObject.data))
                } catch let error {
                    completion(.failure(error))
                }
                
            }
        })

        dataTask.resume()
    }
    
    func fetchAllRegion(completion: @escaping ( Result<[Country], Error>) -> Void) {
        
        let decorder = JSONDecoder()
        //check if local data is available
        if let data = LocalFileManager.shared.fetchLocalCountries() {
            do {
                print("returning from local data")
                let allCountries = try decorder.decode(AllRegion.self, from: data)
                completion(.success(allCountries.data))
            } catch let error {
                completion(.failure(error))
            }
            return
        }
        
        let countriesURLString = baseURLString + "/regions"
        
        let url = URL(string:  countriesURLString)
        
        guard let url = url else {
            completion(.failure(CovidError.incorrectURL))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                completion(.failure(CovidError.noDataReceived))
            } else {
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
//                }
                
                // save locally
                LocalFileManager.shared.saveCountriesLocally(countryData: data)
                
                do {
                    print("returning from API")
                    let allCountries = try decorder.decode(AllRegion.self, from: data!)
                    completion(.success(allCountries.data))
                } catch let error {
                    completion(.failure(error))
                }
                
            }
        })

        dataTask.resume()
    }
    
    func fetchReports(for iso: String, completion: @escaping ( Result<[RegionReport], Error>) -> Void) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "y-MM-d"
//        let yesterday = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
//        let reportsURLString = baseURLString + "/reports?iso=\(iso)" + "&date=\(yesterday)"
        let reportsURLString = baseURLString + "/reports?iso=\(iso)"
        
        let url = URL(string:  reportsURLString)
        
        guard let url = url else {
            completion(.failure(CovidError.incorrectURL))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                completion(.failure(CovidError.noDataReceived))
            } else {
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print("Debug:\(json)")
//                }
                let decorder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "y-MM-dd" // APIに合わせる
                decorder.dateDecodingStrategy = .formatted(formatter)
                
                do {
                    let allReports = try decorder.decode(AllReports.self, from: data!)
                    print("DEBUG: allrepotst are fetcheed!! :\(allReports)")
                    completion(.success(allReports.data))
                } catch let error {
                    completion(.failure(error))
                }
                
            }
        })

        dataTask.resume()
    }
    
}
