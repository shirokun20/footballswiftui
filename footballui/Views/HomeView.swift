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
    @State private var isToTeam = false
    @State private var selectedTeam: String?
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let content):
                TabView {
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
                                        Button(action: {
                                            selectedTeam = league.strLeague
                                            isToTeam.toggle()
                                        }) {
                                            LeagueView(league: league)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .fullScreenCover(isPresented: $isToTeam) {
                                            TeamView(nameLeague: $selectedTeam)
                                                .navigationBarTitle("", displayMode: .inline)
                                        }
                                    }
                                }
                                .refreshable {
                                    viewModel.getLeagues()
                                }
                            }
                        }.navigationTitle(Text("Leagues"))
                    }.tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    // Tab 3
                    Text("Comming Soon")
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Favorite")
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
    HomeView()
}
