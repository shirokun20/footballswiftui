//
//  HomeView.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel = FootballViewModelImpl(service: FootballServiceImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let content):
                NavigationView {
                    VStack(alignment: .leading) {
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
                                    NavigationLink(destination: {
                                        TeamView(nameLeague: .constant(league.strLeague ?? ""))
                                    }) {
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
                    .navigationTitle(Text("Leagues"))
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
    HomeView()
}
