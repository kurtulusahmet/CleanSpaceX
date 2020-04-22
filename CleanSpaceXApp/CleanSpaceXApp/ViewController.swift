//
//  ViewController.swift
//  CleanSpaceXApp
//
//  Created by Kurtuluş Ahmet TEMEL on 12.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import UIKit
import CNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CNetwork.shared.execute(requestRoute: CNetworkRouter.rockets, responseModel: [RocketsResponseModel].self) { result in
            switch result {
            case .success(let rockets):
                print("\(rockets.count) rockets")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

