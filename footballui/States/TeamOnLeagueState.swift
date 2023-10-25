//
//  TeamOnLeagueState.swift
//  footballui
//
//  Created by macbook on 17/10/23.
//

import Foundation


enum TeamOnLeagueState {
    case loading
    case success(content: [Team])
    case failed(error: Error)
}
