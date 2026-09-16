//
//  LocalizationManager.swift
//  Common
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation

public final class LocalizationManager: ObservableObject {
    public static let shared = LocalizationManager()

    private static let storageKey = "app_language"

    @Published public var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: Self.storageKey)
        }
    }

    private init() {
        let systemLanguage: String
        if #available(iOS 16, *) {
            systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        } else {
            systemLanguage = Locale.current.languageCode ?? "en"
        }
        currentLanguage = UserDefaults.standard.string(forKey: Self.storageKey) ?? systemLanguage
    }

    public func setLanguage(_ code: String) {
        currentLanguage = code
    }

    public var bundle: Bundle {
        guard let path = Bundle.module.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return Bundle.module
        }
        return bundle
    }
}
