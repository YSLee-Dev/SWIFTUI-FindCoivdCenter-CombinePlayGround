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
    // private var bag = Set<AnyCancellable>() // disposeBag
    
    init(centerNetwork : CenterNetwork = .init()){
        Task{
            do{
                let data = try await centerNetwork.getCenterList()
                await MainActor.run{
                    self.centers = Dictionary(grouping: data){
                        $0.sido
                    }
                }
            }catch{
                print("Error")
            }
        }
        /*
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
         */
    }
}
