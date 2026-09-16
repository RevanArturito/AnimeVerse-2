//
//  ToggleFavoriteUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public final class ToggleFavoriteUseCase: UseCase {
    public typealias RequestValue = Anime
    public typealias ResponseValue = Bool

    private let repository: AnimeRepositoryProtocol

    public init(repository: AnimeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(request: Anime) -> AnyPublisher<Bool, Error> {
        repository.toggleFavorite(anime: request)
    }
}
