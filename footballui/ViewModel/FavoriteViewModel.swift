//
//  FavoriteViewModel.swift
//  footballui
//
//  Created by macbook on 01/11/23.
//

import Foundation
import Combine

protocol FavoriteViewModel {
    func getFavorite()
    func removeFav(team: Team)
}

class FavoriteViewModelImpl: ObservableObject, FavoriteViewModel {
    
    let service = LocalStorageService()
    private(set) var teams = [Team]()
    @Published private(set) var state: FavoriteState = .loading
    
    func getFavorite() {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let favoriteTeams = self.service.favoriteTeams
            
            // Setelah mendapatkan data, perbarui state dan teams
            if favoriteTeams.isEmpty {
                self.state = .empty
            } else {
                self.teams = favoriteTeams
                self.state = .success(data: favoriteTeams)
            }
        }
    }
    
    func removeFav(team: Team) {
        self.service.removeFavoriteTeam(team)
        getFavorite()
    }
}
