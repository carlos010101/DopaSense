// filepath: /Users/administrador/Desktop/DopaSense/iOS/DopaSense/DopaSense/DopaSense/Shared/UI/Components/DSInlineLink.swift
//
//  DSInlineLink.swift
//  DopaSense
//
//  Created by Copilot on 1/19/26.
//

import SwiftUI

struct DSInlineLink: View {
    let leadingText: String
    let linkText: String
    let action: () -> Void
    var font: Font = .system(size: 14)
    var leadingColor: Color = DSColor.textSecondary
    var linkColor: Color = DSColor.accentSecondary

    var body: some View {
        HStack(spacing: 4) {
            Text(leadingText)
                .font(font)
                .foregroundStyle(leadingColor)

            Button(action: action) {
                Text(linkText)
                    .font(font)
                    .foregroundStyle(linkColor)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview("Light") {
    DSInlineLink(leadingText: "¿Ya tienes una cuenta?", linkText: "Inicia sesión") { }
        .padding()
        .background(DSColor.backgroundPrimary)
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    DSInlineLink(leadingText: "¿Ya tienes una cuenta?", linkText: "Inicia sesión") { }
        .padding()
        .background(DSColor.backgroundPrimary)
}
