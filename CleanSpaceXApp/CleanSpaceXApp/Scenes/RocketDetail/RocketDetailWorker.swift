//
//  RocketDetailWorker.swift
//  CleanSpaceXApp
//
//  Created by Kurtuluş Ahmet TEMEL on 18.04.2020.
//  Copyright (c) 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CNetwork

class RocketDetailWorker {
    func fetchRocket(request: RocketDetail.FetchRocket.Request, completion: @escaping ((_ response: RocketsResponseModel?, _ error: CNetworkError?) -> Void)) {
        
        guard let rocketId = request.rocketId else {
            return
        }
        
        CNetwork.shared.execute(requestRoute: CNetworkRouter.rocket(rocketID: rocketId), responseModel: RocketsResponseModel.self) { result in
            switch result {
            case .success(let rocket):
                completion(rocket, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}