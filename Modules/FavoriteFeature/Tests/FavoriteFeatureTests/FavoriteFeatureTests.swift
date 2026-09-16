//
//  FavoriteFeatureTests.swift
//  FavoriteFeature
//
//  Created by Revan Arturito on 15/09/26.
//

import XCTest
import Combine
@testable import FavoriteFeature
@testable import Core

final class FavoriteFeatureTests: XCTestCase {
    func test_favoriteViewModel_initialState_isEmpty() {
        let sut = FavoriteViewModel(getFavoriteUseCase: GetFavoriteAnimeUseCase(repository: StubRepository()))
        XCTAssertTrue(sut.favorites.isEmpty)
    }
}

private final class StubRepository: AnimeRepositoryProtocol {
    func getAnimeList() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error> {
        Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
    }
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
