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
            if let imageUrl = URL(string: team.strTeamBadge ?? ""),
               imageUrl.isValidURL() {
                URLImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 50, height: 50)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
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

extension URL {
    func isValidURL() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
