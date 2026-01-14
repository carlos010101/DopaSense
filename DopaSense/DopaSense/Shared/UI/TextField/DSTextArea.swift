//
//  DSTextArea.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

struct DSTextArea: View {

    let placeholder: String
    @Binding var text: String
    let minHeight: CGFloat

    init(
        _ placeholder: String,
        text: Binding<String>,
        minHeight: CGFloat = 120
    ) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
    }

    var body: some View {
        ZStack(alignment: .topLeading) {

            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 16))
                    .foregroundStyle(DSColor.textSecondary)
                    .padding(.top, 16)
                    .padding(.horizontal, 18)
            }

            TextEditor(text: $text)
                .font(.system(size: 16))
                .foregroundStyle(DSColor.textPrimary)
                .padding(12)
                .frame(minHeight: minHeight)
                .background(Color.clear)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(DSColor.backgroundSecondary)
        )
    }
}

#Preview("Light") {
    VStack(spacing: 16) {
        DSTextArea(
            "Escribe cómo te has sentido hoy con el uso de tu teléfono…",
            text: .constant("")
        )

        DSTextArea(
            "Reflexión",
            text: .constant("Cuando estoy cansado por la noche, termino usando redes sin pensar."),
            minHeight: 160
        )
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 16) {
        DSTextArea(
            "Escribe cómo te has sentido hoy con el uso de tu teléfono…",
            text: .constant("")
        )

        DSTextArea(
            "Reflexión",
            text: .constant("Cuando estoy cansado por la noche, termino usando redes sin pensar."),
            minHeight: 160
        )
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}
