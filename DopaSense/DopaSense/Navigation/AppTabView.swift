//
//  AppTabView.swift
//  DopaSense
//
//  Created by Administrador on 1/9/26.
//

import SwiftUI
import Combine

struct AppTabView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.home)                        
                        
        }
    }
    
    enum Tab {
        case home, progress, learn, profile
    }
}

// Preview
#Preview {
    AppTabView()
}
