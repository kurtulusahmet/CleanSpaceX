//
//  RocketsResponseModel.swift
//  CleanSpaceXApp
//
//  Created by Kurtuluş Ahmet TEMEL on 13.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import Foundation

// MARK: - RocketsResponseModel
struct RocketsResponseModel: Codable {
    let id: Int
    let flickrImages: [String]
    let wikipedia: String
    let rocketDescription, rocketID, rocketName, rocketType: String

    enum CodingKeys: String, CodingKey {
        case id
        case flickrImages = "flickr_images"
        case wikipedia
        case rocketDescription = "description"
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}
