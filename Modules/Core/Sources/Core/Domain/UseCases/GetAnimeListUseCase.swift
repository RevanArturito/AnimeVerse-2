//
//  GetAnimeListUseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public final class GetAnimeListUseCase: UseCase {
    public typealias RequestValue = NoParams
    public typealias ResponseValue = [Anime]

    private let repository: AnimeRepositoryProtocol

    public init(repository: AnimeRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(request: NoParams) -> AnyPublisher<[Anime], Error> {
        repository.getAnimeList()
    }
}
