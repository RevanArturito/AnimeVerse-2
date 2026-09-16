//
//  HomeView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI
import Core
import Common
import DetailFeature

public struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @ObservedObject private var localization = LocalizationManager.shared
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    LoadingIndicator()
                } else {
                    List(viewModel.filteredAnimeList) { anime in
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
                    .overlay {
                        if viewModel.filteredAnimeList.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .font(.largeTitle)
                                    .foregroundColor(.secondary)
                                Text("search.empty".localized)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("home.title".localized)
                        .font(.headline)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "search.placeholder".localized)
            .onAppear {
                if viewModel.animeList.isEmpty { viewModel.fetchAnimeList() }
            }
        }
    }
}
