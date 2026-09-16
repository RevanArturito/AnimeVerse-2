//
//  AnimeDTOTests.swift
//  Core
//
//  Created by Revan Arturito on 16/09/26.
//

import XCTest
@testable import Core

final class AnimeDTOTests: XCTestCase {
    func test_toDomain_mapsFieldsCorrectly() {
        let dto = AnimeDTO(
            mal_id: 1,
            title: "Attack on Titan",
            synopsis: "Humanity fights titans",
            episodes: 25,
            score: 8.5,
            status: "Finished Airing",
            genres: [.init(name: "Action"), .init(name: "Drama")],
            images: .init(jpg: .init(image_url: "https://example.com/image.jpg"))
        )

        let anime = dto.toDomain(isFavorite: true)

        XCTAssertEqual(anime.id, 1)
        XCTAssertEqual(anime.title, "Attack on Titan")
        XCTAssertEqual(anime.genres, ["Action", "Drama"])
        XCTAssertEqual(anime.status, "Finished Airing")
        XCTAssertTrue(anime.isFavorite)
    }

    func test_toDomain_handlesNilSynopsisWithDefault() {
        let dto = AnimeDTO(
            mal_id: 2,
            title: "Unknown Anime",
            synopsis: nil,
            episodes: nil,
            score: nil,
            status: nil,
            genres: nil,
            images: .init(jpg: .init(image_url: ""))
        )

        let anime = dto.toDomain()

        XCTAssertEqual(anime.synopsis, "-")
        XCTAssertEqual(anime.status, "-")
        XCTAssertTrue(anime.genres.isEmpty)
    }
}
