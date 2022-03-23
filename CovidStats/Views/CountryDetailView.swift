//
//  CountryDetailView.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/23.
//

import SwiftUI

struct CountryDetailView: View {
    @ObservedObject var viewModel: CountryDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.reports.count > 1 {
                // show list of states
                List {
                    ForEach(viewModel.reports) { report  in
                        NavigationLink {
                            ReportView(report: report)
                        } label: {
                            Text(report.region.province)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle(viewModel.reports.first?.region.name ?? "不明国")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                // detail view
                ReportView(report: viewModel.reports.first ?? RegionReport.dummyData)
                    .ignoresSafeArea()
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            if viewModel.reports.count == 0 {
                // detail view　の時のみ読み込む
                viewModel.fetchReport()
            }
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(viewModel: CountryDetailViewModel(country: Country.dummyData))
    }
}
