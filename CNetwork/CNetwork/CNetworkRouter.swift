//
//  CNetworkRouter.swift
//  CNetwork
//
//  Created by Kurtuluş Ahmet TEMEL on 12.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import Foundation
import Alamofire

public enum CNetworkRouter: URLRequestConvertible {
    case rockets
    case rocket(rocketID: String)
    
    // MARK: - HTTPMethod
    public var method: HTTPMethod {
        switch self {
        case .rockets, .rocket:
            return .get
        }
    }
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .rockets:
            return "/rockets"
        case .rocket(let id):
            return "/rockets/\(id)"
        }
    }
    
    // MARK: - Parameters
    public var parameters: Parameters? {
        switch self {
        case .rockets, .rocket:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
