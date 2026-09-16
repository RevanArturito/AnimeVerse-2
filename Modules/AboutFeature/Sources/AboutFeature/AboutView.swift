//
//  AboutView.swift
//  AnimeVerse
//
//  Created by Revan Arturito on 15/09/26.
//

import SwiftUI
import Common

public struct AboutView: View {
    @StateObject private var localization = LocalizationManager.shared
    @State private var showRestartAlert = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Image("profile_photo", bundle: .module)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.accentPink, lineWidth: 2.5))
                            .shadow(color: Color.accentPink.opacity(0.3), radius: 10, x: 0, y: 4)
                            .padding(.top, 16)
                        
                        Text("Cokorda Arturito Revan Putra Diarta")
                            .font(.heading(20))
                            .foregroundColor(.textPrimary)
                            .multilineTextAlignment(.center)
                        
                        Text("about.role".localized)
                            .font(.body(14))
                            .foregroundColor(.accentPink)
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 14) {
                        InfoRow(icon: "envelope.fill", text: "off.revan.arturito@gmail.com")
                        Divider().background(Color.bgPrimary)
                        InfoRow(icon: "graduationcap.fill", text: "dicoding.com/users/revanarturito/academies")
                    }
                    .padding(16)
                    .background(Color.bgCard)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 8) {
                            Image(systemName: "globe")
                                .foregroundColor(.accentPink)
                                .font(.system(size: 15, weight: .semibold))
                            Text("about.language_toggle".localized)
                                .font(.heading(15))
                                .foregroundColor(.textPrimary)
                            Spacer()
                        }
                        
                        HStack(spacing: 6) {
                            LanguageOptionButton(
                                title: "Bahasa Indonesia",
                                isSelected: localization.currentLanguage == "id"
                            ) {
                                if localization.currentLanguage != "id" {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                        localization.setLanguage("id")
                                        showRestartAlert = true
                                    }
                                }
                            }
                            
                            LanguageOptionButton(
                                title: "English",
                                isSelected: localization.currentLanguage == "en"
                            ) {
                                if localization.currentLanguage != "en" {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                        localization.setLanguage("en")
                                        showRestartAlert = true
                                    }
                                }
                            }
                        }
                        .padding(4)
                        .background(Color.bgPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(16)
                    .background(Color.bgCard)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
            .background(Color.bgPrimary.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("about.title".localized)
                        .font(.headline)
                }
            }
            .alert("about.restart_message".localized, isPresented: $showRestartAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .navigationViewStyle(.stack)
    }
}

private struct LanguageOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .textSecondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.accentPink : Color.clear)
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private struct InfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.accentPink)
                .frame(width: 22)
            Text(text)
                .font(.body(14))
                .foregroundColor(.textPrimary)
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }
}
