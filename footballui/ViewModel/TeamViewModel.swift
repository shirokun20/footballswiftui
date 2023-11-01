//
//  TeamViewModel.swift
//  footballui
//
//  Created by macbook on 19/10/23.
//

import Foundation
import Combine

protocol TeamViewModel {
    func getTeamByNl(nameLeague: String)
    func setFavorite(team: Team)
    func rmFavorite(team: Team)
    func isFavorite(team: Team) -> Bool
}

class TeamViewModelImpl: ObservableObject, TeamViewModel {
   
    private let service: FootballService
    let lsService = LocalStorageService()
    private(set) var teams = [Team]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: TeamOnLeagueState = .loading
    
    init(service: FootballService) {
        self.service = service
    }
    
    func getTeamByNl(nameLeague: String) {
        self.state = .loading
        let cancellable = service
            .getTeamsByLeagues(from: .getTeamOnLeague(leagueName: nameLeague))
            .sink { [weak self] res in
                guard let self = self else { return }
                switch res {
                case .finished:
                    self.state = .success(content: self.teams)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.teams = response.teams
            }
        self.cancellables.insert(cancellable)
    }
    
    func setFavorite(team: Team) {
        self.lsService.setFavoriteTeam(team)
        self.state = .success(content: self.teams)
    }
    
    func rmFavorite(team: Team) {
        self.lsService.removeFavoriteTeam(team)
        self.state = .success(content: self.teams)
    }
    
    func isFavorite(team: Team) -> Bool {
        return self.lsService.favoriteTeams.contains(where: { $0.idTeam == team.idTeam })
    }
}
