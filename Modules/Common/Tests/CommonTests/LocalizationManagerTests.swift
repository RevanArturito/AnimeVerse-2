//
//  LocalizationManagerTests.swift
//  Common
//
//  Created by Revan Arturito on 16/09/26.
//

import XCTest
@testable import Common

final class LocalizationManagerTests: XCTestCase {
    func test_setLanguage_updatesCurrentLanguageAndPersists() {
        let manager = LocalizationManager.shared
        manager.setLanguage("id")
        XCTAssertEqual(manager.currentLanguage, "id")

        manager.setLanguage("en")
        XCTAssertEqual(manager.currentLanguage, "en")
    }

    func test_localizedString_returnsNonEmptyForKnownKey() {
        LocalizationManager.shared.setLanguage("en")
        let result = "home.title".localized
        XCTAssertFalse(result.isEmpty)
        XCTAssertNotEqual(result, "home.title") 
    }
}
