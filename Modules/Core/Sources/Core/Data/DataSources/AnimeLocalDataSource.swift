//
//  AnimeLocalDataSource.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation

public final class AnimeLocalDataSource {
    private let key = "favorite_anime_list"
    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public func getFavorites() -> [Anime] {
        guard let data = defaults.data(forKey: key),
              let list = try? JSONDecoder().decode([Anime].self, from: data) else { return [] }
        return list
    }

    public func isFavorite(id: Int) -> Bool {
        getFavorites().contains { $0.id == id }
    }

    @discardableResult
    public func toggleFavorite(_ anime: Anime) -> Bool {
        var list = getFavorites()
        if let idx = list.firstIndex(where: { $0.id == anime.id }) {
            list.remove(at: idx)
        } else {
            var fav = anime
            fav.isFavorite = true
            list.append(fav)
        }
        if let data = try? JSONEncoder().encode(list) {
            defaults.set(data, forKey: key)
        }
        return list.contains { $0.id == anime.id }
    }
}
