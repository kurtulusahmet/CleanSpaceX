//
//  CNetworkError.swift
//  CNetwork
//
//  Created by Kurtuluş Ahmet TEMEL on 13.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import Foundation

public enum CNetworkError: Error {
    case parseError
    case badUrlError
    case badRequestError
}
