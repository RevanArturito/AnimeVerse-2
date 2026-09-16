//
//  Anime.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation

public struct Anime: Identifiable, Equatable, Codable {
    public let id: Int
    public let title: String
    public let imageURL: String
    public let synopsis: String
    public let episodes: Int?
    public let score: Double?
    public let status: String
    public let genres: [String]
    public var isFavorite: Bool

    public init(
        id: Int,
        title: String,
        imageURL: String,
        synopsis: String,
        episodes: Int?,
        score: Double?,
        status: String = "-",
        genres: [String] = [],
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.synopsis = synopsis
        self.episodes = episodes
        self.score = score
        self.status = status
        self.genres = genres
        self.isFavorite = isFavorite
    }

    public var imageUrl: String { imageURL }
}
