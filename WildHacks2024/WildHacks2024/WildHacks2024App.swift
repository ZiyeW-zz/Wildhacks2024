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
                    print("After fetchPersonaData, tempPersona is: \(tempPersona)")
                    
                }
        }
    }
    struct UserResponse: Codable {
        var user_id: String
        var email: String
        var persona: String
    }
    
    func fetchPersonaData() async {
        guard let url = URL(string: "http://127.0.0.1:5000/get-user/123") else {
            print("Invalid URL")
            return
        }
    
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // For debugging: print the received raw data as a string.
            if let rawDataString = String(data: data, encoding: .utf8) {
                print("Received raw data: \(rawDataString)")
            }
            
            // Decode the JSON data into your Swift struct.
            let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.tempPersona = decodedResponse.persona
                print("Fetched Persona: \(self.tempPersona)")
            }
        }
        catch {
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
    
