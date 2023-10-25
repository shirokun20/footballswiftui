//
//  ApiBuilder.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import Foundation

protocol ApiBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

enum FootballAPI {
    case getAllLeagues
    case getTeamOnLeague(leagueName: String)
}

extension FootballAPI: ApiBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getAllLeagues, .getTeamOnLeague:
            return URL(string: "https://www.thesportsdb.com/api/v1/json/3")!
        }
    }
    
    var path: String {
        switch self {
        case .getAllLeagues:
            return "/all_leagues.php"
        case .getTeamOnLeague:
            return "/search_all_teams.php"
        }
    }
    
    
    var parameters: [String: String] {
        switch self {
        case .getAllLeagues:
            return [:]
        case .getTeamOnLeague(let leagueName):
            return ["l": leagueName]
        }
    }
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(url: self.baseUrl.appendingPathComponent(self.path), resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        return request
    }
    
}
