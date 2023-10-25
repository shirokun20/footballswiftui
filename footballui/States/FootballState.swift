//
//  FootballState.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import Foundation

enum FootballState {
    case loading
    case success(content: [League])
    case failed(error: Error)
}
