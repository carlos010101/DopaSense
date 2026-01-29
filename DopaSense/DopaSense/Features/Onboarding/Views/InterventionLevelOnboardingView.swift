// filepath: Features/Onboarding/Views/InterventionLevelOnboardingView.swift

import SwiftUI

enum InterventionMode: String, CaseIterable, Identifiable {
    case insight
    case acompanamiento
    case pausaConsciente

    var id: String { rawValue }

    var title: String {
        switch self {
        case .insight: return "Insight"
        case .acompanamiento: return "Acompañamiento"
        case .pausaConsciente: return "Pausa consciente"
        }
    }

    var iconName: String {
        switch self {
        case .insight: return "eye"
        case .acompanamiento: return "bell"
        case .pausaConsciente: return "pause.circle"
        }
    }

    var description: String {
        switch self {
        case .insight:
            return "Observa tu uso con insights claros sobre patrones diarios, sin notificaciones ni interrupciones."
        case .acompanamiento:
            return "Recibe 1–2 notificaciones suaves al día cuando se detectan patrones repetidos. Nada agresivo."
        case .pausaConsciente:
            return "Invitaciones breves a pausar antes de abrir apps que elijas. Sin bloqueos ni esperas forzadas."
        }
    }

    // Longer, more detailed text for the inline detail view
    var detailText: String {
        switch self {
        case .insight:
            return "Recibirás resúmenes y visualizaciones de tu uso: horas más activas, apps principales y tendencias semanales. No enviaremos notificaciones; es solo información para que tomes decisiones conscientes."
        case .acompanamiento:
            return "Opcionalmente recibirás pequeñas notificaciones cuando detectemos patrones repetidos que quieras cambiar. Por ejemplo: sugerencias para tomar descansos si pasas mucho tiempo seguido en redes. Siempre suaves y configurables."
        case .pausaConsciente:
            return "Antes de abrir ciertas apps recibirás una invitación breve para pausar (p. ej. 10–15 s) y reconsiderar si quieres continuar. Puedes omitirla y entrar de inmediato si lo deseas."
        }
    }
}

struct InterventionLevelOnboardingView: View {
    // Bind to parent's selection so it persists across navigation (like age/goal)
    @Binding var selectedMode: InterventionMode?

    // Callbacks for parent navigation (optional)
    var onBack: (() -> Void)? = nil
    var onContinue: ((InterventionMode) -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            // Scroll area with cards. No titles at the top (user requested no titles).
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    Spacer().frame(height: 8)

                    VStack(spacing: 20) {
                        ForEach(InterventionMode.allCases) { mode in
                            VStack(spacing: 8) {
                                InterventionCard(mode: mode, isSelected: selectedMode == mode)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.18)) {
                                            // toggle selection
                                            if selectedMode == mode {
                                                selectedMode = nil
                                            } else {
                                                selectedMode = mode
                                            }
                                        }
                                    }

                                // Show a detail for every selected card
                                if selectedMode == mode {
                                    InterventionDetail(mode: mode)
                                        .transition(.move(edge: .bottom).combined(with: .opacity))
                                        .animation(.easeInOut(duration: 0.25), value: selectedMode)
                                }
                            }
                        }
                    }
                    .padding(.top, 6)

                    Spacer(minLength: 8)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
            }
            .background(Color(UIColor.systemBackground))

            // Buttons stay OUTSIDE the scroll area
            HStack(spacing: 12) {
                Button(action: { onBack?() }) {
                    Text("Atrás")
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(UIColor.systemGray4))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }

                Button(action: {
                    guard let mode = selectedMode else { return }
                    onContinue?(mode)
                }) {
                    Text("Continuar")
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(selectedMode != nil ? DSColor.accentPrimary : Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(selectedMode == nil)
            }
            .padding(16)
            .background(Color(UIColor.systemBackground))
        }
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .contain)
    }
}

private struct InterventionCard: View {
    let mode: InterventionMode
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Selection indicator (left)
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

            // Texts (take full width) — we removed the icon from here so it doesn't affect height
            VStack(alignment: .leading, spacing: 6) {
                Text(mode.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(DSColor.textPrimary)

                Text(mode.description)
                    .font(.subheadline)
                    .foregroundColor(DSColor.textSecondary)
                    .lineLimit(4)
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        // Stroke for selection
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? DSColor.accentPrimary : Color.clear, lineWidth: isSelected ? 1.5 : 0)
        )
        // Small icon badge in the top-right corner so it doesn't affect layout height
        .overlay(alignment: .topTrailing) {
            Image(systemName: mode.iconName)
                .foregroundColor(DSColor.accentPrimary)
                .padding(8)                                
                .padding([.top, .trailing], 6)
        }
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .shadow(color: isSelected ? DSColor.accentPrimary.opacity(0.12) : Color.clear, radius: isSelected ? 8 : 0, x: 0, y: 2)
        .animation(.spring(response: 0.28, dampingFraction: 0.7), value: isSelected)
    }
}

// Generic detail view shown inline below the selected card for any mode
private struct InterventionDetail: View {
    let mode: InterventionMode

    var body: some View {
        VStack(spacing: 12) {
            Rectangle()
                .fill(Color(UIColor.systemGray5))
                .frame(height: 160)
                .cornerRadius(12)

            Text(mode.detailText)
                .font(.body)
                .foregroundColor(DSColor.textPrimary)
                .multilineTextAlignment(.leading)

            // Small note common to all modes
            Text("Puedes cambiar esta preferencia en cualquier momento desde Perfil.")
                .font(.footnote)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.secondarySystemBackground)))
        .padding(.horizontal, 4)
    }
}

struct InterventionLevelOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView { InterventionLevelOnboardingView(selectedMode: .constant(nil)) }
                .preferredColorScheme(.light)

            NavigationView { InterventionLevelOnboardingView(selectedMode: .constant(.pausaConsciente)) }
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
