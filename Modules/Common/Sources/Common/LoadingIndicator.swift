//
//  LoadingIndicator.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI

public struct LoadingIndicator: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .scaleEffect(1.2)
            Text("loading".localized)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
