// filepath: /Users/administrador/Desktop/DopaSense/iOS/DopaSense/DopaSense/DopaSense/Shared/UI/Components/RadioButtonGroup.swift

import SwiftUI

/// Reusable radio button group using the app color palette (DSColor).
/// - `items`: array of string labels
/// - `selection`: optional binding to the selected label
/// - `axis`: layout axis (.vertical or .horizontal)
struct RadioButtonGroup: View {
    let items: [String]
    @Binding var selection: String?
    var axis: Axis = .vertical

    var body: some View {
        Group {
            if axis == .vertical {
                VStack(spacing: 12) {
                    ForEach(items, id: \.self) { item in
                        RadioButtonRow(label: item, isSelected: selection == item) {
                            selection = item
                        }
                    }
                }
            } else {
                HStack(spacing: 12) {
                    ForEach(items, id: \.self) { item in
                        RadioButtonRow(label: item, isSelected: selection == item) {
                            selection = item
                        }
                    }
                }
            }
        }
    }
}

private struct RadioButtonRow: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? DSColor.accentPrimary : Color(UIColor.systemGray4), lineWidth: isSelected ? 2 : 1)
                        .frame(width: 22, height: 22)

                    if isSelected {
                        Circle()
                            .fill(DSColor.accentPrimary)
                            .frame(width: 12, height: 12)
                    }
                }

                Text(label)
                    .foregroundColor(DSColor.textPrimary)
                    .font(.body)

                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#if DEBUG
struct RadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatefulPreviewWrapper(nil) { selection in
                RadioButtonGroup(items: ["18-24","25-34","35-44"], selection: selection)
                    .padding()
            }
            .preferredColorScheme(.light)

            StatefulPreviewWrapper("25-34") { selection in
                RadioButtonGroup(items: ["18-24","25-34","35-44"], selection: selection)
                    .padding()
            }
            .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}

// Small helper to provide binding in previews
private struct StatefulPreviewWrapper<Value: Equatable, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ initial: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initial)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
#endif
