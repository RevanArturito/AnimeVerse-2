//
//  AnimeVerseApp.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI

@main
struct AnimeVerseApp: App {
    init() {
        AppAssembly.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
