//
//  TeamCardView.swift
//  footballui
//
//  Created by macbook on 19/10/23.
//

import SwiftUI

struct TeamCardView: View {
    let team: Team
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(team.strTeam ?? "-")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Text(team.strAlternate ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout)  {
    TeamCardView(team: Team.dummyData)
        .previewLayout(.sizeThatFits)
}
