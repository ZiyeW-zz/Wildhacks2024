//
//  AuthClass.swift
//  WildHacks2024
//
//  Created by Ziye Wang on 4/6/24.
//

import SwiftUI
import Foundation
import Combine

class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    
    func login(username: String, password: String) {
        // Implement your login logic here
        // This is just a placeholder for demonstration
        self.isAuthenticated = true
    }
    
    func logout() {
        self.isAuthenticated = false
    }
}

