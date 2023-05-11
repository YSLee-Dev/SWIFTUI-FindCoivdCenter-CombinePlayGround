//
//  CenterNetwork.swift
//  SWIFTUI_FindCovidCenter
//
//  Created by 이윤수 on 2023/04/18.
//

import Foundation

import Combine

class CenterNetwork{
    private let session : URLSession
    let api = CenterAPI()
    
    init(session : URLSession = URLSession.shared){
        self.session = session
    }
    
    func getCenterList() async throws -> [Center]{
        guard let url = api.getCenterListComponents().url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Infuser \(RequestToken.token)", forHTTPHeaderField: "Authorization")
        
        let data = try await self.session.data(for: request)
        
        guard let http = data.1 as? HTTPURLResponse else {
            throw URLError(.unknown)
        }
        
        guard 200..<300 ~= http.statusCode else{
            throw URLError(.unknown)
        }
        
        let decoding = try JSONDecoder().decode(CenterAPIResponse.self, from: data.0)
        return decoding.data
        
        /*
        return self.session.dataTaskPublisher(for: request)
            .tryMap{data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 400..<500:
                    throw URLError(.clientCertificateRejected)
                case 500..<599:
                    throw URLError(.badServerResponse)
                default:
                    throw URLError(.unknown)
                }
            }
            .decode(type: CenterAPIResponse.self, decoder: JSONDecoder())
            .map{
                $0.data
            }
            .mapError{
                print($0)
                return $0 as? URLError ?? .init(.unknown)
            }
            .eraseToAnyPublisher()
         */
    }
}
