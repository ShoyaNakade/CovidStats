//
//  MainViewModel.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/23.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var totalData: TotalData = TotalData.dummyData
    @Published var allCountries: [Country] = []
    @Published var searchText = ""
    @Published var isSearchVisible = false
    @Published var alertItem: AlertItem?
    
    
    init() {
        fetchTotalData()
        fetchAllCountries()
    }
    
    func fetchTotalData() {
        APIService.shared.fetchTotalData { result in
            //MARK: - dispatchを使う理由はfetchに時間がかかるから、backで走らせる。
            DispatchQueue.main.async {
                switch result{
                case .success(let totalData):
                    self.totalData = totalData
                case .failure(_):
                    self.alertItem = AlertContext.unableToFetchTotalStats
                }
            }
        }
    }
    
    func fetchAllCountries() {
        APIService.shared.fetchAllRegion { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let allCountries):
                    self.allCountries = allCountries.sorted(by: { $0.name < $1.name })
                case .failure(_):
                    self.alertItem = AlertContext.unableToFetchCountries
                }
            }
        }
    }
}
