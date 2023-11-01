//
//  SearchBarView.swift
//  footballui
//
//  Created by macbook on 27/09/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var onSearchButtonTapped: () -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .keyboardType(.default)
                .padding(.horizontal, 4)
                .onChange(of: text) { oldState, newState in
                    if text.isEmpty {
                        onSearchButtonTapped()
                    }
                }
                .onSubmit {
                    onSearchButtonTapped()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                onSearchButtonTapped()
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
            }
        }
        .padding(.bottom, 8)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(text: .constant(""), onSearchButtonTapped: {
        
    })
}
