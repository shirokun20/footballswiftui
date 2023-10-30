//
//  TeamView.swift
//  footballui
//
//  Created by macbook on 19/10/23.
//

import SwiftUI

struct TeamView: View {
    
    @Binding var nameLeague: String?
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = TeamViewModelImpl(service: FootballServiceImpl())
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .success(let content):
                        VStack(alignment: .leading) {
                            if content.isEmpty {
                                Text("No leagues available.")
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight:  .infinity)
                            } else {
                                List {
                                    ForEach(content) { team in
                                        TeamCardView(team: team)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .refreshable {
                                    self.viewModel.getTeamByNl(nameLeague: "\(nameLeague ?? "")")
                                }
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                backButton
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                VStack (alignment: .leading) {
                                    Text("Teams From").font(.headline)
                                    Text("\(nameLeague ?? "Kosong")").font(.subheadline)
                                }
                            }
                        }
                case .failed(let error):
                    ErrorView(error: error) {
                        self.viewModel.getTeamByNl(nameLeague: "\(nameLeague ?? "")")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            print("yang di panggil \(nameLeague ?? "")")
            self.viewModel.getTeamByNl(nameLeague: "\(nameLeague ?? "")")
        }
    }
    
    private var backButton: some View {
        Button(action: {
                presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
            }
            .foregroundColor(.blue) // Customize the color
        }
    }
}

#Preview {
    TeamView(nameLeague: .constant("English Premier League"))
}
