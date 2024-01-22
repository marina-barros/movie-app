//
//  FeaturedMoviesViewModelTests.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

import XCTest
@testable import MovieApp

final class FeaturedMoviesViewModelTests: XCTestCase {
    
    var sut: FeaturedMoviesViewModel?
    var service: FeaturedMoviesServiceProtocol?
    
    override func setUp() {
        self.service = FeaturedMoviesServiceMock()
        guard let service = service else { return }
        self.sut = FeaturedMoviesViewModel(service: service)
        super.setUp()
    }
    
    override func tearDown() {
        self.sut = nil
        self.service = nil
        super.tearDown()
    }

    func test_WhenGetPopularMoviesIsCalledAndReceivesSuccessFromPopularService_ShouldCallSuccessCompletion() throws {
        let sut = try XCTUnwrap(sut)
        guard let service = service as? FeaturedMoviesServiceMock else { return }
        service.success = true
        
        var successCalls = 0
        var failedCalls = 0
        var failedMessage = ""
        sut.successPopularMoviesFetch = {
            successCalls += 1
        }
        sut.failedPopularMoviesFetch = { message in
            failedCalls += 1
            failedMessage = message
        }
        
        sut.getPopularMovies()
        
        XCTAssertEqual(successCalls, 1)
        XCTAssertEqual(failedCalls, 0)
        XCTAssertEqual(failedMessage, "")
    }
    
    func test_WhenGetPopularMoviesIsCalledAndReceivesFailedFromPopularService_ShouldCallFailedCompletion() throws {
        let sut = try XCTUnwrap(sut)
        guard let service = service as? FeaturedMoviesServiceMock else { return }
        service.success = false
        
        var successCalls = 0
        var failedCalls = 0
        var failedMessage = ""
        sut.successPopularMoviesFetch = {
            successCalls += 1
        }
        sut.failedPopularMoviesFetch = { message in
            failedCalls += 1
            failedMessage = message
        }
        
        sut.getPopularMovies()
        
        XCTAssertEqual(successCalls, 0)
        XCTAssertEqual(failedCalls, 1)
        XCTAssertNotEqual(failedMessage, "")
    }

    func test_WhenGetNowPlayingMoviesIsCalledAndReceivesSuccessFromNowPlayingService_ShouldCallSuccessCompletion() throws {
        let sut = try XCTUnwrap(sut)
        guard let service = service as? FeaturedMoviesServiceMock else { return }
        service.success = true
        
        var successCalls = 0
        var failedCalls = 0
        var failedMessage = ""
        sut.successNowPlayingMoviesFetch = {
            successCalls += 1
        }
        sut.failedNowPlayingMoviesFetch = { message in
            failedCalls += 1
            failedMessage = message
        }
        
        sut.getNowPlayingMovies()
        
        XCTAssertEqual(successCalls, 1)
        XCTAssertEqual(failedCalls, 0)
        XCTAssertEqual(failedMessage, "")
    }
    
    func test_WhenGetNowPlayingMoviesIsCalledAndReceivesFailedFromNowPlayingService_ShouldCallFailedCompletion() throws {
        let sut = try XCTUnwrap(sut)
        guard let service = service as? FeaturedMoviesServiceMock else { return }
        service.success = false
        
        var successCalls = 0
        var failedCalls = 0
        var failedMessage = ""
        sut.successNowPlayingMoviesFetch = {
            successCalls += 1
        }
        sut.failedNowPlayingMoviesFetch = { message in
            failedCalls += 1
            failedMessage = message
        }
        
        sut.getNowPlayingMovies()
        
        XCTAssertEqual(successCalls, 0)
        XCTAssertEqual(failedCalls, 1)
        XCTAssertNotEqual(failedMessage, "")
    }
    
    func test_WhenExecutesGetNumberPopularMovies_ShouldReturnPopularMoviesAmount() throws {
        let sut = try XCTUnwrap(sut)
        sut.getPopularMovies()
        
        let number = sut.getNumberPopularMovies()
        XCTAssertEqual(number, 2)
    }
    
    func test_WhenExecutesGetNumberNowPlayingMovies_ShouldReturnNowPlayingMoviesAmount() throws {
        let sut = try XCTUnwrap(sut)
        sut.getNowPlayingMovies()
        
        let number = sut.getNumberNowPlayingMovies()
        XCTAssertEqual(number, 3)
    }
    
    func test_WhenExecutesGetMovieTitleAndIsPopular_ShouldReturnPopularMovie() throws {
        let sut = try XCTUnwrap(sut)
        sut.getPopularMovies()
        
        let title = sut.getMovieTitle(from: 0, isPopular: true)
        XCTAssertEqual(title, "Teste 1")
    }
    
    func test_WhenExecutesGetMovieTitleAndIsNotPopular_ShouldReturnNowPlayingMovieTitle() throws {
        let sut = try XCTUnwrap(sut)
        sut.getNowPlayingMovies()
        
        let title = sut.getMovieTitle(from: 1, isPopular: false)
        XCTAssertEqual(title, "Teste 4")
    }
    
    func test_WhenExecutesGetMoviePosterPathAndIsPopular_ShouldReturnPopularMovieBackdropPath() throws {
        let sut = try XCTUnwrap(sut)
        sut.getPopularMovies()
        
        let path = sut.getMoviePosterPath(from: 0, isPopular: true)
        XCTAssertEqual(path, "/backdropPathTeste1")
    }
    
    func test_WhenExecutesGetMoviePosterPathAndIsNotPopular_ShouldReturnNowPlayingMoviePosterPath() throws {
        let sut = try XCTUnwrap(sut)
        sut.getNowPlayingMovies()
        
        let path = sut.getMoviePosterPath(from: 1, isPopular: false)
        XCTAssertEqual(path, "/posterPathTeste4")
    }
    
    func test_WhenExecutesGetMovieRating_ShouldReturnMovieVotingAverage() throws {
        let sut = try XCTUnwrap(sut)
        sut.getNowPlayingMovies()
        
        let rating = sut.getMovieRating(from: 0)
        XCTAssertEqual(rating, String(9.0))
    }
    
    func test_WhenExecutesGetMovieDetail_ShouldReturnMovieDetailDTOWithPreparedInformation() throws {
        let sut = try XCTUnwrap(sut)
        sut.getPopularMovies()
        
        let dto = sut.getMovieDetail(from: 0, isPopular: true)
        let unwrappedDTO = try XCTUnwrap(dto)
        XCTAssertEqual(unwrappedDTO.title, "Teste 1")
        XCTAssertEqual(unwrappedDTO.rating, 10.0)
        XCTAssertEqual(unwrappedDTO.backdropPath, "/backdropPathTeste1")
        XCTAssertEqual(unwrappedDTO.posterPath, "/posterPathTeste1")
        XCTAssertEqual(unwrappedDTO.overview, "Teste, apenas um teste.")
    }
}
