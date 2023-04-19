//
//  CenterList.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/19.
//

import SwiftUI

struct CenterList: View {
    var centers = [Center]()
    
    var body: some View {
        List(self.centers, id: \.id){center in
            NavigationLink {
                CenterDetailView(center: center)
            } label: {
                CenterRow(center: center)
            }
            .navigationTitle(center.sido.rawValue)
        }
    }
}

struct CenterList_Previews: PreviewProvider {
    static var previews: some View {
        let centers = [
            Center(id: 0, sido: .경기도, name: "경기도", address: "경기도 테스트시 테스트구", phoneNumber: "010-1234-5678", lat: "123", lng: "456", centerType: .central),
            Center(id: 1, sido: .서울특별시, name: "서울특별시", address: "서울특별시 테스트구", phoneNumber: "010-9876-5432", lat: "567", lng: "789", centerType: .central)
        ]
        
        CenterList(centers: centers)
    }}
