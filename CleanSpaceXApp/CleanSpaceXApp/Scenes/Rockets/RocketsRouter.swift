//
//  RocketsRouter.swift
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

@objc protocol RocketsRoutingLogic {
    func routeToRocketDetail(segue: UIStoryboardSegue?)
}

protocol RocketsDataPassing {
    var dataStore: RocketsDataStore? { get }
}

class RocketsRouter: NSObject, RocketsRoutingLogic, RocketsDataPassing {
    
    weak var viewController: RocketsViewController?
    var dataStore: RocketsDataStore?
    
    // MARK: Routing
    
    func routeToRocketDetail(segue: UIStoryboardSegue?) {
        if let segue = segue {
          let destinationVC = segue.destination as! RocketDetailViewController
          var destinationDS = destinationVC.router!.dataStore!
          passDataToRocketDetail(source: dataStore!, destination: &destinationDS)
        } else {
          let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "RocketDetailViewController") as! RocketDetailViewController
          var destinationDS = destinationVC.router!.dataStore!
          passDataToRocketDetail(source: dataStore!, destination: &destinationDS)
          navigateToRocketDetail(source: viewController!, destination: destinationVC)
        }
    }
    
    func navigateToRocketDetail(source: RocketsViewController, destination: RocketDetailViewController) {
      source.show(destination, sender: nil)
    }
    
    func passDataToRocketDetail(source: RocketsDataStore, destination: inout RocketDetailDataStore) {
      let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
      destination.rocket = source.rockets?[selectedRow!]
    }
}
