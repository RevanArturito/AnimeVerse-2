//
//  FavoriteViewModel.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation
import Combine
import Core

public final class FavoriteViewModel: ObservableObject {
    @Published public var favorites: [Anime] = []

    private let getFavoriteUseCase: GetFavoriteAnimeUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(getFavoriteUseCase: GetFavoriteAnimeUseCase = Container.shared.resolve()) {
        self.getFavoriteUseCase = getFavoriteUseCase
    }

    public func fetchFavorites() {
        getFavoriteUseCase.execute(request: NoParams())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] list in
                self?.favorites = list
            })
            .store(in: &cancellables)
    }
}
