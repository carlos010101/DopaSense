//
//   ScreenTimePermissionOnboardingView.swift
//  DopaSense
//
//  Created by Administrador on 1/28/26.
//

import SwiftUI

struct ScreenTimePermissionOnboardingView: View {
    let onContinue: () -> Void
    @State private var appear: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Use a ScrollView that fills the available space so text can wrap and scroll on smaller devices
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // Illustration: use the provided asset instead of the rectangle placeholder
                    Image("permission_image")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .accessibilityLabel(Text("Ilustración sobre el uso consciente del teléfono"))
                        .opacity(appear ? 1 : 0)
                        .offset(y: appear ? 0 : 8)
                        .animation(.easeOut(duration: 0.4), value: appear)

                    Text("Un último paso para empezar")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .opacity(appear ? 1 : 0)
                        .offset(y: appear ? 0 : 6)
                        .animation(.easeOut(duration: 0.35).delay(0.05), value: appear)
                        .padding(.horizontal, 24)
                        // Ensure content is top-weighted inside the scroll area
                        .frame(maxWidth: .infinity, alignment: .top)

                    Text("Para ver insights sobre tus patrones de uso, permite acceso a Screen Time agregado (sin detalles privados). Todo local y voluntario.")
                        .font(.body)
                        .foregroundColor(Color.primary.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        // Make sure the explanatory text can grow and wrap instead of being truncated
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(1)
                        .opacity(appear ? 1 : 0)
                        .offset(y: appear ? 0 : 6)
                        .animation(.easeOut(duration: 0.35).delay(0.10), value: appear)
                        .padding(.horizontal, 24)
                        // Ensure content is top-weighted inside the scroll area
                        .frame(maxWidth: .infinity, alignment: .top)

                    Text("Es completamente voluntario. Puedes continuar sin activarlo y hacerlo más tarde desde Perfil.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .opacity(appear ? 1 : 0)
                        .animation(.easeOut(duration: 0.3).delay(0.15), value: appear)
                        .padding(.horizontal, 24)
                        // Ensure content is top-weighted inside the scroll area
                        .frame(maxWidth: .infinity, alignment: .top)
                }
            }
            // Make the scroll area expand to available space so the buttons remain visible
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Buttons remain pinned at the bottom of the screen
            VStack(spacing: 12) {
                DSButton(title: "Continuar") {                    
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .padding(.horizontal, 24)

                Button(action: { onContinue() }) {
                    Text("Más tarde")
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .foregroundColor(Color.primary)
                        .background(Color.clear)
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .ignoresSafeArea(edges: .bottom)
        .onAppear { withAnimation { appear = true } }
    }
}

// Local button style providing a subtle scale effect on press
private struct PrimaryScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
