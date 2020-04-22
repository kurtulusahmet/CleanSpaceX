//
//  RocketsResponseModel.swift
//  CleanSpotifyApp
//
//  Created by Kurtuluş Ahmet TEMEL on 13.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import Foundation

// MARK: - RocketsResponseModel
struct RocketsResponseModel: Codable {
    let id: Int
    let active: Bool
    let stages, boosters: Int

    enum CodingKeys: String, CodingKey {
        case id, active, stages, boosters
    }
    
    typealias Response = [RocketsResponseModel]
}
