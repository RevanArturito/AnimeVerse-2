//
//  String+Localized.swift
//  Common
//
//  Created by Revan Arturito on 15/09/26.
//

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, bundle: LocalizationManager.shared.bundle, comment: "")
    }
}
