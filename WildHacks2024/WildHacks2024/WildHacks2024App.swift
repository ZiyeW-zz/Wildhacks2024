//
//  WildHacks2024App.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/1/24.
//

import SwiftUI

@main
struct WildHacks2024App: App {
    @StateObject var authManager = AuthService()
    let tempUser = "meefy101"

    
    var body: some Scene {
        WindowGroup{
            if authManager.isAuthenticated {
                HomepageView(spotifyUser: tempUser).environmentObject(authManager)
            } else {
                LoginSignUp().environmentObject(authManager)
            }
        }
    }
}

    
    
