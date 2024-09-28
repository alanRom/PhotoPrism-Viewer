//
//  LoginViewModel.swift
//  PhotoPrism Viewer
//
//  Created by Alan Romano on 9/28/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var baseURL: String = ""
 
    func login( with sessionService: SessionService) {
        
    }
    
}
