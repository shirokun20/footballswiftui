//
//  TeamCardView.swift
//  footballui
//
//  Created by macbook on 19/10/23.
//

import SwiftUI
import URLImage
struct TeamCardView: View {
    let team: Team
    @State private var isFavorite = false
    var body: some View {
        HStack {
            URLImage(url: URL(string: team.strTeamBadge ?? "https://www.iconpacks.net/icons/4/free-no-image-icon-14596-thumb.png")!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 4) {
                Text(team.strTeam ?? "-")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Text(team.strAlternate ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Text(team.strStadium ?? "N/A")
                    .foregroundColor(.blue)
                    .font(.footnote)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .gray)
                .font(.system(size: 20))
                .onTapGesture {
                    self.isFavorite.toggle()
                }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout)  {
    TeamCardView(team: Team.dummyData)
        .previewLayout(.sizeThatFits)
}
