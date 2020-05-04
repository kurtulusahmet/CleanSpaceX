//
//  RocketsInteractor.swift
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

protocol RocketsBusinessLogic {
    func fetchRockets(request: Rockets.FetchRockets.Request)
}

protocol RocketsDataStore {
    var rockets: [RocketsResponseModel]? { get }
}

class RocketsInteractor: RocketsBusinessLogic, RocketsDataStore {
    var rockets: [RocketsResponseModel]?
    
    var presenter: RocketsPresentationLogic?
    var worker = RocketsWorker(rocketStore: RocketsAPI())
    
    // MARK: Fetch Rockets
    func fetchRockets(request: Rockets.FetchRockets.Request) {
        worker.fetchRockets(completion: { (rockets, error) in
            if error != nil {
                //TODO: Bu kısımda hata mesajını ekranda göstermek için Clean Swift döngüsü çalıştırabilirsiniz.
            } else {
                self.rockets = rockets
                let response = Rockets.FetchRockets.Response(rockets: rockets)
                self.presenter?.presentRockets(response: response)
            }
        })
    }
}
