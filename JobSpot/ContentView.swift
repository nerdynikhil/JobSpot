//
//  ContentView.swift
//  JobSpot
//
//  Created by Nikhil Barik on 02/07/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var jobManager: JobManager
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            JobListView()
                .tabItem {
                    Image(systemName: "briefcase")
                    Text("Jobs")
                }
            CompanyGridView()
                .tabItem {
                    Image(systemName: "building.2")
                    Text("Companies")
                }
            MessagingView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Messages")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationManager())
        .environmentObject(JobManager())
}
