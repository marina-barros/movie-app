//
//  MovieDetailViewModelTests.swift
//  MovieApp
//
//  Created by Marina Barros on 22/01/24.
//

import XCTest
@testable import MovieApp

class MovieDetailViewModelTests: XCTestCase {
    
    var sut : MovieDetailViewModel?
    
    override func setUp() {
        sut = MovieDetailViewModel(movie: MovieDetailTestHelper.dto)
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_WhenGettingFormattedRatingVariable_ShouldReturnFormattedValue() throws {
        let sut = try XCTUnwrap(sut)
        
        let rating = sut.formattedRating
        XCTAssertEqual(rating, "★9.2/10")
    }
    
    func test_WhenGettingSmallPosterPath_ShouldReturnUnformattedValueEqualToDTOPosterPath() throws {
        let sut = try XCTUnwrap(sut)
        
        let smallPosterPath = sut.smallPosterPath
        XCTAssertEqual(smallPosterPath, MovieDetailTestHelper.dto.posterPath)
    }
    
    func test_WhenGettingBiggerPosterPath_ShouldReturnUnformattedValueEqualToDTOBackdropPath() throws {
        let sut = try XCTUnwrap(sut)
        
        let biggerPosterPath = sut.biggerPosterPath
        XCTAssertEqual(biggerPosterPath, MovieDetailTestHelper.dto.backdropPath)
    }
    
    func test_WhenGettingTitle_ShouldReturnUnformattedValueEqualToDTOTitle() throws {
        let sut = try XCTUnwrap(sut)
        
        let title = sut.title
        XCTAssertEqual(title, MovieDetailTestHelper.dto.title)
    }
    
    func test_WhenGettingOverviewDescription_ShouldReturnUnformattedValueEqualToDTOOverview() throws {
        let sut = try XCTUnwrap(sut)
        
        let overviewDescription = sut.overviewDescription
        XCTAssertEqual(overviewDescription, MovieDetailTestHelper.dto.overview)
    }
}
