import SwiftUI

/// Reusable interests selection view that can be embedded in onboarding flow.
struct InterestsSelectionScreen: View {
    @Binding var selections: Set<String>
    var onBack: (() -> Void)? = nil
    var onContinue: ((Set<String>) -> Void)? = nil

    private let items: [(emoji: String, title: String)] = [
        ("📚", "Lectura"),
        ("🏃", "Deporte"),
        ("👨‍👩‍👧", "Familia"),
        ("❤️", "Pareja"),
        ("🧑‍🤝‍🧑", "Amigos"),
        ("🎨", "Creatividad"),
        ("💼", "Trabajo"),
        ("🌿", "Naturaleza"),
        ("🧘", "Meditación"),
        ("🛠️", "Aprender"),
        ("🧑‍🍳", "Cocinar")
    ]

    var body: some View {
        VStack(spacing: 16) {

            // Dynamic grid of items. No explicit checkmark; selected items grow in size and prominence.
            ScrollView(showsIndicators: true) {
                let columns: [GridItem] = [GridItem(.adaptive(minimum: 140), spacing: 12)]

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(items, id: \.title) { item in
                        let isSelected = selections.contains(item.title)

                        Button(action: { toggle(item.title) }) {
                            // Horizontal layout: TEXT (left) then EMOJI (right)
                            HStack(spacing: 12) {
                                Text(item.title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(isSelected ? .white : DSColor.textPrimary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)

                                Spacer()

                                Text(item.emoji)
                                    .font(.system(size: 24))
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            // Reduced fixed height and NO size change when selected
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(isSelected ? DSColor.accentPrimary : Color(UIColor.secondarySystemBackground))
                            )
                            .foregroundColor(isSelected ? .white : DSColor.textPrimary)
                         }
                         .buttonStyle(PlainButtonStyle())
                        .animation(.spring(response: 0.36, dampingFraction: 0.78, blendDuration: 0), value: selections)
                     }
                 }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }

            Spacer()

            // Bottom actions
            HStack(spacing: 12) {
                Button(action: { onBack?() }) {
                    Text("Atrás")
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(UIColor.systemGray4))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }

                Button(action: { onContinue?(selections) }) {
                    Text("Continuar")
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(selections.isEmpty ? Color.gray.opacity(0.4) : DSColor.accentPrimary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(selections.isEmpty)
            }
            .padding(16)
            .background(Color(UIColor.systemBackground))
        }
    }

    private func toggle(_ title: String) {
        withAnimation(.spring(response: 0.36, dampingFraction: 0.78)) {
            if selections.contains(title) { selections.remove(title) }
            else { selections.insert(title) }
        }
    }
}

// Preview using a constant binding
struct InterestsSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InterestsSelectionScreen(selections: .constant([]))
                .preferredColorScheme(.light)

            InterestsSelectionScreen(selections: .constant(["Lectura", "Deporte"]))
                .preferredColorScheme(.dark)
        }
    }
}
