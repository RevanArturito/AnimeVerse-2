//
//  FavoriteView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI
import Core
import Common
import DetailFeature

public struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()

    public init() {}

    public var body: some View {
        NavigationView {
            Group {
                if viewModel.favorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text("favorite.empty".localized)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.favorites) { anime in
                        ZStack {
                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(animeId: anime.id))) {
                                EmptyView()
                            }
                            .opacity(0)

                            AnimeRowView(anime: anime)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("favorite.title".localized)
                        .font(.headline)
                }
            }
            .onAppear { viewModel.fetchFavorites() }
        }
    }
}
