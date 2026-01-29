//
//  IntroAuthView.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import SwiftUI
import AuthenticationServices

struct IntroAuthView: View {
    @State private var showOnboarding = false
    
    var body: some View {
        VStack(spacing: 12) {

            SignInWithAppleButton(
                .signIn,
                onRequest: { _ in },
                onCompletion: { _ in }
            )
            .signInWithAppleButtonStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .cornerRadius(14)

            DSButton(title: "Continuar con email") {
                // Acción para continuar con correo electrónico aqu
                self.showOnboarding = true
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            
            DSInlineLink(leadingText: "¿Ya tienes una cuenta?", linkText: "Inicia sesión") {
                // Acción al tocar "Inicia sesión"
                // e.g. navigate to login screen
            }
            .padding(.top, 8)
            
        }
        .navigationDestination(isPresented: $showOnboarding) {
            BasicInfoView()
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
    }
}

#Preview("Light") {
    ZStack {
        DSColor.backgroundPrimary
            .ignoresSafeArea()

        IntroAuthView()
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    ZStack {
        DSColor.backgroundPrimary
            .ignoresSafeArea()

        IntroAuthView()
    }
}
