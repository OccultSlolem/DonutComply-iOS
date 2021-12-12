//
//  DonutComplyApp.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI
import Firebase

@main
struct DonutComplyApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    @StateObject var session = SessionStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
                .onAppear {
                    session.listen()
                }
        }
    }
}

// Connect Firebase
class Delegate : NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
