//
//  RocketsViewController.swift
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
import Kingfisher

protocol RocketsDisplayLogic: class {
    func displayFetchedRockets(viewModel: Rockets.FetchRockets.ViewModel)
    func displayRocketDetail()
}

class RocketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RocketsDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: RocketsBusinessLogic?
    var router: (NSObjectProtocol & RocketsRoutingLogic & RocketsDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RocketsInteractor()
        let presenter = RocketsPresenter()
        let router = RocketsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRockets()
    }
    
    // MARK: Fetch rockets
    
    var displayedRockets: [Rockets.FetchRockets.ViewModel.DisplayedRocket] = []
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func fetchRockets() {
        let request = Rockets.FetchRockets.Request()
        interactor?.fetchRockets(request: request)
    }
    
    func displayFetchedRockets(viewModel: Rockets.FetchRockets.ViewModel) {
        displayedRockets = viewModel.displayedRockets
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    // MARK: Display Rocket Detail

    func displayRocketDetail() {
        router?.routeToRocketDetail(segue: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedRockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedRocket = displayedRockets[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RocketTableViewCell") as? RocketTableViewCell else {
            return UITableViewCell()
        }
        
        cell.rocketName.text = displayedRocket.rocketName
        cell.rocketImageView.kf.setImage(with: URL(string: displayedRocket.rocketImage))
        cell.rocketDescription.text = displayedRocket.rocketDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayRocketDetail()
    }
}