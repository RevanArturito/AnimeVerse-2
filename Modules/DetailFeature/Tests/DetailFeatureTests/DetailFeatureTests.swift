//
//  DetailFeatureTests.swift
//  DetailFeature
//
//  Created by Revan Arturito on 15/09/26.
//

import XCTest
import Combine
@testable import DetailFeature
@testable import Core

final class DetailFeatureTests: XCTestCase {
    func test_detailViewModel_initialState_hasNoAnime() {
        let sut = DetailViewModel(
            animeId: 1,
            getDetailUseCase: GetAnimeDetailUseCase(repository: StubRepository()),
            toggleFavoriteUseCase: ToggleFavoriteUseCase(repository: StubRepository())
        )
        XCTAssertNil(sut.detail)
    }
}

private final class StubRepository: AnimeRepositoryProtocol {
    func getAnimeList() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error> {
        Just(Anime(id: id, title: "Test", imageURL: "", synopsis: "", episodes: 12, score: 8.0))
            .setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
