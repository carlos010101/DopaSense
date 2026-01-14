//
//  DSTextModifier.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

struct DSTextModifier: ViewModifier {
    let style: DSTextStyle

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
            .lineSpacing(lineSpacing)
            .multilineTextAlignment(.leading)
    }

    private var font: Font {
        switch style {
        case .headline:
            return .system(size: 28, weight: .bold)
        case .body:
            return .system(size: 17)
        case .secondary:
            return .system(size: 15)
        case .microcopy:
            return .system(size: 12)
        }
    }

    private var color: Color {
        switch style {
        case .headline, .body:
            return DSColor.textPrimary
        case .secondary, .microcopy:
            return DSColor.textSecondary
        }
    }

    private var lineSpacing: CGFloat {
        switch style {
        case .headline: return 4
        case .body: return 6
        case .secondary: return 4
        case .microcopy: return 2
        }
    }
}
