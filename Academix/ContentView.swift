//
//  ContentView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }
            .tag(1)
            NavigationView {
                FriendsView()
            }
            .tabItem {
                    Image(systemName: "person.2")
                    Text("Friends")
            }
            .tag(2)
            NavigationView {
                PlanView()
            }
            .tabItem {
                    Image(systemName: "calendar")
                    Text("Plan")
            }
            .tag(3)
            NavigationView {
                MeView()
            }
            .tabItem {
                    Image(systemName: "person.circle")
                    Text("Me")
            }
            .tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
