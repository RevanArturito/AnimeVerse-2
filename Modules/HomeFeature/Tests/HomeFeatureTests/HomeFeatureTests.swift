//
//  HomeFeatureTests.swift
//  HomeFeature
//
//  Created by Revan Arturito on 15/09/26.
//

import XCTest
import Combine
@testable import HomeFeature
@testable import Core

final class HomeFeatureTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_homeViewModel_initialState_isEmpty() {
        let sut = HomeViewModel(getAnimeListUseCase: GetAnimeListUseCase(repository: StubRepository()))
        XCTAssertTrue(sut.animeList.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.searchText, "")
        XCTAssertTrue(sut.filteredAnimeList.isEmpty)
    }

    func test_homeViewModel_filteredAnimeList_filtersByTitle() {
        let sut = HomeViewModel(getAnimeListUseCase: GetAnimeListUseCase(repository: StubRepository()))
        sut.animeList = [
            Anime(id: 1, title: "Naruto", imageURL: "", synopsis: "", episodes: 220, score: 8.0),
            Anime(id: 2, title: "One Piece", imageURL: "", synopsis: "", episodes: 1000, score: 9.0),
            Anime(id: 3, title: "Bleach", imageURL: "", synopsis: "", episodes: 366, score: 7.9)
        ]

        sut.searchText = "one"
        XCTAssertEqual(sut.filteredAnimeList.count, 1)
        XCTAssertEqual(sut.filteredAnimeList.first?.title, "One Piece")

        sut.searchText = ""
        XCTAssertEqual(sut.filteredAnimeList.count, 3)
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
