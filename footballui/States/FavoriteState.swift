//
//  FavoriteState.swift
//  footballui
//
//  Created by macbook on 01/11/23.
//

import Foundation

enum FavoriteState {
    case loading
    case success(data: [Team])
    case empty
}
