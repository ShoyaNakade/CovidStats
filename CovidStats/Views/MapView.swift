//
//  MapView.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/24.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

struct  MapView: UIViewRepresentable {
    @Binding var regionData: [RegionReport]
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        var allAnnotations: [CoronaCaseAnnotation] = []
        
        print("DEBUG: \(_regionData.wrappedValue)")
        for data in regionData {
            
            let title = data.region.province + "\n 感染者数" +
            (data.confirmed_diff?.formatNumber ?? "N/A") + "\n 死亡数"  +
            (data.deaths_diff?.formatNumber ?? "N/A")
            
            let coordinate = CLLocationCoordinate2D(latitude: Double(data.region.lat ?? "0") ?? 0, longitude:  Double(data.region.long ?? "0") ?? 0)
            
            allAnnotations.append(CoronaCaseAnnotation(title: title, coordinate: coordinate))
        }
        
        uiView.annotations.forEach{ uiView.removeAnnotation($0) } // reset
        uiView.addAnnotations(allAnnotations)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        return MKMapView()
    }
}

class CoronaCaseAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
