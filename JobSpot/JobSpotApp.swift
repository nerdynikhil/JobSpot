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
            SplashView()
                .environmentObject(authManager)
                .environmentObject(jobManager)
        }
    }
}
