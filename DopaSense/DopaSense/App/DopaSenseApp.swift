//
//  DopaSenseApp.swift
//  DopaSense
//
//  Created by Administrador on 1/5/26.
//

import SwiftUI
import Combine

@main
struct DopaSenseApp: App {
    @AppStorage("onboardingCompleted") private var onboardingCompleted: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !onboardingCompleted {
                LaunchTransitionView {
                    IntroView()
                }
            } else {
                AppTabView()
                    .onAppear {
                        onboardingCompleted = false
                    }
            }
        }
    }
}
