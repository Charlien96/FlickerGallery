//
//  FlickerGalleryTests.swift
//  FlickerGalleryTests
//
//  Created by Admin on 19/04/2022.
//

import XCTest
@testable import FlickerGallery

class FlickerGallaryTests: XCTestCase {

    var imageSearchInteractor: ImageSearchInteractor!
    var imageSearchViewController: ImageSearchViewController!

    override func setUpWithError() throws {
        
        imageSearchViewController =  SearchRouterInput().view(searchHubApi: FakeApiTask())
    }

 
    func testGetRepo_success() {
        
        let request = SearchRequest(searchedText:"search_responce_success")

        imageSearchViewController.presenter?.dependencies.interactor.fetchSearch(request: request)
        
        
        XCTAssertEqual(        imageSearchViewController.presenter!.entities!.count
, 100)
    }
    
    func testGetRepo_failure() {
     
        let request = SearchRequest(searchedText:"search_responce_failure")

        imageSearchViewController.presenter?.dependencies.interactor.fetchSearch(request: request)
        
        
        XCTAssertNil(       imageSearchViewController.presenter?.entities)
    }


}
