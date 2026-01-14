//
//  DSTextField.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

struct DSTextField: View {

    let placeholder: String
    @Binding var text: String

    init(
        _ placeholder: String,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self._text = text
    }

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 16))
            .foregroundStyle(DSColor.textPrimary)
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(DSColor.backgroundSecondary)
            )
    }
}

#Preview("Light") {
    VStack(spacing: 16) {
        DSTextField(
            "¿Qué quieres mejorar?",
            text: .constant("")
        )

        DSTextField(
            "Escribe una nota corta",
            text: .constant("Uso redes cuando estoy cansado")
        )
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 16) {
        DSTextField(
            "¿Qué quieres mejorar?",
            text: .constant("")
        )

        DSTextField(
            "Escribe una nota corta",
            text: .constant("Uso redes cuando estoy cansado")
        )
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}

