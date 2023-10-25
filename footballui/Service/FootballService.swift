//
//  FootballService.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import Foundation
import Combine

protocol FootballService {
    func getAllLeagues(from endpoint: FootballAPI) -> AnyPublisher<FootballResponseModel, APIError>
    func getTeamsByLeagues(from endpoint: FootballAPI) -> AnyPublisher<TeamsResponseModel, APIError>
}

struct FootballServiceImpl: FootballService {
    func getAllLeagues(from endpoint: FootballAPI) -> AnyPublisher<FootballResponseModel, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<FootballResponseModel, APIError> in

                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                            .eraseToAnyPublisher()
                }

                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    
                    return Just(data)
                        .decode(type: FootballResponseModel.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                            .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getTeamsByLeagues(from endpoint: FootballAPI) -> AnyPublisher<TeamsResponseModel, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<TeamsResponseModel, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                            .eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    
                    return Just(data)
                        .decode(type: TeamsResponseModel.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                            .eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
    }
}
