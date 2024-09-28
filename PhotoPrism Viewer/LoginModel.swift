//
//  LoginModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import Foundation

struct LoginModel: Codable {
    let username: String
    let password: String
    let baseURL: String
    let token: String?
}
