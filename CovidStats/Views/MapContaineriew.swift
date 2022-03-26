//
//  MapContaineriew.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/25.
//

import SwiftUI

struct MapContaineriew: View {
    @ObservedObject var mapViewModel = CountryDetailViewModel(country: Country(iso: "JPN", name: "Japan"))
    
    var body: some View {
        MapView(regionData: $mapViewModel.reports)
            .onAppear {
                    mapViewModel.fetchReport()
            }
    }
}

struct MapContaineriew_Previews: PreviewProvider {
    @State static private var viewModel = CountryDetailViewModel(country: Country.dummyData)
    static var previews: some View {
        MapContaineriew()
    }
}
