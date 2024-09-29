//
//  LoginViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username: String
    @Published var password: String
    @Published var baseURL: String
    init() {
        let env = ProcessInfo.processInfo.environment
        self.username = env["DEV_USERNAME"] ?? ""
        self.password = env["DEV_PASSWORD"] ?? ""
        self.baseURL = env["DEV_URL"] ?? ""
    }
 
    func login( with sessionService: SessionService) {
        let loginDetails = LoginModel(username: username, password: password, baseURL: baseURL, token: nil)
        print(loginDetails)
        Task {
            do {
                try await sessionService.createSession(loginDetails: loginDetails)
            } catch {
                print("Login error: \(error)")
            }
        }
        
        
    }
    
}
