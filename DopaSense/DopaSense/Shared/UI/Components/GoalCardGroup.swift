// filepath: Shared/UI/Components/GoalCardGroup.swift

import SwiftUI

/// Card-based single-selection component for onboarding goals.
/// Use DSColor for app colors.
struct GoalCardGroup: View {
    struct GoalOption: Identifiable, Hashable {
        let id = UUID()
        let key: String
        let title: String
        let description: String
    }

    let items: [GoalOption]
    @Binding var selection: String? // selected key

    var body: some View {
        VStack(spacing: 12) {
            ForEach(items) { item in
                GoalCard(option: item, isSelected: selection == item.key)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selection = item.key
                        }
                    }
            }
        }
    }
}

private struct GoalCard: View {
    let option: GoalCardGroup.GoalOption
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(option.title)
                    .font(.headline)
                    .foregroundColor(DSColor.textPrimary)

                Text(option.description)
                    .font(.subheadline)
                    .foregroundColor(DSColor.textSecondary)
            }

            Spacer()

            ZStack {
                Circle()
                    .stroke(isSelected ? DSColor.accentPrimary : Color(UIColor.systemGray4), lineWidth: isSelected ? 2 : 1)
                    .frame(width: 28, height: 28)

                if isSelected {
                    Circle()
                        .fill(DSColor.accentPrimary)
                        .frame(width: 14, height: 14)
                }
            }
            .padding(.top, 4)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? DSColor.surfaceCard.opacity(0.95) : Color(UIColor.secondarySystemBackground))
                .shadow(color: isSelected ? DSColor.accentPrimary.opacity(0.12) : Color.clear, radius: 6, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? DSColor.accentPrimary : Color.clear, lineWidth: isSelected ? 1.5 : 0)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(option.title + ", " + option.description)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#if DEBUG
struct GoalCardGroup_Previews: PreviewProvider {
    static let items = [
        GoalCardGroup.GoalOption(key: "menos_redes", title: "Menos redes", description: "Reduce el tiempo en redes y gana más calma y presencia en tu día."),
        GoalCardGroup.GoalOption(key: "productividad", title: "Mayor productividad", description: "Menos distracciones, más enfoque para lo que realmente importa."),
        GoalCardGroup.GoalOption(key: "mejor_sueno", title: "Mejorar sueño", description: "Descansa mejor dejando el teléfono a un lado por las noches."),
        GoalCardGroup.GoalOption(key: "uso_consciente", title: "Uso más consciente", description: "Entiende tu uso del teléfono y crea hábitos más equilibrados.")
    ]

    static var previews: some View {
        StatefulPreviewWrapper(nil) { binding in
            GoalCardGroup(items: items, selection: binding)
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

// small helper for previews
private struct StatefulPreviewWrapper<Value: Equatable, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ initial: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initial)
        self.content = content
    }

    var body: some View { content($value) }
}
#endif
