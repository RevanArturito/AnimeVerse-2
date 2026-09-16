//
//  FavoriteViewModelTests.swift
//  FavoriteFeature
//
//  Created by Revan Arturito on 16/09/26.
//

import XCTest
import Combine
@testable import FavoriteFeature
@testable import Core

final class FavoriteViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_fetchFavorites_populatesOnlyFavoritedAnime() {
        let stub = StubFavoriteRepository()
        stub.favorites = [
            Anime(id: 1, title: "Bleach", imageURL: "", synopsis: "", episodes: 366, score: 7.9, isFavorite: true)
        ]
        let sut = FavoriteViewModel(getFavoriteUseCase: GetFavoriteAnimeUseCase(repository: stub))

        let expectation = expectation(description: "favorites populated")
        sut.$favorites
            .dropFirst()
            .sink { list in
                XCTAssertEqual(list.count, 1)
                XCTAssertTrue(list.first?.isFavorite ?? false)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.fetchFavorites()

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchFavorites_whenEmpty_resultsInEmptyList() {
        let stub = StubFavoriteRepository()
        stub.favorites = []
        let sut = FavoriteViewModel(getFavoriteUseCase: GetFavoriteAnimeUseCase(repository: stub))

        let expectation = expectation(description: "empty favorites")
        sut.$favorites
            .dropFirst()
            .sink { list in
                XCTAssertTrue(list.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.fetchFavorites()

        wait(for: [expectation], timeout: 1)
    }
}

final class StubFavoriteRepository: AnimeRepositoryProtocol {
    var favorites: [Anime] = []

    func getAnimeList() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error> {
        Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
    }
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        Just(favorites).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
