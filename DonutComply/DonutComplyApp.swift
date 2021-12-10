//
//  DonutComplyApp.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI
import FirebaseCore

@main
struct DonutComplyApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
