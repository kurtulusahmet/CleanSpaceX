//
//  Constants.swift
//  CNetwork
//
//  Created by Kurtuluş Ahmet TEMEL on 12.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import Foundation

struct Constants {
    static let baseUrl = "https://api.spacexdata.com/v3"
}

//The header fields
enum HttpHeaderField: String {
    case contentType = "Content-Type"
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json"
}
