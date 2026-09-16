//
//  AnimeRowView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI
import Core

public struct AnimeRowView: View {
    let anime: Anime
    
    public init(anime: Anime) {
        self.anime = anime
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: anime.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().aspectRatio(contentMode: .fill)
                case .failure:
                    Color.gray.opacity(0.2)
                default:
                    ProgressView()
                }
            }
            .frame(width: 72, height: 96)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(anime.title)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                
                if let score = anime.score {
                    Text(String(format: "%.1f", score))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.accentPink)
                        .clipShape(Capsule())
                }
                
                if let episodes = anime.episodes {
                    Text("\(episodes) \("episodes.label".localized)")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
            
            Spacer()
            
            ZStack {
                if anime.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.accentPink)
                        .accessibilityLabel("Favorite")
                        .frame(maxHeight: .infinity, alignment: .top)
                }
                
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.textSecondary)
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 24, height: 96)
        }
        .padding(12)
        .background(Color.bgCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .contentShape(Rectangle())
    }
}
