//
//  OnboardingView.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import SwiftUI
import Combine


// MARK: - Basic Info Onboarding View

struct BasicInfoView: View {

    @State private var selectedAge: String? = nil
    @State private var selectedGoal: String? = nil

    // Staged appearance states
    @State private var showTitle: Bool = false
    @State private var showSubtitle: Bool = false
    @State private var showAgeSection: Bool = false

    // New: track current internal step (1..totalSteps)
    @State private var step: Int = 1
    @State private var transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))

    // Track which steps have been configured (immutable once set)
    @State private var configuredSteps: Set<Int> = []

    // Intervention selection for step 3
    @State private var selectedIntervention: InterventionMode? = nil

    // Interests for step 4
    @State private var selectedInterests: Set<String> = []

    let totalSteps: Int = 5
    let ageRanges = ["18-24", "25-34", "35-44", "45-54", "55+"]
    // Goal options for GoalCardGroup
    let goalOptions: [GoalCardGroup.GoalOption] = [
        .init(key: "menos_redes", title: "📱 Menos redes", description: "Reduce el tiempo en redes y gana más calma y presencia en tu día."),
        .init(key: "productividad", title: "🎯 Mayor productividad", description: "Menos distracciones, más enfoque para lo que realmente importa."),
        .init(key: "mejor_sueno", title: "🌙 Mejorar sueño", description: "Descansa mejor dejando el teléfono a un lado por las noches."),
        .init(key: "uso_consciente", title: "🧠 Uso más consciente", description: "Entiende tu uso del teléfono y crea hábitos más equilibrados.")
    ]
    let goals = [
        "Menos redes",
        "Más enfoque",
        "Mejor sueño",
        "Uso más consciente"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // Progress stepper (Duolingo-like) now tappable
            ProgressStepper(total: totalSteps, current: currentStep, configured: configuredSteps) { tapped in
                // only allow tapping to steps that are already configured
                setStep(to: tapped, requireConfigured: true)
            }
            .padding(.top, 8)
            .opacity(showTitle ? 1 : 0)
            .offset(y: showTitle ? 0 : 6)
            .animation(.easeInOut(duration: 0.6), value: showTitle)

            if step != 5 {
                Text("Personalicemos tu experiencia")
                    .font(.title)
                    .fontWeight(.semibold)
                    .opacity(showTitle ? 1 : 0)
                    .offset(y: showTitle ? 0 : 8)
                    .animation(.easeInOut(duration: 0.6), value: showTitle)
            }

            if step != 5  {
                Text("Elige lo básico para personalizar tu experiencia.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .opacity(showSubtitle ? 1 : 0)
                    .offset(y: showSubtitle ? 0 : 8)
                    .animation(.easeInOut(duration: 0.6), value: showSubtitle)
            }

            // Sliding content area: shows only the current step and uses the dynamic transition
            ZStack {
                // Step 1: Age selection
                if step == 1 {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rango de edad")
                            .font(.headline)

                        // Use reusable radio button group instead of a segmented picker
                        RadioButtonGroup(items: ageRanges, selection: $selectedAge, axis: .vertical)

                        Spacer()

                        // Helper text
                        Text(selectedAge == nil ? "Selecciona para continuar." : "Edad seleccionada: \(selectedAge!)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.top, 6)

                        // Continue button to advance to next step
                        Button {
                            guard selectedAge != nil else { return }
                            // mark this step configured and advance
                            configuredSteps.insert(1)
                            setStep(to: min(step + 1, totalSteps))
                        } label: {
                            Text("Continuar")
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(selectedAge != nil ? DSColor.accentPrimary : Color.gray.opacity(0.4))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .disabled(selectedAge == nil)
                        .padding(.top, 6)
                    }
                    .padding(.top, 6)
                    .transition(transition)
                    .opacity(showAgeSection ? 1 : 0)
                    .offset(y: showAgeSection ? 0 : 10)
                    .animation(.easeInOut(duration: 0.6), value: showAgeSection)
                }

                // Step 2: Goal selection
                if step == 2 {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Objetivo principal")
                            .font(.headline)

                        // Use GoalCardGroup for single-selection card UI
                        GoalCardGroup(items: goalOptions, selection: $selectedGoal)

                        Spacer()

                        // Back + Continue row: show Back on steps > 1 (including step 2)
                        HStack(spacing: 12) {
                            Button(action: { setStep(to: max(step - 1, 1)) }) {
                                Text("Atrás")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                                    .background(Color(UIColor.systemGray4))
                                    .foregroundColor(.primary)
                                    .cornerRadius(12)
                            }

                            // Final continue button (only enabled when a goal is selected)
                            Button {
                                guard selectedGoal != nil else { return }
                                // mark this step configured and advance
                                configuredSteps.insert(2)
                                setStep(to: min(step + 1, totalSteps))
                            } label: {
                                Text("Continuar")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                                    .background(selectedGoal != nil ? DSColor.accentPrimary : Color.gray.opacity(0.4))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .disabled(selectedGoal == nil)
                        }
                        .padding(.top, 6)
                    }
                    .padding(.top, 6)
                    .transition(transition)
                    .animation(.easeInOut(duration: 0.6), value: step)
                }

                // Step 3: Intervention mode selection (integrated view)
                if step == 3 {
                    InterventionLevelOnboardingView(selectedMode: $selectedIntervention, onBack: {
                        // go back to goals
                        setStep(to: 2)
                    }, onContinue: { mode in
                        // ensure parent persists selection, mark configured and advance
                        selectedIntervention = mode
                        configuredSteps.insert(3)
                        setStep(to: 4)
                    })
                    .transition(transition)
                }

                // Step 4: Interests selection integrated
                if step == 4 {
                    InterestsSelectionScreen(selections: $selectedInterests, onBack: {
                        // go back to intervention step
                        setStep(to: 3)
                    }, onContinue: { selections in
                        // ensure configured and advance to final step
                        if !selections.isEmpty {
                            configuredSteps.insert(4)
                        }
                        setStep(to: 5)
                    })
                    .transition(transition)
                    .onChange(of: selectedInterests) { new in
                        // mark this onboarding step configured as soon as at least one is selected
                        if !new.isEmpty { configuredSteps.insert(4) }
                        else { configuredSteps.remove(4) }
                    }
                }

                // Step 5: Informational Screen Time permissions screen (final step)
                if step == 5 {
                    // Informational-only view: no permission requests or APIs called here.
                    ScreenTimePermissionOnboardingView(onContinue: {
                        // Mark this step configured. The app's coordinator or parent should
                        // handle finishing onboarding and navigating to Home.
                        configuredSteps.insert(5)
                        // Optionally, you could call a delegate or change an environment value here
                        // to dismiss the onboarding. Keeping it minimal per instructions.
                    })
                    .padding(.top, 6)
                    .transition(transition)
                }

            }
            .animation(.easeInOut, value: step)

        }
        .padding(24)
        // Hide the visible navigation bar but keep the native back-swipe gesture.
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            // Staggered appearance (slower): title -> subtitle -> age
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                withAnimation(.easeInOut(duration: 0.6)) { showTitle = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.70) {
                withAnimation(.easeInOut(duration: 0.6)) { showSubtitle = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.30) {
                withAnimation(.easeInOut(duration: 0.6)) { showAgeSection = true }
            }
        }
    }

    private var currentStep: Int { step }

    // Helper to set the step and compute a transition based on direction
    private func setStep(to newStep: Int, requireConfigured: Bool = false) {
        guard newStep != step, newStep >= 1, newStep <= totalSteps else { return }
        // If navigation requested via stepper taps, require that the destination is already configured
        if requireConfigured && !configuredSteps.contains(newStep) {
            return
        }
        // If moving forward, new content should come from the right -> insertion from trailing
        if newStep > step {
            transition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
        } else {
            // moving backward: new content comes from the left
            transition = .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
        }
        withAnimation(.easeInOut) {
            step = newStep
        }
    }
}


// Progress stepper component
private struct ProgressStepper: View {
    let total: Int
    let current: Int
    let configured: Set<Int>
    var onTap: ((Int) -> Void)? = nil

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...total, id: \.self) { index in
                let isCurrent = index == current
                let isConfigured = configured.contains(index)
                Capsule()
                    .fill(isCurrent ? DSColor.accentPrimary : (isConfigured ? DSColor.accentSecondary : Color(UIColor.systemGray5)))
                    .frame(maxWidth: .infinity)
                    .frame(height: 8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onTap?(index)
                    }
                    .animation(.easeInOut, value: current)
            }
        }
        .frame(height: 8)
        .clipShape(Capsule())
    }
}

// Placeholder next screen
private struct NextOnboardingView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Siguiente paso de onboarding")
                .font(.system(.title, design: .default))
                .fontWeight(.semibold)
            Text("Aquí irá el siguiente paso.")
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .navigationTitle("Onboarding")
    }
}

// Previews
struct BasicInfoOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicInfoView()
                .preferredColorScheme(.light)

            BasicInfoView()
                .preferredColorScheme(.dark)
        }
    }
}
