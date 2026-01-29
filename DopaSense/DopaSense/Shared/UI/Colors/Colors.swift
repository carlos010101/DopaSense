//
//  Colors.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import Foundation
import SwiftUI

enum DSColor {
    // Colors that exist in Assets.xcassets
    static let accentColor = Color("AccentColor")
    static let accentPrimary = Color("AccentPrimary")
    static let accentSecondary = Color("AccentSecondary")

    static let backgroundPrimary = Color("BackgroundPrimary")
    static let backgroundSecondary = Color("BackgroundSecondary")

    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let surfaceCard = Color("SurfaceCard")
}


// MARK: - Colors Preview
#if DEBUG
private struct DSColorSwatchRow: View {
    let name: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 56, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.separator), lineWidth: 0.5)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(.body, design: .default))
                    .foregroundColor(.primary)
                Text("Asset: \(name)")
                    .font(.system(.caption, design: .default))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
    }
}

private struct DSColorsPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Group {
                    DSColorSwatchRow(name: "AccentColor", color: DSColor.accentColor)
                    DSColorSwatchRow(name: "AccentPrimary", color: DSColor.accentPrimary)
                    DSColorSwatchRow(name: "AccentSecondary", color: DSColor.accentSecondary)
                }
                Divider()
                Group {
                    DSColorSwatchRow(name: "BackgroundPrimary", color: DSColor.backgroundPrimary)
                    DSColorSwatchRow(name: "BackgroundSecondary", color: DSColor.backgroundSecondary)
                }
                Divider()
                Group {
                    DSColorSwatchRow(name: "TextPrimary", color: DSColor.textPrimary)
                    DSColorSwatchRow(name: "TextSecondary", color: DSColor.textSecondary)
                    DSColorSwatchRow(name: "SurfaceCard", color: DSColor.surfaceCard)
                }
            }
            .padding(16)
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct DSColorsPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DSColorsPreview()
                .previewDisplayName("Light")
                .preferredColorScheme(.light)

            DSColorsPreview()
                .previewDisplayName("Dark")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
