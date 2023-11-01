//
//  HomeView.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import SwiftUI
import Combine

struct HomeView: View {
    var body: some View {
        NavigationView {
            TabView {
                VStack(alignment: .leading) {
                    LeaguesView()
                }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(0)
                VStack (alignment: .leading) {
                    FavoriteView()
                }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorite")
                    }
                    .tag(1)
            }
        }
    }
}


#Preview {
    HomeView()
}
