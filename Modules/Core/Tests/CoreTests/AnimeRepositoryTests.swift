//
//  AnimeRepositoryTests.swift
//  Core
//
//  Created by Revan Arturito on 16/09/26.
//

import XCTest
import Combine
@testable import Core

final class AnimeRepositoryTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        UserDefaults(suiteName: #file)?.removePersistentDomain(forName: #file)
        cancellables.removeAll()
        super.tearDown()
    }

    private func makeLocalDataSource(_ testName: String = #function) -> AnimeLocalDataSource {
        let suite = UserDefaults(suiteName: testName)!
        suite.removePersistentDomain(forName: testName) // pastikan bersih sebelum test mulai
        return AnimeLocalDataSource(defaults: suite)
    }

    func test_getAnimeList_marksFavoriteFromLocal() {
        let local = makeLocalDataSource()
        let favAnime = Anime(id: 1, title: "One Piece", imageURL: "", synopsis: "", episodes: 1000, score: 9.0)
        local.toggleFavorite(favAnime)

        let toggleUseCase = ToggleFavoriteUseCase(repository: AnimeRepository(
            remote: AnimeRemoteDataSource(),
            local: local
        ))

        let expectation = expectation(description: "favorite toggled reflects in local")
        var result = false
        toggleUseCase.execute(request: favAnime)
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                result = value
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(result)
    }

    func test_localDataSource_toggleFavorite_addsAndRemoves() {
        let local = makeLocalDataSource()
        let anime = Anime(id: 42, title: "Bleach", imageURL: "", synopsis: "", episodes: 366, score: 7.9)

        XCTAssertFalse(local.isFavorite(id: 42))

        let addedResult = local.toggleFavorite(anime)
        XCTAssertTrue(addedResult)
        XCTAssertTrue(local.isFavorite(id: 42))

        let removedResult = local.toggleFavorite(anime)
        XCTAssertFalse(removedResult)
        XCTAssertFalse(local.isFavorite(id: 42))
    }

    func test_getFavoriteAnime_returnsOnlyFavorited() {
        let local = makeLocalDataSource()
        let anime1 = Anime(id: 1, title: "Naruto", imageURL: "", synopsis: "", episodes: 220, score: 8.0)
        local.toggleFavorite(anime1)

        let repo = AnimeRepository(remote: AnimeRemoteDataSource(), local: local)
        let useCase = GetFavoriteAnimeUseCase(repository: repo)

        let expectation = expectation(description: "favorites fetched")
        var result: [Anime] = []
        useCase.execute(request: NoParams())
            .sink(receiveCompletion: { _ in }, receiveValue: { list in
                result = list
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 1)
    }
}
