//
//  DSCard.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import SwiftUI

struct DSCard<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.surfaceCard)
                    .shadow(
                        color: Color.black.opacity(0.05),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
    }
}

#Preview("DSCard • Light") {
    DSCard {
        VStack(alignment: .leading, spacing: 8) {
            Text("Título de la Card")
                .font(.headline)
                .foregroundColor(DSColor.textPrimary)

            Text("Este es un texto de ejemplo para probar la card en modo light.")
                .font(.subheadline)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding()
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("DSCard • Dark") {
    DSCard {
        VStack(alignment: .leading, spacing: 8) {
            Text("Título de la Card")
                .font(.headline)
                .foregroundColor(DSColor.textPrimary)

            Text("Este es un texto de ejemplo para probar la card en modo dark.")
                .font(.subheadline)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding()
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}
