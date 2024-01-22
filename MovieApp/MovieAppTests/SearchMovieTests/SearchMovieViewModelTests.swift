//
//  SearchMovieViewModelTests.swift
//  MovieApp
//
//  Created by Marina Barros on 22/01/24.
//

import XCTest
@testable import MovieApp

final class SearchMovieViewModelTests: XCTestCase {
    var sut: SearchMovieViewModel?
    var service: SearchMovieServiceProtocol?
    
    override func setUp() {
        self.service = SearchMovieServiceMock()
        guard let service = service else { return }
        self.sut = SearchMovieViewModel(service: service)
        super.setUp()
    }
    
    override func tearDown() {
        self.sut = nil
        self.service = nil
        super.tearDown()
    }
    
    func test_WhenFetchSearchedMoviesIsCalledAndReceivesSuccessFromService_ShouldCallSuccessCompletion() throws {
        let sut = try XCTUnwrap(sut)
        guard let service = service as? SearchMovieServiceMock else { return }
        service.success = true
        
        var successCalls = 0
        var failedCalls = 0
        var failedMessage = ""
        sut.successSearchMovies = {
            successCalls += 1
        }
        sut.failedSearchMovies = { message in
            failedCalls += 1
            failedMessage = message
        }
        
        sut.fetchSearchedMovies(query: "Barbie")
        
        XCTAssertEqual(successCalls, 1)
        XCTAssertEqual(failedCalls, 0)
        XCTAssertEqual(failedMessage, "")
    }
    
    func test_WhenFetchSearchedMoviesIsCalledAndReceivesFailedFromService_ShouldCallFailedCompletion() throws {
        let sut = try XCTUnwrap(sut)
        guard let service = service as? SearchMovieServiceMock else { return }
        service.success = false
        
        var successCalls = 0
        var failedCalls = 0
        var failedMessage = ""
        sut.successSearchMovies = {
            successCalls += 1
        }
        sut.failedSearchMovies = { message in
            failedCalls += 1
            failedMessage = message
        }
        
        sut.fetchSearchedMovies(query: "Barbie")
        
        XCTAssertEqual(successCalls, 0)
        XCTAssertEqual(failedCalls, 1)
        XCTAssertNotEqual(failedMessage, "")
    }
    
    func test_WhenMovieCountIsCalled_ShouldReturnListMovieCountFromSearchResults() throws {
        let sut = try XCTUnwrap(sut)
        
        sut.fetchSearchedMovies(query: "Barbie")
        
        let amount = sut.movieCount
        XCTAssertEqual(amount, 5)
    }
    
    func test_WhenGetMovieNameFromIndexIsCalled_ShouldReturnMovieTitleAtIndexFromSearchResults() throws {
        let sut = try XCTUnwrap(sut)
        
        sut.fetchSearchedMovies(query: "Barbie")
        
        let name = sut.getMovieName(from: 0)
        XCTAssertEqual(name, "Teste 1")
    }
    
    func test_WhenGetMovieDetailFromIndexIsCalled_ShouldReturnMovieDetailDTOAtIndexFromMovieList() throws {
        let sut = try XCTUnwrap(sut)
        
        sut.fetchSearchedMovies(query: "Barbie")
        
        let dto = sut.getMovieDetail(from: 2)
        XCTAssertEqual(dto, MovieDetailDTO(title: "Teste 3",
                                           posterPath: "/posterPathTeste3",
                                           backdropPath: "/backdropPathTeste3",
                                           rating: 9.023,
                                           overview: "Teste versão infantil."))
    }
}
