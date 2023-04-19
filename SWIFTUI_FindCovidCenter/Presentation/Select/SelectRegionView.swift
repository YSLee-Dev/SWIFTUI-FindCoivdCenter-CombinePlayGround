//
//  SelectRegionView.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/18.
//

import SwiftUI

struct SelectRegionView: View {
    @ObservedObject var viewModel = SelectRegionViewModel()
    
    private var items : [GridItem]{
        Array(repeating: .init(.flexible(minimum: 80)), count: 2)
    }
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                LazyVGrid(columns: self.items, spacing: 20){
                    ForEach(Center.Sido.allCases, id: \.id){ sido in
                        let centers = self.viewModel.centers[sido] ?? []
                        
                        NavigationLink {
                            CenterList(centers: centers)
                        } label: {
                            SelectRegionItem(region: sido, count: centers.count)
                        }

                    }
                }
                .padding()
                .navigationTitle("코로나 19 예방접종센터")
            }
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SelectRegionViewModel()
        SelectRegionView(viewModel: viewModel)
    }
}
