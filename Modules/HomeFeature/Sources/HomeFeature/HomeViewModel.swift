//
//  HomeViewModel.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation
import Combine
import Core

public final class HomeViewModel: ObservableObject {
    @Published public var animeList: [Anime] = []
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    @Published public var searchText = ""

    public var filteredAnimeList: [Anime] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return animeList
        }
        return animeList.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    private let getAnimeListUseCase: GetAnimeListUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(getAnimeListUseCase: GetAnimeListUseCase = Container.shared.resolve()) {
        self.getAnimeListUseCase = getAnimeListUseCase
    }

    public func fetchAnimeList() {
        isLoading = true
        getAnimeListUseCase.execute(request: NoParams())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] list in
                self?.animeList = list
            }
            .store(in: &cancellables)
    }
}
