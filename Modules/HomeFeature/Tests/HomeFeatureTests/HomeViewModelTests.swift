//
//  HomeViewModelTests.swift
//  HomeFeature
//
//  Created by Revan Arturito on 16/09/26.
//

import XCTest
import Combine
@testable import HomeFeature
@testable import Core

final class HomeViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_fetchAnimeList_success_updatesListAndStopsLoading() {
        let stub = StubAnimeRepository()
        stub.listResult = .success([
            Anime(id: 1, title: "Naruto", imageURL: "", synopsis: "", episodes: 220, score: 8.0)
        ])
        let sut = HomeViewModel(getAnimeListUseCase: GetAnimeListUseCase(repository: stub))

        let listExpectation = expectation(description: "list updated")
        let loadingStoppedExpectation = expectation(description: "loading stopped")

        sut.$animeList
            .dropFirst()
            .sink { list in
                XCTAssertEqual(list.count, 1)
                listExpectation.fulfill()
            }
            .store(in: &cancellables)

        sut.$isLoading
            .dropFirst() 
            .sink { isLoading in
                if isLoading == false {
                    loadingStoppedExpectation.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.fetchAnimeList()

        wait(for: [listExpectation, loadingStoppedExpectation], timeout: 1)
    }

    func test_fetchAnimeList_failure_setsErrorMessage() {
        let stub = StubAnimeRepository()
        stub.listResult = .failure(URLError(.notConnectedToInternet))
        let sut = HomeViewModel(getAnimeListUseCase: GetAnimeListUseCase(repository: stub))

        let expectation = expectation(description: "error set")
        sut.$errorMessage
            .dropFirst()
            .sink { message in
                XCTAssertNotNil(message)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.fetchAnimeList()

        wait(for: [expectation], timeout: 1)
    }
}

final class StubAnimeRepository: AnimeRepositoryProtocol {
    var listResult: Result<[Anime], Error> = .success([])
    var favoriteResult: Result<[Anime], Error> = .success([])

    func getAnimeList() -> AnyPublisher<[Anime], Error> {
        listResult.publisher.eraseToAnyPublisher()
    }
    func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error> {
        Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
    }
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        favoriteResult.publisher.eraseToAnyPublisher()
    }
    func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
