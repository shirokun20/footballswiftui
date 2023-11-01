//
//  LeaguesView.swift
//  footballui
//
//  Created by macbook on 01/11/23.
//

import SwiftUI

struct LeaguesView: View {
    @StateObject var viewModel = FootballViewModelImpl(service: FootballServiceImpl())
    @State private var isToTeam = false
    @State private var selectedTeam: String?
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let content):
                VStack(alignment: .leading) {
                    VStack (alignment: .leading) {
                        Text("Leagues")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 4)
                            
                    }
                    .padding(.horizontal)
                    SearchBarView(text: $viewModel.searchText, onSearchButtonTapped: {
                        viewModel.onSubmitSearch()
                    })
                    .padding(.horizontal)
                    if content.isEmpty {
                        Text("No leagues available.")
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight:  .infinity)
                    } else {
                        List {
                            ForEach(content) { league in
                                NavigationLink(destination: TeamView(nameLeague: .constant(league.strLeague ?? ""))
                                    .navigationBarTitle("", displayMode: .inline)) {
                                        LeagueView(league: league)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        .refreshable {
                            viewModel.getLeagues()
                        }
                    }
                }
            case .failed(let error):
                ErrorView(error: error) {
                    self.viewModel.getLeagues()
                }
            }
        }
        .onAppear {
            self.viewModel.getLeagues()
        }
    }
}

#Preview {
    LeaguesView()
}
