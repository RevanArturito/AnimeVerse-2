//
//  AnimeRepositoryProtocol.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public protocol AnimeRepositoryProtocol {
    func getAnimeList() -> AnyPublisher<[Anime], Error>
    func getAnimeDetail(id: Int) -> AnyPublisher<Anime, Error>
    func getFavoriteAnime() -> AnyPublisher<[Anime], Error>
    func toggleFavorite(anime: Anime) -> AnyPublisher<Bool, Error>
}
