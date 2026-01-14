//
//  DSButton.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import SwiftUI

struct DSButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.body, design: .rounded).weight(.semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
        }
        .background(DSColor.accentPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview("Light") {
    VStack(spacing: 16) {
        DSButton(title: "Primary Action") { }
        DSButton(title: "Disabled") { }
            .disabled(true)
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 16) {
        DSButton(title: "Primary Action") { }
        DSButton(title: "Disabled") { }
            .disabled(true)
    }
    .padding()
    .background(DSColor.backgroundPrimary)
    .preferredColorScheme(.dark)
}

