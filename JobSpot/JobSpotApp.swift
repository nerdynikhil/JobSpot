//
//  JobSpotApp.swift
//  JobSpot
//
//  Created by Nikhil Barik on 02/07/25.
//

import SwiftUI

@main
struct JobSpotApp: App {
    @StateObject private var authManager = AuthenticationManager()
    @StateObject private var jobManager = JobManager()
    
    var body: some Scene {
        WindowGroup {
            if !authManager.hasSeenOnboarding {
                OnboardingView()
                    .environmentObject(authManager)
                    .environmentObject(jobManager)
            } else if !authManager.isAuthenticated {
                LoginView()
                    .environmentObject(authManager)
                    .environmentObject(jobManager)
            } else {
                ContentView()
                    .environmentObject(authManager)
                    .environmentObject(jobManager)
            }
        }
    }
}
