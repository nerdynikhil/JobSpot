//
//  ContentView.swift
//  JobSpot
//
//  Created by Nikhil Barik on 02/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            JobListView()
                .tabItem {
                    Image(systemName: "briefcase.fill")
                    Text("Jobs")
                }
            CompanyGridView()
                .tabItem {
                    Image(systemName: "building.2.fill")
                    Text("Companies")
                }
            MessagingView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Messages")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
}
