//
//  ActiveSessionModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import Foundation

struct ActiveSessionModel: Codable {
    let id: String
    let accessToken: String
    let sessionID: String
    let baseUrl: String
}