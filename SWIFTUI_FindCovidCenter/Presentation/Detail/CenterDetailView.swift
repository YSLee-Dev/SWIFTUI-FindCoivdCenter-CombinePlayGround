//
//  CenterDetailView.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/19.
//

import SwiftUI

struct CenterDetailView: View {
    var center : Center
    
    var body: some View {
        VStack{
            MapView(coordinate: center.coordinate)
                .ignoresSafeArea(edges: .all)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            CenterRow(center: center)
        }
        .navigationTitle(center.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CenterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, name: "경기도", address: "경기도 테스트시 테스트구", phoneNumber: "010-1234-5678", lat: "123", lng: "456", centerType: .central)
        
        CenterDetailView(center: center0)
    }
}
