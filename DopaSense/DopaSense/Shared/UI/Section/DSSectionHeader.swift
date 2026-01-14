//
//  DSSectionHeader.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

struct DSSectionHeader: View {

    let title: String
    let subtitle: String?

    init(
        title: String,
        subtitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .dsText(.headline)

            if let subtitle {
                Text(subtitle)
                    .dsText(.secondary)
            }
        }
        .padding(.horizontal, 4)
    }
}

#Preview("Light") {
    VStack(alignment: .leading, spacing: 24) {
        DSSectionHeader(
            title: "Insight del día",
            subtitle: "Patrones detectados en tu uso"
        )

        DSSectionHeader(
            title: "Tu progreso"
        )
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(alignment: .leading, spacing: 24) {
        DSSectionHeader(
            title: "Insight del día",
            subtitle: "Patrones detectados en tu uso"
        )

        DSSectionHeader(
            title: "Tu progreso"
        )
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}

