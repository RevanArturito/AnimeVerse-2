//
//  GetAnimeDetailUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public final class GetAnimeDetailUseCase: UseCase {
    public typealias RequestValue = Int
    public typealias ResponseValue = Anime

    private let repository: AnimeRepositoryProtocol

    public init(repository: AnimeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(request: Int) -> AnyPublisher<Anime, Error> {
        repository.getAnimeDetail(id: request)
    }
}
