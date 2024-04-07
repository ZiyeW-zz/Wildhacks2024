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
    @State private var tempUser = "meefy101"
    @State private var tempPersona = "study"

    var body: some Scene {
        WindowGroup {
            APIConnection(authManager: authManager, tempUser: tempUser, tempPersona: $tempPersona)
                .task {
                    await fetchPersonaData()
                    print("After fetchPersonaData, tempUser is: \(tempUser)")

                }
        }
    }
    
    func fetchPersonaData() async {
        guard let url = URL(string: "http://127.0.0.1:9090/get-persona") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // Convert data to a string
            if let personaString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    // Update the state variable
                    self.tempPersona = personaString
                    // Debug print to verify
                    print("Fetched Persona: \(personaString)")
                }
            }
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}

struct APIConnection: View {
    @ObservedObject var authManager: AuthService
    let tempUser: String
    @Binding var tempPersona: String

    var body: some View {
        if authManager.isAuthenticated {
            HomepageView(spotifyUser: tempUser, UserPersona: tempPersona)
                .environmentObject(authManager)
        } else {
            LoginSignUp()
                .environmentObject(authManager)
        }
    }
}

//import SwiftUI
//
//@main
//struct WildHacks2024App: App {
//    @StateObject var authManager = AuthService()
//    let tempUser = "meefy101"
//    let tempPersona = "study"
//
//    
//    var body: some Scene {
//        WindowGroup{
//            if authManager.isAuthenticated {
//                HomepageView(spotifyUser: tempUser, UserPersona: tempPersona).environmentObject(authManager)
//            } else {
//                LoginSignUp().environmentObject(authManager)
//            }
//        }
//        
//        }
//        .task {
//            await fetchPersonaData()
//    }
//    
//    func fetchPersonaData() async {
//        guard let url = URL(string: "https://127.0.0.1:9090/get-persona") else {
//            print("hey this  url doesn't work")
//            return
//        }
//    }
//}
//
//    
    
