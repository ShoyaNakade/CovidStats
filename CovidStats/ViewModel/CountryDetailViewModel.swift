//
//  CountryDetailViewModel.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/23.
//

import Foundation
import SwiftUI

final class CountryDetailViewModel: ObservableObject {
    @Published var reports: [RegionReport] = []
    @Published var alertItem: AlertItem?
    
    
    private var iso: String
    
    init(country: Country) {
        iso = country.iso
    }
    
    
    func fetchReport() {
        APIService.shared.fetchReports(for: iso) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let reports):
                    self.reports = reports
                case .failure(_):
                    self.alertItem = AlertContext.unableToFetchCountryStats
                }
            }
        }
    }
    
}
