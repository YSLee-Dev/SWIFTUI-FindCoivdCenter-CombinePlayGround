//
//  MapView.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/19.
//

import SwiftUI
import MapKit

struct AnnotationItem : Identifiable{
    let id = UUID()
    var coodinate : CLLocationCoordinate2D
}

struct MapView: View {
    @State private var region = MKCoordinateRegion()
    @State private var annotationItems = [AnnotationItem]()
    
    var coordinate : CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [AnnotationItem(coodinate: coordinate)],
            annotationContent: {
            MapMarker(coordinate: $0.coodinate)
        })
        .onAppear{
            setResion(self.coordinate)
            setAnnotationItems(self.coordinate)
        }
    }
    
    private func setResion(_ coorinate : CLLocationCoordinate2D){
        self.region = MKCoordinateRegion(
            center: coorinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    }
    
    private func setAnnotationItems(_ coordinate : CLLocationCoordinate2D){
        self.annotationItems = [AnnotationItem(coodinate: coordinate)]
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, name: "경기도", address: "경기도 테스트시 테스트구", phoneNumber: "010-1234-5678", lat: "123", lng: "456", centerType: .central)
        MapView(
            coordinate: CLLocationCoordinate2D(
                latitude: CLLocationDegrees(center0.lat) ?? .zero,
                longitude: CLLocationDegrees(center0.lng) ?? .zero)
        )
    }
}
