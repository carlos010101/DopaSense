//
//  DSText+View.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

extension View {
    func dsText(_ style: DSTextStyle) -> some View {
        self.modifier(DSTextModifier(style: style))
    }
}

#Preview("Text Styles – Light") {
    VStack(alignment: .leading, spacing: 16) {
        Text("Insight del día")
            .dsText(.headline)

        Text("Hoy tu uso del teléfono fue más reactivo durante la tarde.")
            .dsText(.body)

        Text("Detectamos múltiples aperturas cortas entre apps.")
            .dsText(.secondary)

        Text("DopaSense no diagnostica ni reemplaza ayuda profesional.")
            .dsText(.microcopy)
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("Text Styles – Dark") {
    VStack(alignment: .leading, spacing: 16) {
        Text("Insight del día")
            .dsText(.headline)

        Text("Hoy tu uso del teléfono fue más reactivo durante la tarde.")
            .dsText(.body)

        Text("Detectamos múltiples aperturas cortas entre apps.")
            .dsText(.secondary)

        Text("DopaSense no diagnostica ni reemplaza ayuda profesional.")
            .dsText(.microcopy)
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}

