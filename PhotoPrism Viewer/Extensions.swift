//
//  Extensions.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/27/24.
//

import Foundation

typealias CGOffset = CGSize

extension CGOffset {
    static func +(lhs: CGOffset, rhs: CGOffset) -> CGOffset {
        CGOffset(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    static func +=(lhs: inout CGOffset, rhs: CGOffset) {
        lhs = lhs + rhs
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
