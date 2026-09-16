//
//  AnimeRepository.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public final class AnimeRepository: AnimeRepositoryProtocol {
    private let remote: AnimeRemoteDataSource
    private let local: AnimeLocalDataSource

    public init(remote: AnimeRemoteDataSource, local: AnimeLocalDataSource) {
        self.remote = remote
        self.local = local
    }

    public func getAnimeList() -> AnyPublisher<[Anime], Error> {
        remote.fetchAnimeList()
            .map { [local] dtos in
                dtos.map { $0.toDomain(isFavorite: local.isFavorite(id: $0.mal_id)) }
            }
            .eraseToAnyPublisher()
    }

    public func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error> {
        remote.fetchAnimeDetail(id: id)
            .map { [local] dto in dto.toDomain(isFavorite: local.isFavorite(id: dto.mal_id)) }
            .eraseToAnyPublisher()
    }

    public func getFavoriteAnime() -> AnyPublisher<[Anime], Error> {
        Just(local.getFavorites())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error> {
        let result = local.toggleFavorite(anime)
        return Just(result)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
