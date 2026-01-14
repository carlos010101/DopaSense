//
//  DSTextButton.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

struct DSTextButton: View {
    let title: String
    let action: () -> Void
    var isDisabled: Bool = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(
                    isDisabled
                    ? DSColor.textSecondary.opacity(0.5)
                    : DSColor.accentSecondary
                )
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1)
        .animation(.easeOut(duration: 0.15), value: isDisabled)
    }
}


#Preview("Light") {
    VStack(spacing: 20) {
        DSTextButton(title: "Omitir") {}
        DSTextButton(title: "Más tarde") {}
        DSTextButton(title: "Desactivado", action:  {}, isDisabled: true)
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 20) {
        DSTextButton(title: "Omitir") {}
        DSTextButton(title: "Más tarde") {}
        DSTextButton(title: "Desactivado", action:  {}, isDisabled: true)
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}
