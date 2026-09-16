//
//  AnimeDTO.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation

public struct AnimeListResponse: Decodable {
    public let data: [AnimeDTO]
}

public struct AnimeDetailResponse: Decodable {
    public let data: AnimeDTO
}

public struct AnimeDTO: Decodable {
    public let mal_id: Int
    public let title: String
    public let synopsis: String?
    public let episodes: Int?
    public let score: Double?
    public let status: String?
    public let genres: [GenreDTO]?
    public let images: ImagesDTO

    public struct GenreDTO: Decodable {
        public let name: String
    }

    public struct ImagesDTO: Decodable {
        public let jpg: JPGDTO
        public struct JPGDTO: Decodable {
            public let image_url: String
        }
    }

    public func toDomain(isFavorite: Bool = false) -> Anime {
        Anime(
            id: mal_id,
            title: title,
            imageURL: images.jpg.image_url,
            synopsis: synopsis ?? "-",
            episodes: episodes,
            score: score,
            status: status ?? "-",
            genres: genres?.map(\.name) ?? [],
            isFavorite: isFavorite
        )
    }
}
