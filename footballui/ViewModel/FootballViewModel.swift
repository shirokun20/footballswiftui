//
//  FootballViewModel.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import Foundation
import Combine

protocol FootballViewModel {
    func getLeagues()
    func onSubmitSearch()
    var filteredLeagues: [League] { get }
    var searchText: String { get set }
}

class FootballViewModelImpl: ObservableObject, FootballViewModel {
    
    private let service: FootballService
    private(set) var leagues = [League]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: FootballState = .loading
    @Published private(set) var filteredLeagues = [League]()
    @Published var searchText = ""
    
    init(service: FootballService) {
        self.service = service
    }
    
    func getLeagues() {
        self.state = .loading
        let cancellable = service
            .getAllLeagues(from: .getAllLeagues)
            .sink { [weak self] res in
                guard let self = self else { return }
                switch res {
                case .finished:
                    let dataLeagues = self.leagues.filter { item in
                        return item.strSport?.lowercased().contains("soccer") == true
                    }
                    self.state = .success(content: dataLeagues)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                let dataLeagues = response.leagues.filter { item in
                    return item.strSport?.lowercased().contains("soccer") == true
                }
                self.leagues = dataLeagues
            }
        self.cancellables.insert(cancellable)
    }
    
    func onSubmitSearch() {
        if searchText.isEmpty {
            filteredLeagues = leagues
        } else {
            // Filter the leagues based on the search text
            filteredLeagues = leagues.filter { league in
                return league.strLeague!.lowercased().contains(searchText.lowercased()) ||  league.strSport!.contains(searchText.lowercased())
            }
        }
        self.state = .success(content: filteredLeagues)
    }
}
