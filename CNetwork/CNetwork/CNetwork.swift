//
//  CNetwork.swift
//  CNetwork
//
//  Created by Kurtuluş Ahmet TEMEL on 12.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import Foundation
import Alamofire
import KRProgressHUD

public final class CNetwork {
    public static let shared = CNetwork()
    
    public func execute<M: Codable>(requestRoute: CNetworkRouter, responseModel: M.Type, isLoaderActive: Bool = true, completion: @escaping (Swift.Result<M, CNetworkError>) -> Void) {
        
        if isLoaderActive {
            KRProgressHUD.show()
        }
        
        do {
            let urlRequest = try requestRoute.asURLRequest() //router için oluşturulmuş URLRequest
            Alamofire.request(urlRequest).validate().responseJSON { (response) in
                if response.result.isSuccess {
                    KRProgressHUD.dismiss()
                    do {
                        if let resultValue = response.result.value {
                            // START: Result Value Parse
                            let jsonData = try JSONSerialization.data(withJSONObject: resultValue, options: .prettyPrinted)
                            let jsonResults = try JSONDecoder().decode(responseModel, from: jsonData)
                            completion(.success(jsonResults))
                        }
                    } catch {
                        KRProgressHUD.dismiss()
                        completion(.failure(.parseError))
                    }
                } else {
                    KRProgressHUD.dismiss()
                    completion(.failure(.badRequestError))
                }
            }
        } catch {
            KRProgressHUD.dismiss()
            completion(.failure(.badUrlError))
        }
    }
}
