//
//  AppAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Core
import HomeFeature
import DetailFeature
import FavoriteFeature

enum AppAssembly {
    static func registerAll() {
        CoreAssembly.register()
        HomeAssembly.register()
        DetailAssembly.register()
        FavoriteAssembly.register()
    }
}
