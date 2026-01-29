//
//  BottomOverlay.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import SwiftUI

struct BottomOverlay: View {
    var body: some View {
        LinearGradient(
            colors: [
                .clear,
                .black.opacity(0.7)
            ],
            startPoint: .center,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

