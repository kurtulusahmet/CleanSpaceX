//
//  RocketsViewControllerTests.swift
//  CleanSpaceXApp
//
//  Created by Kurtuluş Ahmet TEMEL on 30.04.2020.
//  Copyright (c) 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CleanSpaceXApp
import XCTest

class RocketsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: RocketsViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupRocketsViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRocketsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "RocketsViewController") as? RocketsViewController
        sut.loadViewIfNeeded()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class RocketsBusinessLogicSpy: RocketsBusinessLogic {
        var fetchRocketsCalled = false
        func fetchRockets(request: Rockets.FetchRockets.Request) {
            fetchRocketsCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        // MARK: Method call expectations
        var reloadDataCalled = false
        
        // MARK: Spied methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldFetchRocketsWhenViewDidAppear() {
        // Given
        let listRocketsBusinessLogicSpy = RocketsBusinessLogicSpy()
        sut.interactor = listRocketsBusinessLogicSpy
        loadView()
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(listRocketsBusinessLogicSpy.fetchRocketsCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func testShouldDisplayFetchedOrders() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        // When
        let displayedRockets = [Rockets.FetchRockets.ViewModel.DisplayedRocket(rocketId: "falcon1",
                                                                               rocketName: "Falcon 1",
                                                                               rocketDescription: "This is Falcon 1",
                                                                               rocketImage: "https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2009_-_02_default_liftoff_west_full_wide_nn6p2062_xl.jpg?itok=p776nHsM")]
        let viewModel = Rockets.FetchRockets.ViewModel(displayedRockets: displayedRockets)
        sut.displayFetchedRockets(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched orders should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne()
    {
        // Given
        
        // When
        let numberOfSections = sut.numberOfSections(in: sut.tableView)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySectionShouldEqaulNumberOfOrdersToDisplay() {
        // Given
        let testDisplayedRockets = [Rockets.FetchRockets.ViewModel.DisplayedRocket(rocketId: "falcon1",
                                                                                   rocketName: "Falcon 1",
                                                                                   rocketDescription: "This is Falcon 1",
                                                                                   rocketImage: "https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2009_-_02_default_liftoff_west_full_wide_nn6p2062_xl.jpg?itok=p776nHsM")]
        sut.displayedRockets = testDisplayedRockets
        
        // When
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedRockets.count, "The number of table view rows should equal the number of rockets to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayRockets() {
        // Given
        let testDisplayedRockets = [Rockets.FetchRockets.ViewModel.DisplayedRocket(rocketId: "falcon1",
                                                                                   rocketName: "Falcon 1",
                                                                                   rocketDescription: "This is Falcon 1",
                                                                                   rocketImage: "https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2009_-_02_default_liftoff_west_full_wide_nn6p2062_xl.jpg?itok=p776nHsM")]
        let viewModel = Rockets.FetchRockets.ViewModel(displayedRockets: testDisplayedRockets)
        sut.displayFetchedRockets(viewModel: viewModel)

        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath) as? RocketTableViewCell

        // Then
        XCTAssertEqual(cell?.rocketName?.text, "Falcon 1", "A properly configured table view cell should display the rocket name")
        XCTAssertEqual(cell?.rocketDescription?.text, "This is Falcon 1", "A properly configured table view cell should display the rocket description")
    }
    
}