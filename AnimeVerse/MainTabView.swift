//
//  MainTabView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI
import HomeFeature
import FavoriteFeature
import AboutFeature
import Common

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("home.title".localized, systemImage: "house.fill") }

            FavoriteView()
                .tabItem { Label("favorite.title".localized, systemImage: "heart.fill") }

            AboutView(
                
            )
                .tabItem { Label("about.title".localized, systemImage: "info.circle.fill") }
        }
        .tint(.accentPink)
        .preferredColorScheme(.dark)
    }
}


