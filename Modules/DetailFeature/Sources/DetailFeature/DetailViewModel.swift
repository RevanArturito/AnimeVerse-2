//
//  DetailViewModel.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation
import Combine
import Core

public final class DetailViewModel: ObservableObject {
    @Published public var detail: Anime?
    @Published public var isLoading = false
    @Published public var errorMessage: String?

    private let animeId: Int
    private let getDetailUseCase: GetAnimeDetailUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(
        animeId: Int,
        getDetailUseCase: GetAnimeDetailUseCase = Container.shared.resolve(),
        toggleFavoriteUseCase: ToggleFavoriteUseCase = Container.shared.resolve()
    ) {
        self.animeId = animeId
        self.getDetailUseCase = getDetailUseCase
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
    }

    public func onAppear() {
        guard detail == nil else { return }
        isLoading = true
        getDetailUseCase.execute(request: animeId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] anime in
                self?.detail = anime
            }
            .store(in: &cancellables)
    }

    public func toggleFavorite() {
        guard let detail else { return }
        toggleFavoriteUseCase.execute(request: detail)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] isFav in
                self?.detail?.isFavorite = isFav
            }
            .store(in: &cancellables)
    }
}
