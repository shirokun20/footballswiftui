//
//  FootballResponseModel.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import Foundation

// MARK: - FootballResponseModel
struct FootballResponseModel: Codable {
    let leagues: [League]
}

// MARK: - League
struct League: Codable, Identifiable {
    var id: UUID = UUID()
    let idLeague: String?
    let strLeague: String?
    let strSport: String?
    let strLeagueAlternate: String?
    
    enum CodingKeys: String, CodingKey {
        case idLeague, strLeague
        case strSport
        case strLeagueAlternate
    }
}

extension League {
    static var dummyData: League {
        .init(idLeague: "4328", strLeague: "English Premier League", strSport: "Soccer", strLeagueAlternate: "Premier League, EPL")
    }
}
