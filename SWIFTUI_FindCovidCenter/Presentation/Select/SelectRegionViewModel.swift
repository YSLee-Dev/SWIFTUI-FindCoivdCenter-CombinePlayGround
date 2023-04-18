//
//  SelectRegionViewModel.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/18.
//

import Foundation

import Combine

class SelectRegionViewModel : ObservableObject{
    @Published var centers = [Center.Sido : [Center]]()
    private var bag = Set<AnyCancellable>() // disposeBag
    
    init(centerNetwork : CenterNetwork = .init()){
        centerNetwork.getCenterList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] in
                guard case .failure(let error) = $0 else {return}
                print(error.localizedDescription)
                self?.centers = [Center.Sido : [Center]]()
            }, receiveValue: { [weak self] centers in
                self?.centers = Dictionary(grouping: centers){
                    $0.sido
                }
            })
            .store(in: &bag) // disposed(by:)
    }
}
