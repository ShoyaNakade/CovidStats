////
////  CovidFetchRequest.swift
////  CovidStats
////
////  Created by 中出翔也 on 2022/03/22.
////
//
//import Foundation
//import Alamofire
//import SwiftyJSON
//import SwiftUI
//
//
//class CovidFetchRequest: ObservableObject {
//
//    init() {
//        getCurrentTottal()
//    }
//
//    func getCurrentTottal() {
//        let headers: HTTPHeaders = [
//            "x-rapidapi-host": "covid-19-data.p.rapidapi.com",
//            "x-rapidapi-key": "d172e810e7msh47584ae043c146dp12d8eejsnb0b3c42c4a59"
//        ]
//
////        let request = NSMutableURLRequest(url: NSURL(string: "https://corona-virus-world-and-india-data.p.rapidapi.com/api")! as URL,
////                                                cachePolicy: .useProtocolCachePolicy,
////                                            timeoutInterval: 10.0)
//
//        AF.request("https://covid-19-data.p.rapidapi.com/totals?format=undefined", headers: headers).responseDecodable(of: JSON.self) { response in
//            debugPrint(response)
//        }
//
//    }
//
//
//
//}
