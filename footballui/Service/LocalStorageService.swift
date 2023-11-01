//
//  LocalStorageService.swift
//  footballui
//
//  Created by macbook on 31/10/23.
//

import Foundation


class LocalStorageService {
    private let favoriteTeamsKey = "FavoriteTeams"
    private let userDefaults = UserDefaults.standard
    
    public init() {}

    var favoriteTeams: [Team] {
        get {
            if let data = userDefaults.data(forKey: favoriteTeamsKey) {
                do {
                    let teams = try JSONDecoder().decode([Team].self, from: data)
                    return teams
                } catch {
                    print("Error decoding favorite teams: \(error)")
                }
            }
            return []
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: favoriteTeamsKey)
            } catch {
                print("Error encoding favorite teams: \(error)")
            }
        }
    }
    
    func setFavoriteTeam(_ newFavoriteTeam: Team) {
        var updatedFavoriteTeams = favoriteTeams
        
        if updatedFavoriteTeams.isEmpty {
            print("Teams Was Empty")
            favoriteTeams = [newFavoriteTeam]
        } else {
            if updatedFavoriteTeams.contains(where: { $0.idTeam == newFavoriteTeam.idTeam }) {
                print("Team is already a favorite.")
                return
            } else {
                updatedFavoriteTeams.append(newFavoriteTeam)
                
                // Update the favorite teams
                favoriteTeams = updatedFavoriteTeams
            }
        }
        
        // Add the new favorite team
        
    }
    
    func removeFavoriteTeam(_ teamToRemove: Team) {
        var updatedFavoriteTeams = favoriteTeams
        if let index = updatedFavoriteTeams.firstIndex(where: { $0.idTeam == teamToRemove.idTeam }) {
            updatedFavoriteTeams.remove(at: index)
            favoriteTeams = updatedFavoriteTeams
        }
    }

    func clearUserData() {
        userDefaults.removeObject(forKey: favoriteTeamsKey)
    }
}



// Set favorite teams array
//let team1 = Team(idTeam: "1", strTeam: "Team A", strTeamShort: "TA", strAlternate: "Alt Team A", intFormedYear: "2000", strSport: "Football", strStadium: "Stadium A", strStadiumThumb: "StadiumThumbA", strStadiumDescription: "Stadium A Desc", strStadiumLocation: "Location A", intStadiumCapacity: "50000", strWebsite: "www.teamA.com", strFacebook: "fbTeamA", strTwitter: "twitterTeamA", strInstagram: "instaTeamA", strDescriptionEN: "Description A", strCountry: "Country A", strTeamBadge: "BadgeA", strTeamJersey: "JerseyA", strTeamLogo: "LogoA", strTeamFanart1: "Fanart1A", strTeamFanart2: "Fanart2A", strTeamFanart3: "Fanart3A", strTeamFanart4: "Fanart4A", strTeamBanner: "BannerA", strYoutube: "youtubeA")
//let team2 = Team(idTeam: "2", strTeam: "Team B", strTeamShort: "TB", strAlternate: "Alt Team B", intFormedYear: "2005", strSport: "Soccer", strStadium: "Stadium B", strStadiumThumb: "StadiumThumbB", strStadiumDescription: "Stadium B Desc", strStadiumLocation: "Location B", intStadiumCapacity: "60000", strWebsite: "www.teamB.com", strFacebook: "fbTeamB", strTwitter: "twitterTeamB", strInstagram: "instaTeamB", strDescriptionEN: "Description B", strCountry: "Country B", strTeamBadge: "BadgeB", strTeamJersey: "JerseyB", strTeamLogo: "LogoB", strTeamFanart1: "Fanart1B", strTeamFanart2: "Fanart2B", strTeamFanart3: "Fanart3B", strTeamFanart4: "Fanart4B", strTeamBanner: "BannerB", strYoutube: "youtubeB")

//let newFavoriteTeams = [team1, team2]
//LocalStorageService.shared.favoriteTeams = newFavoriteTeams

// Retrieve favorite teams array
//let retrievedFavoriteTeams = LocalStorageService.shared.favoriteTeams
//print("Favorite Teams: \(retrievedFavoriteTeams)")

// Clear user data
//LocalStorageService.shared.clearUserData()
