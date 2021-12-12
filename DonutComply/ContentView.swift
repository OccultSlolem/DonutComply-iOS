//
//  ContentView.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        TabView {
            FeaturedArticleView()
            .tabItem {
                    Label("Featured", systemImage: "star.fill")
                }
            
            MapUIView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            
            Text("Bookmarked")
                .tabItem {
                    Label("Bookmarked", systemImage: "bookmark.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(session)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(Colors.aventurine)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Colors.duskyViolet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
