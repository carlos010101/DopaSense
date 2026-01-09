//
//  OnboardingView.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import SwiftUI
import Combine

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @AppStorage("onboardingCompleted") private var onboardingCompleted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Bienvenido a DopaSense")
                // Placeholders para campos obligatorios
                Picker("Rango de edad", selection: $viewModel.ageRange) {
                    Text("18-24").tag(1)
                    // Etc.
                }
                Picker("Objetivo principal", selection: $viewModel.objective) {
                    Text("Menos redes").tag(0)
                    // Etc.
                }
                // Opcionales: Checklist, horario
                Button("Completar") {
                    onboardingCompleted = true // Futuro: Save data
                }
            }
            .navigationTitle("Onboarding")
        }
    }
}

class OnboardingViewModel: ObservableObject {
    @Published var ageRange: Int = 0
    @Published var objective: Int = 0
    // Futuro: Publishers Combine para validación
    
    private var cancellables = Set<AnyCancellable>()
}

// Preview
#Preview {
    OnboardingView()
}
