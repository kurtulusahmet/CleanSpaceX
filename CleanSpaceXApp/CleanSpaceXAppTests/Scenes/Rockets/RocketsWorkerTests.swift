//
//  RocketsWorkerTests.swift
//  CleanSpaceXAppTests
//
//  Created by Kurtuluş Ahmet TEMEL on 1.05.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

@testable import CleanSpaceXApp
import XCTest
import CNetwork

class RocketsWorkerTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: RocketsWorker!
    static var testRockets: [RocketsResponseModel]!
    
    override func setUp() {
        super.setUp()
        setupOrdersWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupOrdersWorker() {
        sut = RocketsWorker(rocketStore: RocketsAPISpy())
        
        RocketsWorkerTests.testRockets = [RocketsResponseModel(id: 1,
                                                               flickrImages: ["https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2009_-_01_liftoff_south_full_wide_ro8a1280_edit.jpg?itok=8loiSGt1"],
                                                               wikipedia: "https://en.wikipedia.org/wiki/Falcon_1",
                                                               rocketDescription: "This is Falcon 1",
                                                               rocketID: "falcon1", rocketName: "Falcon 1", rocketType: "rocket"),
                                          RocketsResponseModel(id: 2,
                                                               flickrImages: ["https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2009_-_01_liftoff_south_full_wide_ro8a1280_edit.jpg?itok=8loiSGt1"],
                                                               wikipedia: "https://en.wikipedia.org/wiki/Falcon_2",
                                                               rocketDescription: "This is Falcon 2",
                                                               rocketID: "falcon2", rocketName: "Falcon 2", rocketType: "rocket")]
    }
    
    class RocketsAPISpy: RocketsAPI {
        // MARK: Method call expectations
        var fetchRocketsCalled = false
        var fetchRocketCalled = false
        
        override func fetchRockets(completion: @escaping (([RocketsResponseModel], CNetworkError?) -> Void)) {
            fetchRocketsCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
              completion(RocketsWorkerTests.testRockets, nil)
            }
        }
    }
    
    // MARK: - Tests
    func testFetchOrdersShouldReturnListOfOrders()
    {
        // Given
        let rocketsAPISpy = sut.rocketStore as! RocketsAPISpy
        
        // When
        var fetchedRockets = [RocketsResponseModel]()
        let expect = expectation(description: "Wait for fetchRockets() to return")
        sut.fetchRockets { (rockets, error) in
            fetchedRockets = rockets
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.1)
        
        // Then
        XCTAssert(rocketsAPISpy.fetchRocketsCalled, "Calling fetchRockets() should ask the data store for a list of rockets")
        XCTAssertEqual(fetchedRockets.count, RocketsWorkerTests.testRockets.count, "fetchRockets() should return a list of rockets")
        for (index, rocket) in fetchedRockets.enumerated() {
            XCTAssert(RocketsWorkerTests.testRockets[index].rocketName.elementsEqual(rocket.rocketName), "Fetched rockets should match the orders in the data store")
        }
    }
}
