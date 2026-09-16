//
//  Container.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

public final class Container {
    public static let shared = Container()
    private var factories: [String: () -> Any] = [:]

    private init() {}

    public func register<Service>(_ type: Service.Type, factory: @escaping () -> Service) {
        factories[String(describing: type)] = factory
    }

    public func resolve<Service>(_ type: Service.Type = Service.self) -> Service {
        guard let factory = factories[String(describing: type)],
              let service = factory() as? Service else {
            fatalError("Service \(type) belum diregistrasi di Container")
        }
        return service
    }
}
