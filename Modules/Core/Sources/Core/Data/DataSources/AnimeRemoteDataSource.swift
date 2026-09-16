//
//  AnimeRemoteDataSource.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation
import Combine

public final class AnimeRemoteDataSource {
    private let baseURL = "https://api.jikan.moe/v4"

    public init() {}

    public func fetchAnimeList() -> AnyPublisher<[AnimeDTO], Error> {
        let url = URL(string: "\(baseURL)/top/anime")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AnimeListResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public func fetchAnimeDetail(id: Int) -> AnyPublisher<AnimeDTO, Error> {
        let url = URL(string: "\(baseURL)/anime/\(id)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AnimeDetailResponse.self, decoder: JSONDecoder())
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
