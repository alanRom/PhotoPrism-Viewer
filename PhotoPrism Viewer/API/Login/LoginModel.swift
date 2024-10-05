//
//  LoginModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import Foundation

struct LoginModel: Codable {
    var username: String = ""
    var password: String = ""
    var baseURL: String = ""
    var token: String?
}

struct LoginWithoutPasswordModel: Codable, Identifiable {
    var id: String { baseURL + username}
    
    var username: String = ""
    var baseURL: String = ""
}


