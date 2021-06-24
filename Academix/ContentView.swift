//
//  ContentView.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem({
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                })
            FriendsView()
                .tabItem({
                    VStack {
                        Image(systemName: "person.2")
                        Text("Friends")
                    }
                })
            PlanView()
                .tabItem({
                    VStack {
                        Image(systemName: "calendar")
                        Text("Plan")
                    }
                })
            MeView()
                .tabItem({
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Me")
                    }
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
