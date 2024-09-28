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

struct LoginDetails {
    let username: String
    let password: String
    let token: String?
}

private var userDefaultsKey: String { "PhotoPrismSession" }

extension UserDefaults {
    func getSession() -> ActiveSessionModel? {
        if let jsonData = data(forKey: userDefaultsKey),
           let decodedPalettes = try? JSONDecoder().decode(ActiveSessionModel.self, from: jsonData) {
            return decodedPalettes
        } else {
            return nil
        }
    }
    
    func setSession(_ activeSession: ActiveSessionModel) {
        let data = try? JSONEncoder().encode(activeSession)
        set(data, forKey: userDefaultsKey)
    }
}

class SessionService: ObservableObject {
    var activeSession: ActiveSessionModel? {
        UserDefaults.standard.getSession()
    }

    func createSession(for baseURL: String, loginDetails: LoginDetails) async throws -> ActiveSessionModel {
            if let activeSes = activeSession {
                return activeSes
            }
        
            let url =  "\(baseURL)/api/v1/session" 
        
            guard let validURL = URL(string: url) else { throw APIError.invalidURL }
            var request = URLRequest(url:  validURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            let body: [String: Any] = [ "username" : loginDetails.username, "password" : loginDetails.password]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        
            let (data, _) =  try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(SessionResponse.self, from: data)
                
            
        let newActiveSession = ActiveSessionModel(
                id: decodedData.id,
                accessToken: decodedData.accessToken,
                sessionID: decodedData.sessionID,
                baseUrl: baseURL
        )
         
        UserDefaults.standard.setSession(newActiveSession)
        
        return newActiveSession
    }
}

