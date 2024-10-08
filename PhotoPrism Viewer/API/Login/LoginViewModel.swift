//
//  LoginViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import SwiftUI

@Observable
class LoginViewModel  {
    var loginDetails: LoginModel
    
    init() {
        let env = ProcessInfo.processInfo.environment
        let username = env["DEV_USERNAME"] ?? ""
        let password = env["DEV_PASSWORD"] ?? ""
        let baseURL = env["DEV_URL"] ?? ""
        self.loginDetails = LoginModel(username: username, password: password, baseURL: baseURL)
    }
 
    func login( with sessionService: SessionService) async throws -> ActiveSessionModel {
        return try await sessionService.createSession(loginDetails: loginDetails)
         
    }
    
    var recentSessions: [LoginWithoutPasswordModel] {
//        return [
//            LoginWithoutPasswordModel(username: "user", baseURL: "https://test.com"),
//            LoginWithoutPasswordModel(username: "user2", baseURL: "https://hello.com")
//        ]
        UserDefaults.standard.getRecentSessions()
    }
    
    func setRecentSession(_ session: LoginWithoutPasswordModel){
        loginDetails.baseURL = session.baseURL
        loginDetails.username = session.username
    }
    
    
}
