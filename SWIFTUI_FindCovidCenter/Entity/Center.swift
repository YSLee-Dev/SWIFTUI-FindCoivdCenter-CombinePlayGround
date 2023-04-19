//
//  Center.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/13.
//

import Foundation
import CoreLocation

struct Center : Hashable, Decodable{
    let id : Int
    let sido : Sido
    let name : String
    let address : String
    let phoneNumber : String
    let lat : String
    let lng : String
    let centerType : CenterType
    
    enum CenterType : String, Decodable{
        case central = "중앙/권역"
        case local = "지역"
    }
    
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case sido = "sido"
        case name = "facilityName"
        case address = "address"
        case phoneNumber = "phoneNumber"
        case lat = "lat"
        case lng = "lng"
        case centerType = "centerType"
    }
    
    enum Sido : String, Decodable, Identifiable, CaseIterable{
        case 서울특별시
        case 부산광역시
        case 대구광역시
        case 대전광역시
        case 인천광역시
        case 광주광역시
        case 울산광역시
        case 세종특별자치시
        case 경기도
        case 강원도
        case 충청북도
        case 충청남도
        case 전라북도
        case 전라남도
        case 경상북도
        case 경상남도
        case 제주특별자치도
        
        var id : String{
            self.rawValue
        }
    }
    
    var coordinate : CLLocationCoordinate2D{
        CLLocationCoordinate2D(
            latitude: CLLocationDegrees(self.lat) ?? .zero,
            longitude: CLLocationDegrees(self.lng) ?? .zero
        )
    }
}
