//
//  LeagueView.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import SwiftUI

struct LeagueView: View {
    let league: League
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(league.strLeague ?? "-")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                if (league.strLeagueAlternate != nil) {
                    if !league.strLeagueAlternate!.isEmpty {
                        Text(league.strLeagueAlternate!)
                            .foregroundColor(.blue)
                            .font(.system(size: 15))
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    }
                }
                Text(league.strSport ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LeagueView(league: League.dummyData)
        .previewLayout(.sizeThatFits)
}
