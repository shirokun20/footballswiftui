//
//  FavoriteView.swift
//  footballui
//
//  Created by macbook on 01/11/23.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var vm = FavoriteViewModelImpl()
    var body: some View {
        Group {
            switch vm.state {
            case .loading:
                ProgressView()
            case .success(let content):
                VStack(alignment: .leading) {
                    VStack (alignment: .leading) {
                        Text("Favorite")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 4)
                            
                    }
                    .padding(.horizontal)
                    List {
                        ForEach(content) { team in
                            TeamCardView(team: team, isFavorite: true, onFavoriteTapped: {
                                
                            }, onUnFavoriteTapped: {
                                self.vm.removeFav(team: team)
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .refreshable {
                        self.vm.getFavorite()
                    }
                }
            case .empty:
                Text("No Favorite")
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight:  .infinity)
            }
        }.onAppear {
            self.vm.getFavorite()
        }
    }
}

#Preview {
    FavoriteView()
}
