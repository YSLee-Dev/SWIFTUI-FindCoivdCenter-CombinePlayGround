//
//  SelectRegionItem.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/18.
//

import SwiftUI

struct SelectRegionItem: View {
    var region : Center.Sido
    var count : Int
    
    var body: some View {
        ZStack{
            Color(white: 0.9)
            VStack{
                Text(self.region.rawValue)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                Text("(\(self.count))")
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SelectRegionItem_Previews: PreviewProvider {
    static var previews: some View {
        let region0 = Center.Sido.경기도
        
        SelectRegionItem(region: region0, count: 5)
    }
}
