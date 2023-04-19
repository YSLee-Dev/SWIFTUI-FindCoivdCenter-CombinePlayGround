//
//  CenterRow.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/19.
//

import SwiftUI

struct CenterRow: View {
    var center : Center
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(self.center.name)
                    .font(.headline)
                Text(self.center.centerType.rawValue)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            Text(self.center.address)
                .font(.footnote)
            
            if let url = URL(string: "tel:" + self.center.phoneNumber)
            {
                Link(self.center.phoneNumber, destination: url)
            }
        }
        .padding()
    }
}

struct CenterRow_Previews: PreviewProvider {
    static var previews: some View {
        CenterRow(center: Center(id: 0, sido: .경기도, name: "경기도", address: "경기도 테스트시 테스트구", phoneNumber: "010-1234-5678", lat: "123", lng: "456", centerType: .central))
    }
}
