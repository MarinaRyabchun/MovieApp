//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Марина Рябчун on 04.06.2023.
//

import XCTest
@testable import MovieApp

final class MovieAppTests: XCTestCase {
    
    private var sut: SearchViewModel!
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_getting_movies_success() {
        let result = Result<SearchResponse, APIError>.success(SearchResponse.mockModel())
        sut = SearchViewModel(service: APIMockService(result: result))
        
        XCTAssertTrue(sut.users.value != nil)
    }
    
    
    func test_loading_error() {
        
        let errorMessage = "Sorry, something went wrong."
        let result = Result<SearchResponse, APIError>.failure(APIError.badURL)
        sut = SearchViewModel(service: APIMockService(result: result))
        
        XCTAssertThrowsError(try result.get()) { error in
            let apiError = error as! APIError
            XCTAssertEqual(apiError.localizedDescription, errorMessage)
        }
    }
}
