//
//  CoreAssembly.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

public enum CoreAssembly {
    public static func register() {
        Container.shared.register(AnimeRepositoryProtocol.self) {
            AnimeRepository(remote: AnimeRemoteDataSource(), local: AnimeLocalDataSource())
        }
        Container.shared.register(GetAnimeListUseCase.self) {
            GetAnimeListUseCase(repository: Container.shared.resolve(AnimeRepositoryProtocol.self))
        }
        Container.shared.register(GetAnimeDetailUseCase.self) {
            GetAnimeDetailUseCase(repository: Container.shared.resolve(AnimeRepositoryProtocol.self))
        }
        Container.shared.register(GetFavoriteAnimeUseCase.self) {
            GetFavoriteAnimeUseCase(repository: Container.shared.resolve(AnimeRepositoryProtocol.self))
        }
        Container.shared.register(ToggleFavoriteUseCase.self) {
            ToggleFavoriteUseCase(repository: Container.shared.resolve(AnimeRepositoryProtocol.self))
        }
    }
}
