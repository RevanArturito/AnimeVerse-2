//
//  DetailViewModelTests.swift
//  DetailFeature
//
//  Created by Revan Arturito on 16/09/26.
//

import XCTest
import Combine
@testable import DetailFeature
@testable import Core

final class DetailViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_onAppear_success_populatesDetail() {
        let stub = StubDetailRepository()
        stub.detail = Anime(id: 10, title: "Death Note", imageURL: "", synopsis: "Thriller", episodes: 37, score: 9.0)

        let sut = DetailViewModel(
            animeId: 10,
            getDetailUseCase: GetAnimeDetailUseCase(repository: stub),
            toggleFavoriteUseCase: ToggleFavoriteUseCase(repository: stub)
        )

        let detailExpectation = expectation(description: "detail loaded")
        let loadingStoppedExpectation = expectation(description: "loading stopped")

        sut.$detail
            .dropFirst()
            .sink { detail in
                XCTAssertEqual(detail?.title, "Death Note")
                detailExpectation.fulfill()
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

        sut.onAppear()

        wait(for: [detailExpectation, loadingStoppedExpectation], timeout: 1)
    }

    func test_toggleFavorite_updatesIsFavoriteOnDetail() {
        let stub = StubDetailRepository()
        stub.detail = Anime(id: 10, title: "Death Note", imageURL: "", synopsis: "", episodes: 37, score: 9.0, isFavorite: false)
        stub.toggleResult = true

        let sut = DetailViewModel(
            animeId: 10,
            getDetailUseCase: GetAnimeDetailUseCase(repository: stub),
            toggleFavoriteUseCase: ToggleFavoriteUseCase(repository: stub)
        )

        let loadExpectation = expectation(description: "detail loaded before toggle")
        sut.$detail
            .dropFirst()
            .first()
            .sink { _ in loadExpectation.fulfill() }
            .store(in: &cancellables)
        sut.onAppear()
        wait(for: [loadExpectation], timeout: 1)

        let toggleExpectation = expectation(description: "favorite toggled")
        sut.$detail
            .dropFirst()
            .sink { detail in
                XCTAssertTrue(detail?.isFavorite ?? false)
                toggleExpectation.fulfill()
            }
            .store(in: &cancellables)

        sut.toggleFavorite()

        wait(for: [toggleExpectation], timeout: 1)
    }
}

final class StubDetailRepository: AnimeRepositoryProtocol {
    var detail: Anime?
    var toggleResult = true

    func getAnimeList() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error> {
        guard let detail else { return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher() }
        return Just(detail).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error> {
        Just(toggleResult).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
