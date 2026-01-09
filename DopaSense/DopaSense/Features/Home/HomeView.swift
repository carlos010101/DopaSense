//
//  HomeView.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("Home")
        }
        .onAppear {
            // Futuro: viewModel.loadData()
        }
    }
}

class HomeViewModel: ObservableObject {
    @Published var mode: Mode = .insight // Placeholder
    @Published var isEmpty: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    // Futuro: Lógica con Combine
}

enum Mode: String {
    case insight, accompaniment, consciousPause
}

// Preview
#Preview {
    HomeView()
}
