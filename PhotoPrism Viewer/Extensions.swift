//
//  Extensions.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/27/24.
//

import SwiftUI

typealias CGOffset = CGSize

extension CGOffset {
    static func +(lhs: CGOffset, rhs: CGOffset) -> CGOffset {
        CGOffset(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    static func +=(lhs: inout CGOffset, rhs: CGOffset) {
        lhs = lhs + rhs
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                       options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                  return nil
               }

        return prettyJSON
    }
}

private var PhotoPrismSessionKey: String { "PhotoPrismSession" }
private var PhotoPrismRecentSessionsKey: String { "PhotoPrismRecentSessions" }
private let MAX_RECENT_SESSIONS = 5;
extension UserDefaults {
    //MARK: - Session
    func getSession() -> ActiveSessionModel? {
        if let jsonData = data(forKey: PhotoPrismSessionKey),
           let decodedSession = try? JSONDecoder().decode(ActiveSessionModel.self, from: jsonData) {
            return decodedSession
        } else {
            return nil
        }
    }
    
    func setSession(_ activeSession: ActiveSessionModel) {
        let data = try? JSONEncoder().encode(activeSession)
        set(data, forKey: PhotoPrismSessionKey)
    }
    
    func clearSession() {
        removeObject(forKey: PhotoPrismSessionKey)
    }
    
    //MARK: - Recent Sessions
    func getRecentSessions() -> [LoginWithoutPasswordModel] {
        
        
        if let jsonData = data(forKey: PhotoPrismRecentSessionsKey),
           let decodedSessions = try? JSONDecoder().decode([LoginWithoutPasswordModel].self, from: jsonData) {
            return decodedSessions
        } else {
            return []
        }
    }
    
    func addRecentSession(_ login: LoginModel) -> Void {
        let recentSession = LoginWithoutPasswordModel(username: login.username, baseURL: login.baseURL)
        var decodedSessions: [LoginWithoutPasswordModel]
        if let jsonData = data(forKey: PhotoPrismRecentSessionsKey) {
            do {
                decodedSessions = try JSONDecoder().decode([LoginWithoutPasswordModel].self, from: jsonData)
                if decodedSessions.contains(where: { model in
                    model.baseURL == login.baseURL && model.username == login.username
                }){
                    return
                }
            }
            catch {
                decodedSessions = []
            }
        } else {
            decodedSessions = []
        }
        
        decodedSessions.append(recentSession)
        let data = try? JSONEncoder().encode(decodedSessions)
        set(data, forKey: PhotoPrismRecentSessionsKey)
    }
    
    func clearRecentSessions() {
        removeObject(forKey: PhotoPrismRecentSessionsKey)
    }
    
}

public extension Binding {

    static func convert<TInt, TFloat>(_ intBinding: Binding<TInt>) -> Binding<TFloat>
    where TInt:   BinaryInteger,
          TFloat: BinaryFloatingPoint{

        Binding<TFloat> (
            get: { TFloat(intBinding.wrappedValue) },
            set: { intBinding.wrappedValue = TInt($0) }
        )
    }

    static func convert<TFloat, TInt>(_ floatBinding: Binding<TFloat>) -> Binding<TInt>
    where TFloat: BinaryFloatingPoint,
          TInt:   BinaryInteger {

        Binding<TInt> (
            get: { TInt(floatBinding.wrappedValue) },
            set: { floatBinding.wrappedValue = TFloat($0) }
        )
    }
}
