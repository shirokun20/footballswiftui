//
//  TeamsResponseModel.swift
//  footballui
//
//  Created by macbook on 19/10/23.
//

import Foundation

struct TeamsResponseModel: Codable {
    let teams: [Team]
}

// MARK: - Team
struct Team: Codable, Identifiable {
    var id: UUID = UUID()
    let idTeam, strTeam, strTeamShort, strAlternate: String?
    let intFormedYear, strSport, strStadium: String?
    let strStadiumThumb: String?
    let strStadiumDescription, strStadiumLocation, intStadiumCapacity, strWebsite: String?
    let strFacebook, strTwitter, strInstagram, strDescriptionEN: String?
    let strCountry: String?
    let strTeamBadge, strTeamJersey, strTeamLogo: String?
    let strTeamFanart1, strTeamFanart2, strTeamFanart3, strTeamFanart4: String?
    let strTeamBanner: String?
    let strYoutube: String?
    
    enum CodingKeys: String, CodingKey {
        case idTeam, strTeam, strTeamShort, strAlternate
        case intFormedYear, strSport, strStadium
        case strStadiumThumb
        case strStadiumDescription, strStadiumLocation, intStadiumCapacity, strWebsite
        case strFacebook, strTwitter, strInstagram, strDescriptionEN
        case strCountry
        case strTeamBadge, strTeamJersey, strTeamLogo
        case strTeamFanart1, strTeamFanart2, strTeamFanart3, strTeamFanart4
        case strTeamBanner
        case strYoutube
    }
}

extension Team {
    static var dummyData: Team {
        .init(
            idTeam: "133604",
            strTeam: "Arsenal",
            strTeamShort: "ARS",
            strAlternate: "Arsenal Football Club, AFC, Arsenal FC",
            intFormedYear: "1892",
            strSport: "Soccer",
            strStadium: "Emirates Stadium",
            strStadiumThumb: "https://www.thesportsdb.com/images/media/team/stadium/w1anwa1588432105.jpg",
            strStadiumDescription: "The Emirates Stadium.....", strStadiumLocation: "Holloway, London, England",
            intStadiumCapacity: "60338",
            strWebsite: "www.arsenal.com",
            strFacebook: "www.facebook.com/Arsenal",
            strTwitter: "twitter.com/arsenal",
            strInstagram: "instagram.com/arsenal",
            strDescriptionEN: "Arsenal Football Club is a professional..",
            strCountry: "England",
            strTeamBadge: "https://www.thesportsdb.com/images/media/team/badge/uyhbfe1612467038.png",
            strTeamJersey: "https://www.thesportsdb.com/images/media/team/jersey/f8w08g1687181718.png",
            strTeamLogo: "https://www.thesportsdb.com/images/media/team/logo/q2mxlz1512644512.png",
            strTeamFanart1: "https://www.thesportsdb.com/images/media/team/fanart/xyusxr1419347566.jpg",
            strTeamFanart2: "https://www.thesportsdb.com/images/media/team/fanart/qttspr1419347612.jpg",
            strTeamFanart3: "https://www.thesportsdb.com/images/media/team/fanart/uwssqx1420884450.jpg",
            strTeamFanart4: "https://www.thesportsdb.com/images/media/team/fanart/qtprsw1420884964.jpg",
            strTeamBanner: "https://www.thesportsdb.com/images/media/team/banner/rtpsrr1419351049.jpg",
            strYoutube: "www.youtube.com/user/ArsenalTour")
    }
}
