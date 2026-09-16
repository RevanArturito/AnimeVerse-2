//
//  UseCase.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import Combine

public protocol UseCase {
    associatedtype RequestValue
    associatedtype ResponseValue
    func execute(request: RequestValue) -> AnyPublisher<ResponseValue, Error>
}

public struct NoParams {
    public init() {}
}
