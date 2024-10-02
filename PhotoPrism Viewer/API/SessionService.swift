//
//  SessionService.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case incorrectParseType
}


class SessionService: ObservableObject {
    var activeSession: ActiveSessionModel? {
        UserDefaults.standard.getSession()
    }
    
    init (){
//        UserDefaults.standard.removeObject(forKey: "PhotoPrismSession")
    }
    
    func createSession(loginDetails: LoginModel) async throws -> ActiveSessionModel {
        if let activeSes = activeSession {
            return activeSes
        }
    
        let baseURL = loginDetails.baseURL
        let url =  "\(baseURL)/api/v1/session"
    
        guard let validURL = URL(string: url) else { throw APIError.invalidURL }
        var request = URLRequest(url:  validURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let body: [String: String] = [ "username" : loginDetails.username, "password" : loginDetails.password]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
    
        let (data, _) =  try await URLSession.shared.data(for: request)
        
        let decodedData = try JSONDecoder().decode(SessionResponse.self, from: data)
        
        let newActiveSession = ActiveSessionModel(
                id: decodedData.id,
                accessToken: decodedData.access_token,
                downloadToken: decodedData.config.downloadToken,
                previewToken: decodedData.config.previewToken,
                sessionID: decodedData.session_id,
                baseUrl: baseURL,
                expiresAt: decodedData.expires_in
        )
         
        UserDefaults.standard.setSession(newActiveSession)
        
        return newActiveSession
    }
}

