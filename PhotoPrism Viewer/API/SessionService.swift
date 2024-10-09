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

@Observable
class SessionService {
    var activeSession: ActiveSessionModel?
    
    init (){
//        UserDefaults.standard.clearSession()
        activeSession = UserDefaults.standard.getSession()
    }
    
    func endSession() {
        activeSession = nil
        UserDefaults.standard.clearSession()
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
        print(decodedData)
        let previewToken = decodedData.config.previewToken
        let thumbnailSize = "tile_224"
        let thumbnailURL = "\(baseURL)/api/v1/t/\(decodedData.user.Thumb)/\(previewToken)/\(thumbnailSize)"
        
        let newActiveSession = ActiveSessionModel(
                id: decodedData.id,
                accessToken: decodedData.access_token,
                downloadToken: decodedData.config.downloadToken,
                previewToken: previewToken,
                sessionID: decodedData.session_id,
                baseUrl: baseURL,
                expiresAt: decodedData.expires_in,
                user: decodedData.user,
                userThumbnail: thumbnailURL
        )
         
        UserDefaults.standard.setSession(newActiveSession)
        UserDefaults.standard.addRecentSession(loginDetails)
        activeSession = newActiveSession
        
        return newActiveSession
    }
}

