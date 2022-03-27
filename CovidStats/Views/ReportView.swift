//
//  ReportView.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/23.
//

import SwiftUI

struct ReportView: View {
    var report: RegionReport
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [
                Color(red: 0.76, green: 0.15, blue: 0.26),
                Color(red: 0.01, green: 0.23, blue: 0.5)
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text(report.region.name)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Text(report.region.province)
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                VStack(alignment: .leading , spacing: 15) {
                    Text("日時: \(report.formattedData)")
                    Text("総感染者数: \(report.confirmed.roundedWidthAbbreviations)")
                    Text("総死亡者: \(report.deaths.roundedWidthAbbreviations)")
                    Text("今日の感染者数: \(report.confirmed_diff?.roundedWidthAbbreviations ?? "N/A")")
                    Text("今日の死亡者数: \(report.deaths_diff?.roundedWidthAbbreviations ?? "N/A")")
                    Text("致死率: \(report.fatality_rate.formatted())%")
                }
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding(50)
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Spacer()
                Spacer()
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(report: RegionReport.dummyData)
    }
}
